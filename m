Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283581AbRLDXbg>; Tue, 4 Dec 2001 18:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283583AbRLDXb0>; Tue, 4 Dec 2001 18:31:26 -0500
Received: from odin.allegientsystems.com ([208.251.178.227]:36480 "EHLO
	lasn-001.allegientsystems.com") by vger.kernel.org with ESMTP
	id <S283581AbRLDXbK>; Tue, 4 Dec 2001 18:31:10 -0500
Message-ID: <3C0D5CB6.1080600@optonline.net>
Date: Tue, 04 Dec 2001 18:31:02 -0500
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>
CC: Mario Mikocevic <mozgy@hinet.hr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810 audio patch
In-Reply-To: <3C0C16E7.70206@optonline.net> <3C0C508C.40407@redhat.com> <3C0C58DE.9020703@optonline.net> <3C0C5CB2.6000602@optonline.net> <3C0C61CC.1060703@redhat.com> <20011204153507.A842@danielle.hinet.hr> <3C0D1DD2.4040609@optonline.net> <3C0D223E.3020904@redhat.com> <3C0D350F.9010408@optonline.net> <3C0D3CF7.6030805@redhat.com> <3C0D4E62.4010904@optonline.net> <3C0D52F1.5020800@optonline.net> <3C0D5796.6080202@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford wrote:

> Yes, on underrun the DAC is stopped and dmabuf->enable is cleared. 
> That's clearly a bug in this case.  However, it should only cause your 
> problem if you are in fact getting an underrun.  Anyway, here's a 
> proposed fix you can try to see if that's what's causing the problem:

[snip]

That works.

