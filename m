Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269756AbRHIKt0>; Thu, 9 Aug 2001 06:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269757AbRHIKtQ>; Thu, 9 Aug 2001 06:49:16 -0400
Received: from vti01.vertis.nl ([145.66.4.26]:2067 "EHLO vti01.vertis.nl")
	by vger.kernel.org with ESMTP id <S269756AbRHIKs5>;
	Thu, 9 Aug 2001 06:48:57 -0400
Date: Thu, 9 Aug 2001 12:48:30 +0200
Message-Id: <200108091048.MAA04335@linux06.vertis.nl>
From: Rolf Fokkens <FokkensR@vertis.nl>
To: linux-kernel@vger.kernel.org
Subject: [BUG] Total freeze of 2.4 kernel
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is not a detailed bug report, but it may nevertheless be interesting
for others that have the same problem. I have the impression that my first
report got lost somewhere, so this is the second attempt to post it.

We installed a 2.4.7 kernel on a Compaq Proliant server and it makes the
machine freeze totally at various moments. We've been running 2.4 on several
other non-server machines for a while without any problem at all, so we
tried to figure out what may be causing the problem. Here is a list of what
we know so far:

INITIAL SYMPTOMS

At totally unpredictable moments the sever hangs. Nothing on the display, no
keyboard led response, no disk activity, no ping response on the net.

2.2.19 KERNEL

The machine ran a 2.2.19 kernel prior to the 2.4.7 kernel without any
problems at all. Only kernel upgrades forced us to do reboots.

CPQHEALTH

There were Compaq cpqhealth modules in the kernel. Those are binary modules
from Compaq that help to gather health information about the machine. The
modules didn't load in a 2.4.7 kernel (cpqhealth 2.1 even created kernel
stack dumps when loaded in a 2.4.7 kernel on another machine) so we removed
the cpqhealth software. It didn't help.

CPQARRAY

This is the first machine with a Compaq SMART 3200 raid controller we tried
with 2.4.7. I don't believe this is causing the problem, but it's worth
mentioning I think.

MONITOR/MOUSE/KEYBOARD SWITCH

This also is the first machine with an electronic MONITOR/MOUSE/KEYBOARD
SWITCH. Last weekend the machine ran w/o any problems at all, but today
(monday) it had a hangup. We can be sure that nobody touched the switch
during the weekend and today at was used most certainly, so there may be a
relation between the switch and the hanging.

Of course we'll go on investigating this, but because the machine has a
semi-production status we have to do this with care. However suggestions are
wellcome.

Rolf
