Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130194AbRA3XvT>; Tue, 30 Jan 2001 18:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130443AbRA3Xu7>; Tue, 30 Jan 2001 18:50:59 -0500
Received: from cheetah.STUDENT.CWRU.Edu ([129.22.164.229]:58496 "EHLO
	cheetah.STUDENT.cwru.edu") by vger.kernel.org with ESMTP
	id <S130194AbRA3Xu4>; Tue, 30 Jan 2001 18:50:56 -0500
Date: Tue, 30 Jan 2001 18:50:56 -0500 (EST)
From: Matthew Gabeler-Lee <msg2@po.cwru.edu>
X-X-Sender: <cheetah@cheetah.STUDENT.cwru.edu>
To: <linux-kernel@vger.kernel.org>
Subject: bttv problems in 2.4.0/2.4.1
Message-ID: <Pine.LNX.4.32.0101301830330.1138-100000@cheetah.STUDENT.cwru.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.4.0 and 2.4.1, when I try to load the bttv driver, one of two
things happens: the system hangs (even alt-sysrq doesn't work!), or the
system powers off by itself (ATX mobo).  Instant power-off usually
happens after a soft reboot (init 6), while it usually hangs up after a
hard reboot (power cycling).

When it hangs, I noticed a very strange thing.  If I push the power
on/off button briefly, it un-hangs and seems to proceed as normal.  The
kernel does report an APIC error on each cpu (dual p3 700 system) when
this happens.

These errors all occur in the same way (as near as I can tell) in
kernels 2.4.0 and 2.4.1, using bttv drivers 0.7.50 (incl. w/ kernel),
0.7.53, and 0.7.55.

I am currently using 2.4.0-test10 with bttv 0.7.47, which works fine.

I have sent all this info to Gerd Knorr but, as far as I know, he hasn't
been able to track down the bug yet.  I thought that by posting here,
more eyes might at least make more reports of similar situations that
might help track down the problem.

PS: I'm not on the linux-kernel list, so please CC replies to me.

-- 
	-Matt

Today's weirdness is tomorrow's reason why.
                -- Hunter S. Thompson


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
