Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283717AbRLED2t>; Tue, 4 Dec 2001 22:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283720AbRLED2j>; Tue, 4 Dec 2001 22:28:39 -0500
Received: from odin.allegientsystems.com ([208.251.178.227]:26753 "EHLO
	lasn-001.allegientsystems.com") by vger.kernel.org with ESMTP
	id <S283717AbRLED23>; Tue, 4 Dec 2001 22:28:29 -0500
Message-ID: <3C0D9456.6090106@optonline.net>
Date: Tue, 04 Dec 2001 22:28:22 -0500
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>
CC: Mario Mikocevic <mozgy@hinet.hr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810 audio patch
In-Reply-To: <3C0C16E7.70206@optonline.net> <3C0C508C.40407@redhat.com> <3C0C58DE.9020703@optonline.net> <3C0C5CB2.6000602@optonline.net> <3C0C61CC.1060703@redhat.com> <20011204153507.A842@danielle.hinet.hr> <3C0D1DD2.4040609@optonline.net> <3C0D223E.3020904@redhat.com> <3C0D350F.9010408@optonline.net> <3C0D3CF7.6030805@redhat.com> <3C0D4E62.4010904@optonline.net> <3C0D52F1.5020800@optonline.net> <3C0D5796.6080202@redhat.com> <3C0D5CB6.1080600@optonline.net> <3C0D5FC7.3040408@redhat.com> <3C0D77D9.70205@optonline.net> <3C0D8B00.2040603@optonline.net> <3C0D8F02.8010408@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford wrote:

> Two questions:
>
> 1) This is a timeout on close.  Does it work up until then? 

no - no audible output. (quake doesn't use SNDCTL_DSP_SYNC anywhere 
either so it would have to be on close)

>
>
> 2) Does the attached patch (against the 0.08 driver) help?

No - timeout printk still occurs

