Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263629AbUJ2ViD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263629AbUJ2ViD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 17:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263616AbUJ2Vfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 17:35:40 -0400
Received: from out003pub.verizon.net ([206.46.170.103]:34285 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S263614AbUJ2V3s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 17:29:48 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: [OT] factory made but custom dual 8255 I/O card Q
Date: Fri, 29 Oct 2004 17:29:41 -0400
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410291729.41266.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [141.153.91.102] at Fri, 29 Oct 2004 16:29:42 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

I'm about to embark on a linuxCNC project, and I have the motors, 
controllers, and a futurlec PCI8255 card, with has dual 8255's on it 
for a total of 72 I/O lines.

This card has a dipswitch settable addressing scheme that allows it to 
be most anyplace from 0000:0000 to 00FF:FF00 in $100 steps for the 
increment.

When placed in the machine, the bios reports a resource clash, but 
gives the option of continueing the boot.  Its got FC2 on it, clean 
install with most updates.  I've tried moving the address but the 
bios still squawks, but it does go ahead and boot to FC2.

Once booted, an lspci -vv doesn't output anything that looks like a 
resource clash to me, and while the bios bitches, its supposed to 
tell you what is clashing by putting a * in front of the two or more 
items at odds with each other, but those screens aren't actually 
indicating anything wrong.  It also doesn't show this board in the 
bios displays.

Can anyone comment on this?

So my next Q then is, do we have, someplace I haven't tripped over it, 
a relatively simple, preferably timer IRQ driven assembly program 
that could be configured to drive such a board?  The linuxCNC soft 
seems to favor a par port interface, but is supposed to be friendly 
to other methods also, how friendly may be discussed in the user 
manual, but it will be another hour + to get to that as its even 
pages are now just trickling out of the printer, and odd to go. 159 
pages total.
 
-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
