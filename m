Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265847AbUFTJl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265847AbUFTJl4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 05:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265859AbUFTJlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 05:41:55 -0400
Received: from pdbn-d9bb9eb6.pool.mediaWays.net ([217.187.158.182]:28172 "EHLO
	citd.de") by vger.kernel.org with ESMTP id S265847AbUFTJlx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 05:41:53 -0400
Date: Sun, 20 Jun 2004 11:41:50 +0200 (CEST)
From: Matthias Schniedermeyer <ms@citd.de>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.6 & 2.6.7 sometime hang after much I/O
Message-ID: <Pine.LNX.4.44.0406201123240.26522-100000@korben.citd.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi



First. Kernels <= 2.6.5 don't have this problem. After 2.6.6 show this
behaviour sometimes i downgraded to 2.6.5 as i thought that it would be
fixed in 2.6.7, but 2.6.7 also show this behaviour.

The I/O i do is split some large files (>2GB) into smaller files <= 2GB.
Sometimes the process that does this just hangs (currently i have such a
hangung process), top currently shows up to 90% I/O-Wait.

SOME of my "konsole"s(xterm) hang then too, but others don't (like this
where i type this email) starting new "konsole"s sometimes work, sometimes
not.

System is:
Distribution: Debian SID.
2xP3-933Mhz, 3GB-RAM, Serverworks HE-SL-Chipset
"System"-HDD is SCSI connected via Symbios-53c1010 (Dual U160)
"Data"-HDD(s)(where the split-process does it's work) is connected to a
Highpoint RocketRAID 1540 (HPT-374 Chipset)
Filesystem is XFS for the Data-HDD(s) and Reiserfs for the system-HDD.

If other info is needed i will provide them.





Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated,
cryptic, powerful, unforgiving, dangerous.


