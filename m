Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129854AbRCWHLf>; Fri, 23 Mar 2001 02:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129855AbRCWHL0>; Fri, 23 Mar 2001 02:11:26 -0500
Received: from marks-43.caltech.edu ([131.215.92.43]:21441 "EHLO
	velius.chaos2.org") by vger.kernel.org with ESMTP
	id <S129854AbRCWHLU>; Fri, 23 Mar 2001 02:11:20 -0500
Date: Thu, 22 Mar 2001 23:10:28 -0800 (PST)
From: Jacob Luna Lundberg <jacob@velius.chaos2.org>
To: <linux-kernel@vger.kernel.org>
Subject: use the kernel to change an irq?
Message-ID: <Pine.LNX.4.32.0103222258140.388-100000@velius.chaos2.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Oh Great Gurus:

I have an agp video card that seems quite picky about interrupts, and a
bios that is insisting on sharing the video card's interrupt with whatever
is in the first pci slot.  So my question is, is there any way for the
kernel to more or less say ``screw you'' to the bios and pick the irq for
the video card itself?  I have a spare irq I'd love for it to use...

Oh, almost forgot:  Yes, I'd just vacate the pci slot below the video
card, but sadly all my pci slots are in use.  :(

Ok, I'll admit the card is an nVidia card and I'm trying to use the (evil)
binary drivers.  But note I'm *not* asking for help with that directly.
I'm merely asking if there's a way to avoid sharing the interrupt...

Thanks Muchly,
-Jacob

-- 

The authoritarian attitude has to be fought wherever
you find it, lest it smother you and other hackers.

 - Eric S. Raymond

