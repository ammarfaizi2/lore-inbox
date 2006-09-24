Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752104AbWIXETe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104AbWIXETe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 00:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752105AbWIXETe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 00:19:34 -0400
Received: from kishna.firstlight.net ([63.80.208.5]:62165 "EHLO
	kishna.firstlight.net") by vger.kernel.org with ESMTP
	id S1752104AbWIXETd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 00:19:33 -0400
Date: Sat, 23 Sep 2006 21:19:31 -0700 (PDT)
From: Neil Whelchel <koyama@firstlight.net>
To: linux-kernel@vger.kernel.org
Subject: Kernel panic with two BTTV cards
Message-ID: <Pine.LNX.4.44.0609232118180.29847-100000@kishna.firstlight.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I have a Dual Xeon box with a Broadcom CIOB-X2 chipset with two BT878
cards installed. All is well until I start using both cards at the same
time. After a random period of time (5 min to 10 hr) I get a random kernel
panic that completely freezes the machine. This has never occurred when I
am
using only one of the two installed cards at a time. I have also tried
this with TB848 cards as well with the same problem.
This problem has persisted through every version of the kernel I have
tested so far.
2.6.12 SMP
2.6.13.1 SMP
2.6.14.3 SMP
2.6.17.11 SMP
I have tried all of these with Preemption and no Preemption.
Any thoughts?


-Neil Whelchel-
First Light Internet Services
760 366-0145 Ext 601
- I don't do Window$, that's what the janitor is for -

Beware the new TTY code!


-Neil Whelchel-
First Light Internet Services
760 366-0145 Ext 601
- I don't do Window$, that's what the janitor is for -

A debugged program is one for which you have not yet found the conditions
that make it fail.
		-- Jerry Ogdin

