Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276708AbRJGWiz>; Sun, 7 Oct 2001 18:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276718AbRJGWir>; Sun, 7 Oct 2001 18:38:47 -0400
Received: from imladris.infradead.org ([194.205.184.45]:60429 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S276716AbRJGWii>;
	Sun, 7 Oct 2001 18:38:38 -0400
Date: Sun, 7 Oct 2001 23:39:04 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: David =?unknown-8bit?Q?G=F3mez?= <davidge@jazzfree.com>,
        Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: IDE DMA errors [was: Some ext2 errors]
In-Reply-To: <20011007110212.A22412@mikef-linux.matchmail.com>
Message-ID: <Pine.LNX.4.33.0110072325330.6632-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike.

 >>> I see this regularly on one of my systems, and hdparm has never
 >>> even been insatalled on that system. If I put the drive in a
 >>> different system, the drive reports clean, but whatever drive I
 >>> put in here regularly reports that problem.

 >> Yes, i also have seen this error also when not using hdparm, so
 >> it's not the cause of this ext2 errors.

 > Oh, sorry, I blamed before I had facts... my bad.

I've done that in the past - it's easy to do - but nowadays, I tend to
wait for more facts before assuming - although I'm by no means perfect
in that regard...

 >>> As far as I can tell, it's a problem with the PSU in the computer
 >>> in question, as I can swap ANYTHING else in there, motherboard
 >>> included, without the problem going away on that drive, but as
 >>> soon as I swap the PSU, the problems vanish - even if I put a PSU
 >>> with a lower rating in its place.

 >> If i see this error show more times i'll try to replace the PSU.
 >> First I think is has some relation with my VIA chipset, but if you
 >> tell me you have changed even your motherboard... ;)

 > It may not be your MB or drive, but an interaction between them.
 > I.E. Your bios could've told the linux driver to use a higher
 > dma level than the drive likes.

Always possible, but I'd consider it unlikely that using the SAME
motherboard and drive, but with a different PSU would have any affect
whatsoever if such was the reason.

I would presume that the old PSU was just too noisy for that
particular drive, and a new PSU is rather quieter in that regard.

 > Try running "hdparm -d0 /dev/hda" (since your drive is hda in
 > this case...) And see if the problem goes away. If it does, then
 > try Multimode dma, if (-X34) you get errors, try single mode
 > (probably -X31), if you get no errors there, try UDMA mode 2
 > (-X66, also make sure you have a 80 line ide cable) and see if
 > any of the problems come back.

Unfortunately, none of that is relevant in my case...see below...

 >>>> Yeah. If you can't figure out hdparm, leave it alone.

 >>> Who says hdparm has anything to do with it?

 >> He says, it seems he has very deep knowledge of hdparm 'secrets'.

 > Again, sorry for being presumptuous. I've only been able to cause
 > this with hdparm. Maybe I'm just not using new enough hardware...

The system in question is my network printserver, which has a 386sx/16
processor and a very definitely 40 line cable with no support for
anything else. The hard drive is an antique Maxtor 800M one, and I
have no problem assuring you that it's not possible to buy that model
new, and hasn't been for some years now...

Best wishes from Riley.

