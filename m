Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310158AbSCKXd3>; Mon, 11 Mar 2002 18:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310201AbSCKXdS>; Mon, 11 Mar 2002 18:33:18 -0500
Received: from pcp110788pcs.wchryh01.nj.comcast.net ([68.45.84.166]:33920 "HELO
	sorrow.ashke.com") by vger.kernel.org with SMTP id <S310186AbSCKXdO>;
	Mon, 11 Mar 2002 18:33:14 -0500
Date: Mon, 11 Mar 2002 18:31:07 -0500 (EST)
From: Adam K Kirchhoff <adamk@voicenet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: SMP & APIC problem.
Message-ID: <Pine.LNX.4.10.10203111801290.3488-100000@sorrow.ashke.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've recently purchased an Acorp i815ep, dual proc motherboard.  Intel has
stated that the i815 will not work for a dual proc configuration, but
apparently Acorp has made it work :-) 

I swapped out a single processor i815 motherboard, and installed the Acorp
motherboard with dual 1 Gig Pentium III processors.  I booted up and
nearly immediately started seeing:

APIC error on CPU0: 00(08)

And similar messages.  Though the computer continued booting, within a few
minuted I had received close to 400 of those messages, and then my
computer locked up.  

Now, I can boot with the "noapic" option and that seems to solve the
problems.  However, this situation is less than ideal, and I'd rather get
it working with APIC.

My first question:  Is the lockup probably related to the error messaages?
Everything had been running smoothly on the single proc motherboard, and I
wasn't doing anything special when it locked up (I had launced galeon a
few seconds before and was typing into the google search screen).

My second question:  Is there any chance of getting this working with
APIC, if not in 2.4.* maybe in a future release?

Adam 

