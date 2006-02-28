Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750879AbWB1OP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbWB1OP2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 09:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbWB1OP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 09:15:28 -0500
Received: from mx1.sonologic.nl ([82.94.245.21]:203 "EHLO mx1.sonologic.nl")
	by vger.kernel.org with ESMTP id S1750879AbWB1OP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 09:15:28 -0500
Message-ID: <44045B3A.1050907@metro.cx>
Date: Tue, 28 Feb 2006 15:16:26 +0100
From: Koen Martens <linuxarm@metro.cx>
Organization: Sonologic
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-arm-kernel@lists.arm.linux.org.uk
CC: linux-kernel@vger.kernel.org, ben@simtec.co.uk
Subject: [patch] s3c2412 support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Helo-Milter-Authen: gmc@sonologic.nl, linuxarm@metro.cx, mx1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Koen Martens <kmartens@sonologic.nl>

Changes are:
- Added s3c2412-specific files to arch/arm/mach-s3c2410
- Added s3c2412 detection to arch/arm/mach-s3c2410/cpu.c
- Added CONFIG_CPU_S3C2412
- Added s3c2412 specific registers and register addresses to
  various regs-*.h files in include/asm-arm/arch-s3c2410

All changes are preliminary, final documentation is not yet available
from samsung. We did test on actual hardware, but outside the linux
kernel (due to limited number of actual chips we have available and
lack of proper PCB with serial lines exported).

Signed-off-by: Koen Martens <kmartens@sonologic.nl>

Have fun,

Koen Martens

-- 
K.F.J. Martens, Sonologic, http://www.sonologic.nl/
Networking, hosting, embedded systems, unix, artificial intelligence.
Public PGP key: http://www.metro.cx/pubkey-gmc.asc
Wondering about the funny attachment your mail program
can't read? Visit http://www.openpgp.org/

