Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130663AbRAPOwe>; Tue, 16 Jan 2001 09:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130889AbRAPOwY>; Tue, 16 Jan 2001 09:52:24 -0500
Received: from 111.ppp1-1.arc.worldonline.dk ([213.237.19.239]:14340 "EHLO
	sanxion.tisprut.dk") by vger.kernel.org with ESMTP
	id <S130663AbRAPOwH>; Tue, 16 Jan 2001 09:52:07 -0500
Date: Tue, 16 Jan 2001 15:46:17 +0100 (CET)
From: Stephan Henningsen <stephan@nerd.dk>
To: linux-kernel@vger.kernel.org
Subject: Oops 0000
Message-ID: <Pine.LNX.4.21.0101161542500.561-100000@sanxion.tisprut.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there,

I am sending your a bunch(!) of logs I think all cast some light over what
ever is wrong with my brand machine.  Since I got it up running, it has
been crashing now and then.

It is an AMD T-Bird 900MHz (running at 100MHz x 9 -- not overclocked or begin
tortured in similar ways), 256MB PC133 RAM, a IBM DeskStar IDE HD and an
NVidia GeForce2MX-based graphics card (Hercules Prophet II to be specific).
I use a binary version of XFree86 4.0.2 with an Nvidia driver.  I use
WindowMaker 0.61.0 as my window manager.  The kernel is version 2.2.18.

My old system is a P166 and it has not crashed for years.  I do not run MS
Windows, so yes, crashing does worry me alot!

The first couple of times, the system crashed when I switched back and
forth between X and console (Alt+Ctrl+F1 in X / Alt+F7 in console).  The
next few times it happened when I changed workspace from Blender3d (a 3D
modelling and animation program using OpenGL) to a clean workspace.  This
lead me to think that it had something to do with either X 4.0.2 or the
driver from NVidia (which is know to have some minor redraw-bugs).
So far a "crash" means it locked up my machine completely; no keyboard, no
mouse, frozen screen.  (I am currently not in a network, so I cannot ping
and see if the kernel has frozen completely).

But yesterday (january 15 2001) it crashed my X and for the first
time left me in console with an error message from the kernel:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
current->tss.cr3 = 0dea4000, %%cr3 = 0dea4000
*pde = 00000000
Oops: 0000
CPU:    0

My gpm was killed so I tried to switch to another terminal to restart gpm
and cut'n'paste the output to a file, but then it froze completely -- again.

Now I am no long sure that it's a problem related to X or the NVidia
driver.  I could also be hardware.  But as said, the computer is brand new
and I am not overclocking anything.

I run a memtest86 on the machie this night for 13 hours straight with all
tests enabled, but it found nothing.

So, I send you the logs and kernel configuration in the hope that perhaps
you can help me out.


Thanks,
Stephan Henningsen <stephan@nerd.dk>




Download logs and system info here:
http://stephan.tisprut.dk/Skrammel/Stephan_Henningsen.tar.bz2


-- 
Stephan Henningsen  /
                   /  http://tisprut.dk


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
