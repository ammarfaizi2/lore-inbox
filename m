Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262810AbSI3PBd>; Mon, 30 Sep 2002 11:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262812AbSI3PBd>; Mon, 30 Sep 2002 11:01:33 -0400
Received: from landfill.ihatent.com ([217.13.24.22]:39400 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S262810AbSI3PBc>;
	Mon, 30 Sep 2002 11:01:32 -0400
To: linux-kernel@vger.kernel.org
Subject: CPU/cache detection wrong
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 28 Sep 2002 14:29:31 +0200
Message-ID: <m3hegaxpp0.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Accroding to my kernel, this is what i got:

CPU: Before vendor init, caps: 3febf9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 0K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 3febf9ff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febf9ff 00000000 00000000 00000000
CPU:             Common caps: 3febf9ff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 Mobile CPU 1.70GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.

The machine is a Comapq Evo n800c with a 1.7GHz P4-M in it, and
according to the BIOS I've got 16kb/512Kb L1/L2-cache. Accroding to
the 2.4.20-pre7-ac3-kernel. It's been like this at least since
2.4.19-pre4 or so.

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
