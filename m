Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262560AbVGFXQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262560AbVGFXQM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 19:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbVGFXOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 19:14:32 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:1789 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262463AbVGFXMQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 19:12:16 -0400
Subject: [PATCH] Documentation fixes
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, mingo@elte.hu, greg@kroah.com, alan@lxorguk.ukuu.org.uk
Content-Type: text/plain
Organization: MontaVista
Date: Wed, 06 Jul 2005 16:12:11 -0700
Message-Id: <1120691531.16159.42.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I noticed some typo's or mis-thoughts .. Here are my corrections. I
tried to CC all the authors.

Daniel

Signed-Off-By: Daniel Walker <dwalker@mvista.com> 

Index: linux-2.6.12/Documentation/ManagementStyle
===================================================================
--- linux-2.6.12.orig/Documentation/ManagementStyle	2005-06-17 19:48:29.000000000 +0000
+++ linux-2.6.12/Documentation/ManagementStyle	2005-07-03 18:55:03.000000000 +0000
@@ -20,9 +20,9 @@ These suggestions may or may not apply t
 First off, I'd suggest buying "Seven Habits of Highly Successful
 People", and NOT read it.  Burn it, it's a great symbolic gesture. 
 
-(*) This document does so not so much by answering the question, but by
-making it painfully obvious to the questioner that we don't have a clue
-to what the answer is. 
+(*) This document doesn't do much to answer the questions, but makes 
+it painfully obvious to the questioner that we don't have a clue as to 
+what the answers are. 
 
 Anyway, here goes:
 
@@ -47,7 +47,7 @@ Namely that you are in the wrong job, an
 your brilliance instead). 
 
 So the name of the game is to _avoid_ decisions, at least the big and
-painful ones.  Making small and non-consequential decisions is fine, and
+painful ones.  Making small and inconsequential decisions is fine, and
 makes you look like you know what you're doing, so what a kernel manager
 needs to do is to turn the big and painful ones into small things where
 nobody really cares. 
@@ -72,7 +72,7 @@ a kernel manager have huge fiscal respon
 fairly easy to backtrack.  Since you're not going to be able to waste
 huge amounts of money that you might not be able to repay, the only
 thing you can backtrack on is a technical decision, and there
-back-tracking is very easy: just tell everybody that you were an
+backtracking is very easy: just tell everybody that you were an
 incompetent nincompoop, say you're sorry, and undo all the worthless
 work you had people work on for the last year.  Suddenly the decision
 you made a year ago wasn't a big decision after all, since it could be
@@ -166,7 +166,7 @@ To solve this problem, you really only h
 The option of being unfailingly polite really doesn't exist. Nobody will
 trust somebody who is so clearly hiding his true character.
 
-(*) Paul Simon sang "Fifty Ways to Lose Your Lover", because quite
+(*) Paul Simon sang "Fifty Ways to Leave Your Lover", because quite
 frankly, "A Million Ways to Tell a Developer He Is a D*ckhead" doesn't
 scan nearly as well.  But I'm sure he thought about it. 
 
@@ -178,7 +178,7 @@ sadly that you are one too, and that whi
 knowledge that we're better than the average person (let's face it,
 nobody ever believes that they're average or below-average), we should
 also admit that we're not the sharpest knife around, and there will be
-other people that are less of an idiot that you are. 
+other people that are less of an idiot than you are. 
 
 Some people react badly to smart people.  Others take advantage of them. 
 
@@ -262,7 +262,7 @@ a while, and you'll feel cleansed. Just 
 		Chapter 6: Why me?
 
 Since your main responsibility seems to be to take the blame for other
-peoples mistakes, and make it painfully obvious to everybody else that
+peoples' mistakes, and make it painfully obvious to everybody else that
 you're incompetent, the obvious question becomes one of why do it in the
 first place?
 
Index: linux-2.6.12/Documentation/nmi_watchdog.txt
===================================================================
--- linux-2.6.12.orig/Documentation/nmi_watchdog.txt	2005-06-17 19:48:29.000000000 +0000
+++ linux-2.6.12/Documentation/nmi_watchdog.txt	2005-07-03 18:21:28.000000000 +0000
@@ -2,7 +2,7 @@
 [NMI watchdog is available for x86 and x86-64 architectures]
 
 Is your system locking up unpredictably? No keyboard activity, just
-a frustrating complete hard lockup? Do you want to help us debugging
+a frustrating complete hard lockup? Do you want to help us in debugging
 such lockups? If all yes then this document is definitely for you.
 
 On many x86/x86-64 type hardware there is a feature that enables
@@ -73,7 +73,7 @@ you have to enable it with a boot time p
 the NMI-oopser is enabled unconditionally on x86 SMP boxes.
 
 On x86-64 the NMI oopser is on by default. On 64bit Intel CPUs
-it uses IO-APIC by default and on AMD it uses local APIC.
+it uses the IO-APIC by default and on AMD it uses the local APIC.
 
 [ feel free to send bug reports, suggestions and patches to
   Ingo Molnar <mingo@redhat.com> or the Linux SMP mailing
Index: linux-2.6.12/Documentation/stable_api_nonsense.txt
===================================================================
--- linux-2.6.12.orig/Documentation/stable_api_nonsense.txt	2005-06-17 19:48:29.000000000 +0000
+++ linux-2.6.12/Documentation/stable_api_nonsense.txt	2005-07-03 18:04:41.000000000 +0000
@@ -132,7 +132,7 @@ to extra work for the USB developers.  S
 their work on their own time, asking programmers to do extra work for no
 gain, for free, is not a possibility.
 
-Security issues are also a very important for Linux.  When a
+Security issues are also very important for Linux.  When a
 security issue is found, it is fixed in a very short amount of time.  A
 number of times this has caused internal kernel interfaces to be
 reworked to prevent the security problem from occurring.  When this
Index: linux-2.6.12/Documentation/watchdog/watchdog.txt
===================================================================
--- linux-2.6.12.orig/Documentation/watchdog/watchdog.txt	2005-06-17 19:48:29.000000000 +0000
+++ linux-2.6.12/Documentation/watchdog/watchdog.txt	2005-07-03 18:12:40.000000000 +0000
@@ -18,12 +18,12 @@ The following watchdog drivers are curre
 All six interfaces provide /dev/watchdog, which when open must be written
 to within a timeout or the machine will reboot. Each write delays the reboot
 time another timeout. In the case of the software watchdog the ability to 
-reboot will depend on the state of the machines and interrupts. The hardware
+reboot will depend on the state of the machine and interrupts. The hardware
 boards physically pull the machine down off their own onboard timers and
 will reboot from almost anything.
 
 A second temperature monitoring interface is available on the WDT501P cards
-and some Berkshire cards. This provides /dev/temperature. This is the machine 
+and some Berkshire cards. This provides /dev/temperature. This is the machines 
 internal temperature in degrees Fahrenheit. Each read returns a single byte 
 giving the temperature.
 
@@ -37,16 +37,16 @@ The wdt card cannot be safely probed for
 wdt=ioaddr,irq as a boot parameter - eg "wdt=0x240,11".
 
 The SA1100 watchdog module can be configured with the "sa1100_margin"
-commandline argument which specifies timeout value in seconds.
+commandline argument which specifies the timeout value in seconds.
 
 The i810 TCO watchdog modules can be configured with the "i810_margin"
-commandline argument which specifies the counter initial value. The counter
-is decremented every 0.6 seconds and default to 50 (30 seconds). Values can
+commandline argument which specifies the counters initial value. The counter
+is decremented every 0.6 seconds and defaults to 50 (30 seconds). Values can
 range between 3 and 63.
 
 The i810 TCO watchdog driver also implements the WDIOC_GETSTATUS and
 WDIOC_GETBOOTSTATUS ioctl()s. WDIOC_GETSTATUS returns the actual counter value
-and WDIOC_GETBOOTSTATUS returns the value of TCO2 Status Register (see Intel's
+and WDIOC_GETBOOTSTATUS returns the value of the TCO2 Status Register (see Intel's
 documentation for the 82801AA and 82801AB datasheet). 
 
 Features


