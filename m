Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbVEKGCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbVEKGCX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 02:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbVEKGCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 02:02:23 -0400
Received: from just.ip-center.ru ([213.177.107.6]:37868 "EHLO
	just.ip-center.ru") by vger.kernel.org with ESMTP id S261900AbVEKGCS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 02:02:18 -0400
From: "gaa" <gaa@mail.nnov.ru>
Subject: dosemu crashes under 2.6.12-rc4
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 11 May 2005 10:03:40 +0400
X-Mailer: The Bee 1.07 build 757
Message-Id: <20050511060223.7B62F146C83@just.ip-center.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"dosemu" does not work under kernel 2.6.12-rc4(but works under 2.6.11.7).
Next lines are stdout of crashed dosemu process:

Linux DOS emulator 1.2.1.0 $Date: 2004/03/06$
Last configured at Thu Jun 24 01:04:04 UTC 2004 on linux
This is work in progress.
Please test against a recent version before reporting bugs and problems.
Submit Bug Reports, Patches & New Code to linux-msdos@vger.kernel.org or via
the SourceForge tracking system at http://www.sourceforge.net/projects/dosemu
                                                09 2002 21:55:55]
Kernel compatibility 7.10 - WATCOMC - FAT32 support

(C) Copyright 1995-2002 Pasquale J. Villani and The FreeDOS Project.
All Rights Reserved. This is free software and comes with ABSOLUTELY NO
WARRANTY; you can redistribute it and/or modify it under the terms of the
GNU General Public License as published by the Free Software Foundation;
either version 2, or (at your option) any later version.
C: HD1 Pri:1 CHS=    0-1-1 start =     0MB,size =  392
Kernel: allocated 41 Diskbuffers = 21812 Bytes in HMA
[dosemu EMS 4.0 driver installed]
ERROR: cpu exception in dosemu code outside of VM86()!
trapno: 0x0e  errorcode: 0x00000005  cr2: 0xffffff8e
eip: 0x000069ee  esp: 0xbfedffcc  eflags: 0x00010246
cs: 0x0073  ds: 0x007b  es: 0x007b  ss: 0x007b
Page fault: read instruction to linear address: 0xffffff8e
CPU was in user mode
Exception was caused by insufficient privilege
ERROR: leavedos() called from within a signal context!



Alexander Galanin aka gaa
11.05.2005
