Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131856AbQKYXM4>; Sat, 25 Nov 2000 18:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131904AbQKYXMr>; Sat, 25 Nov 2000 18:12:47 -0500
Received: from nova.acomp.usf.edu ([131.247.100.22]:14832 "EHLO
        nova.acomp.usf.edu") by vger.kernel.org with ESMTP
        id <S131856AbQKYXMe>; Sat, 25 Nov 2000 18:12:34 -0500
Date: Sat, 25 Nov 2000 17:42:22 -0500 (EST)
From: Rick Bunke <rbunke@helios.acomp.usf.edu>
Subject: Re: ext2 filesystem corruptions back from dead? 2.4.0-test11
To: linux-kernel@vger.kernel.org
Message-id: <Pine.GSO.4.21.0011251651280.28783-100000@nova.acomp.usf.edu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I read up on this thread in the archives (the last message in thread was
posted on the 24th) so I'm sorry if this has already been said.

I'm having the same problem with 2.4.0-test10, but I don't have the
problem with 2.4.0-test9.  So i think the bug might have been introduced
in 10.

When I try to compile xfree86 (the DRI version) under test10 my system 
locks up and then has to clean up a bunch of errors in the filesystem on
reboot.  I went back, removed my build tree, recreated it, recompiled
again and it would lock up again.  I did this a few times under kernel
2.4.0-test10 and it would consistantly lock up, then I went to the kernel
archive and found this thread which says the problem is in test11.  I then
decided I better try out test9 and see if it was just me.  I rebooted into
kernel 2.4.0-test9, removed my build tree, recreated it, then recompiled
again and it worked just fine without locking up.  That is what leads me
to believe the problem was introduced in test10 and probably carried over
to test11.  Hope this helps. 

If you want more info just let me know 
my email address is rbunke@helios.acomp.usf.edu.

Have Fun
Rick

Information is the currency of democracy.
		   - Thomas Jefferson

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
