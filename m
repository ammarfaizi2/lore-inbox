Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWDDQHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWDDQHv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 12:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWDDQHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 12:07:51 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:20168 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750730AbWDDQHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 12:07:50 -0400
From: <christian@scharff-home.de>
To: <linux-kernel@vger.kernel.org>
Cc: <christian@scharff-home.de>
Subject: EPIA-M: DMA & VT8235 Lock-up
Date: Tue, 4 Apr 2006 18:07:57 +0200
Message-ID: <17624747.9731144160783244.JavaMail.servlet@kundenserver>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Webmail
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Binford: 6100 (more power)
X-Originating-From: 31661542
X-Routing: DE
X-Message-Id: <31661542$1144160783243172.23.4.15714433154@pustefix157.kundenserver.de-2113841273>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:b77685ddbddf372e99c047856fb7fc81
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am writing to this list since I think solving this issue may have some
importance also to other Linux users.

Please CC me if you answer since I am not subscribed to this list!

Here is the issue:

I have severe lock-ups with Vias ME6000 motherboard with UDMA100
transfers. 

MY Hardaware: 

VIA EPIA ME6000 (VIA VT8235 south bridge)
512 MB DDR400 RAM (verified OK!)
Technotrend DVBs 1.5 card 
Intel Pro 1000 desktop ethernet card (e1000)
Linux Kernel 2.6.13
Bios: 1.16 
hard drive Samsung HM100JC (UDMA 100 capable)

I made some test copying some files back and forth on my HD

When I run this in dma4 and dma5 mode my systems stops working after a
while. 
With lower DMA modes or in PIO mode everything is fine. 
I tested already different 80 pin ATA cables, but the cable does not
solve the problem.

So the board or the drivers have a DMA issue.  

I am wondering if this can be fixed in the LINUX Kernel or if this is an
unsolved VT8235 hardware issue.

Lockups usually occur if there is also other traffic, like network
traffic.
Via seems to have a solution for its Windows drivers since it has been
reported that with a driver update in 2005 the issue was solved.

Others users report similar problems. See related thread here:

http://forums.viaarena.com/messageview.aspx?catid=28&threadid=60131&STAR
TPAGE=1&FTVAR_FORUMVIEWTMP=Linear

Are there any suggestions if this can be fixed by modifying kernel
divers?

RGDS

Christian

