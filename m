Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271619AbRIBNOK>; Sun, 2 Sep 2001 09:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271620AbRIBNOA>; Sun, 2 Sep 2001 09:14:00 -0400
Received: from alpham.uni-mb.si ([164.8.1.101]:11279 "EHLO alpham.uni-mb.si")
	by vger.kernel.org with ESMTP id <S271619AbRIBNN5>;
	Sun, 2 Sep 2001 09:13:57 -0400
Date: Sun, 02 Sep 2001 15:14:08 +0200
From: Igor Mozetic <igor.mozetic@uni-mb.si>
Subject: [2.4.9 SMP] alloc_pages failed
To: linux-kernel@vger.kernel.org
Message-id: <15250.12448.265829.457034@ravan.camtp.uni-mb.si>
MIME-version: 1.0
X-Mailer: VM 6.95 under Emacs 20.7.2
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My box is dual Xeon 550, Intel C440GX+, 2GB RAM, AIC7XXX.
Last night I got log full of the following:

Sep  2 04:00:46 jerolim kernel: __alloc_pages: 0-order allocation failed.
Sep  2 04:00:47 jerolim last message repeated 208 times
Sep  2 04:00:47 jerolim kernel: ed.
...
Sep  2 04:01:29 jerolim kernel: eth0: can't fill rx buffer (force 0)!
Sep  2 04:01:29 jerolim kernel: eth0: Tx ring dump,  Tx queue 4082238 / 4082238:
Sep  2 04:01:29 jerolim kernel: eth0:     0 200ca000.
...

-- Versions installed: (if some fields are empty or looks
-- unusual then possibly you have very old versions)
Linux jerolim 2.4.9 #1 SMP Fri Aug 17 11:33:44 CEST 2001 i686 unknown
Kernel modules         2.4.6
Gnu C                  2.95.2
Binutils               2.9.5.0.37
Linux C Library        2.1.3
Dynamic linker         ldd: version 1.9.11
Procps                 2.0.6
Mount                  2.10s
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         

No crash or obvious problems, four long jobs are still running OK.
Full details if needed, please CC to me.

-Igor Mozetic
