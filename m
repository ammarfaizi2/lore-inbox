Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266527AbTCEMOj>; Wed, 5 Mar 2003 07:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266615AbTCEMOi>; Wed, 5 Mar 2003 07:14:38 -0500
Received: from sheridan.uel.ac.uk ([161.76.9.2]:42630 "EHLO sheridan.uel.ac.uk")
	by vger.kernel.org with ESMTP id <S266527AbTCEMOh>;
	Wed, 5 Mar 2003 07:14:37 -0500
Date: Wed, 5 Mar 2003 12:25:02 +0000
From: lk <lk@www0.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Radeon RV200 on /proc/pci
Message-ID: <20030305122502.GA2817@www0.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erm, not sure if this is normal behaviour but, X reports

	--) RADEON(0): VideoRAM: 65536 kByte (64-bit DDR SDRAM)

and it was bought as a 64Mbyte card.

however, /proc/pci reports
	(..) Radeon RV200 QW [Radeon 7500] (prog-if 00 [VGA])
        Memory at d0000000 (32-bit, prefetchable) [size=128M]
	(..)						^^^

The card works fine on indirect and direct rendering modes.
