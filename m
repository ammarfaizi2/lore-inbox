Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318272AbSIKByJ>; Tue, 10 Sep 2002 21:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318275AbSIKByJ>; Tue, 10 Sep 2002 21:54:09 -0400
Received: from u212-239-150-44.dialup.planetinternet.be ([212.239.150.44]:58628
	"EHLO jebril.pi.be") by vger.kernel.org with ESMTP
	id <S318272AbSIKByI>; Tue, 10 Sep 2002 21:54:08 -0400
Message-Id: <200209110157.g8B1vapp006206@jebril.pi.be>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: 2.5.34 randomly freezes under X (seems input related)
Date: Wed, 11 Sep 2002 03:57:36 +0200
From: "Michel Eyckmans (MCE)" <mce@pi.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetz,

On 2.5.34, moving the mouse around (just moving, not clicking) under 
an (almost) idle X "almost" reliably freezes my machine if I just do 
it long enough. I write "almost" because:

 1) It happened on 14 out of 15 sessions, sometimes immediately
    after logging in. I gave up on the one exception after trying
    for more than 5 minutes.

 2) It might be related to whether there is some background activity. 
    I have a shell script that forks a lot of stuff in quick succession 
    and it seems that a lockup is guaranteed if I move my mouse while 
    that script is running. The script is not a requirement, though.

Sadly, only the reset button helps and of course nothing useful shows 
up in the logs. :-( I tried very hard to reproduce it on a virtual 
console, but failed no matter how hard I stressed the box. So X "must" 
be part of the problem somehow.

This is 2.5.34 on a dual Pentium, gcc 2.95, no preempt, AT keyboard 
& serial mouse. I never got 2.5.32 and 2.5.33 to compile/boot, so the 
problem may not be all that new. 2.5.31 works OK (not fine, but OK).

Any ideas? It looks a bit like some input layer problem to me.
Feel free to ask for more configuration details if you're interested.

   MCE

PS: Thanks for the working floppies! 

   MCE
-- 
========================================================================
M. Eyckmans (MCE)          Code of the Geeks v3.1       mce-at-pi-dot-be
GCS d+ s+:- a37 C+++$ UHLUASO+++$ P+ L+++ E--- W++ N+++ !o K w--- !O M--
 V-- PS+ PE+ Y+ PGP- t--- !5 !X R- tv- b+ DI++ D-- G++ e+++ h+(*) !r y?
========================================================================

