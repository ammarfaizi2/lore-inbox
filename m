Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275892AbSIUKFU>; Sat, 21 Sep 2002 06:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275893AbSIUKFU>; Sat, 21 Sep 2002 06:05:20 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:36877 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S275892AbSIUKFT>; Sat, 21 Sep 2002 06:05:19 -0400
Date: Sat, 21 Sep 2002 12:10:41 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
To: linux-kernel@vger.kernel.org
Subject: 2.5.37 won't run X?
Message-ID: <20020921121041.C20153@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

X won't start on 2.5.37, but works with 2.5.36
The screen goes black as usual, but then nothing else happens.
ssh'ing in from another machine shows XFree86 using 50% cpu,
i.e. one of the two cpu's in this machine.

killing the XFre86 process is impossible, even with kill -9
from root. sysrq SAK worked though, so I could recover
the machine.  But I had to boot a different kernel to run X.

lspci
00:0f.0 VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 01)

2.5.37 SMP kernel

XFree86 Version 4.1.0.1 / X Window System
(protocol Version 11, revision 0, vendor release 6510)
Release Date: 21 December 2001

Distribution debian testing

Helge Hafting
