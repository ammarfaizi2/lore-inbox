Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131162AbRAMSbA>; Sat, 13 Jan 2001 13:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130537AbRAMSaw>; Sat, 13 Jan 2001 13:30:52 -0500
Received: from zeus.kernel.org ([209.10.41.242]:59872 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131110AbRAMSZ0>;
	Sat, 13 Jan 2001 13:25:26 -0500
Date: Sat, 13 Jan 2001 16:04:25 +0100
From: Patrick Mauritz <oxygene-ml@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: sparc32 hangs on boot 2.4.0
Message-ID: <20010113160425.B14263@blowfish>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on boot the following happens:
----------
SILO boot: linux2.4
Uncompressing image...
PROMLIB: obio_ranges 5
bootmem_init: Scan sp_banks,  init_bootmem(spfn[211],bpfn[211],mlpfn[c000])
free_bootmem: base[0] size[1000000]
free_bootmem: base[2000000] size[100000]
free_bootmem: base[4000000] size[100000]
free_bootmem: base[6000000] size[100000]
free_bootmem: base[8000000] size[100000]
free_bootmem: base[a000000] size[100000]
reserve_bootmem: base[0] size[211000]
reserve_bootmem: base[211000] size[1800]

Level 15 Interrupt
---------
that's it, I'm on OpenFirmware prompt again

The machine is a SS20 with 2 SuperSPARC-II processors and 256MB RAM

Patrick Mauritz 
-- 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
