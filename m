Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266859AbRGFVXv>; Fri, 6 Jul 2001 17:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266855AbRGFVXa>; Fri, 6 Jul 2001 17:23:30 -0400
Received: from gate.tuxia.com ([213.209.134.221]:42737 "EHLO
	exchange1.win.agb.tuxia") by vger.kernel.org with ESMTP
	id <S266854AbRGFVXW> convert rfc822-to-8bit; Fri, 6 Jul 2001 17:23:22 -0400
x-mimeole: Produced By Microsoft Exchange V6.0.4418.65
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Trouble Booting Linux PPC 2000 On Mac G4
Date: Fri, 6 Jul 2001 23:23:23 +0200
Message-ID: <A16915712C18BD4EBD97897F82DA08CD480BFB@exchange1.win.agb.tuxia>
Thread-Topic: Trouble Booting Linux PPC On Mac G4 2000
Thread-Index: AcEGYC0JwWQWi5nlSI6uyVLBnjxUXQAALRVQ
From: "Tim McDaniel" <tim.mcdaniel@tuxia.com>
To: "Jeffrey W. Baker" <jwbaker@acm.org>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think what we are seeing is XBoot rather than yaboot and we tried just
about all conceivable "kernel options", as exposed by Xboot. When Xboot
comes up it shows a ramdisk_size=8192 as the only default parameter.
Rapidly growing to hate the non-intuitive nature of the MAC OS we are
not experts on the Mac OS.  P.S. We are running Mac OS 9.1.

Oops, We just discovered that Xboot does not work with MacOS 9.1 (geez)
.... you MUST use yaboot.


We will try the Q4 release.

Thanks,
Tim


-----Original Message-----
From: Jeffrey W. Baker [mailto:jwbaker@acm.org]
Sent: Friday, July 06, 2001 4:09 PM
To: Tim McDaniel
Cc: linux-ppc@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: RE: Trouble Booting Linux PPC On Mac G4 2000




On Fri, 6 Jul 2001, Tim McDaniel wrote:

>
> We are having a great degree of difficulty getting Linux PPC20000
> running on a Mac G4 466 tower with 128MB of memory, One 30MB HD and
one
> CR RW. This is not a NuBus based system. To the best of our knowledge
we
> have followed the user manual to the tee, and even tried forcing video
> settings at the Xboot screen.
>
>
> But still, when we encounter the screen where you must chose between
> MacOS and Linux and we chose linux, the screen goes black and for all
> practical purposes the box appears to be locked.   We've also tried
> editing yaboot.conf but can't seem to save the new file.
>
> Any help would be greatly appreatiated.

add "video=ofonly" to your boot command line.  That is, at the yaboot
"boot: " prompt, type "linux video=ofonly"

If that doesn't work, try something else :)

-jwb

