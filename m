Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283304AbRLDTEl>; Tue, 4 Dec 2001 14:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283163AbRLDTDO>; Tue, 4 Dec 2001 14:03:14 -0500
Received: from odin.allegientsystems.com ([208.251.178.227]:23424 "EHLO
	lasn-001.allegientsystems.com") by vger.kernel.org with ESMTP
	id <S283321AbRLDTCx>; Tue, 4 Dec 2001 14:02:53 -0500
Message-ID: <3C0D1DD2.4040609@optonline.net>
Date: Tue, 04 Dec 2001 14:02:42 -0500
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Mario Mikocevic <mozgy@hinet.hr>
CC: Doug Ledford <dledford@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810 audio patch
In-Reply-To: <3C0C16E7.70206@optonline.net> <3C0C508C.40407@redhat.com> <3C0C58DE.9020703@optonline.net> <3C0C5CB2.6000602@optonline.net> <3C0C61CC.1060703@redhat.com> <20011204153507.A842@danielle.hinet.hr>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mario Mikocevic wrote:

>modprobe produced an oops (17-pre2), module is left in init state :
>
Yep. In the i810_configure_clocking() function, immediately before the 
call to i810_set_dac_rate(), add a line "clocking = 48000;"

