Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131468AbQJ2AIo>; Sat, 28 Oct 2000 20:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131469AbQJ2AIe>; Sat, 28 Oct 2000 20:08:34 -0400
Received: from hera.cwi.nl ([192.16.191.1]:17366 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S131468AbQJ2AIX>;
	Sat, 28 Oct 2000 20:08:23 -0400
Date: Sun, 29 Oct 2000 02:08:20 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200010290008.CAA107942.aeb@aak.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: panther ethernet and SCSI
Cc: linux-scsi@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently I got a "Professional Workstation" - a 486DX33
with 82596 on board ethernet and NCR(?) on board SCSI.

It was not very difficult to get the 82596 to work
(I put something that works on
	ftp.XX.kernel.org/pub/linux/kernel/people/aeb/lp486e.c
comments are welcome)
The 82596 itself is well-documented in Intel's 29021806.pdf
but I have almost no information on the use of the I/O ports
and do not know a good way to find the ethernet address.

But there is also SCSI on this board - at boot time it prints
        Ballard Synergy CAMcore(R), Copyright 1991, 1.602
        LP486E  NCR SDMS
if and only if SCSI is enabled in the BIOS setup.
Does anybody have an idea how to make this do something?

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
