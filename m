Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315550AbSECEWG>; Fri, 3 May 2002 00:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315551AbSECEWF>; Fri, 3 May 2002 00:22:05 -0400
Received: from air-2.osdl.org ([65.201.151.6]:57605 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S315550AbSECEWE>;
	Fri, 3 May 2002 00:22:04 -0400
Date: Thu, 2 May 2002 21:22:09 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.5.13 P4 thermal link error
Message-ID: <Pine.LNX.4.33L2.0205022117580.11832-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


arch/i386/kernel/kernel.o: In function `intel_thermal_interrupt':
arch/i386/kernel/kernel.o(.text+0x7751): undefined reference to
`ack_APIC_irq'
arch/i386/kernel/kernel.o: In function `intel_init_thermal':
arch/i386/kernel/kernel.o(.text.init+0x2d0c): undefined reference to
`apic_read'
arch/i386/kernel/kernel.o(.text.init+0x2d48): undefined reference to
`apic_write_around'
arch/i386/kernel/kernel.o(.text.init+0x2d69): undefined reference to
`apic_read'
arch/i386/kernel/kernel.o(.text.init+0x2d79): undefined reference to
`apic_write_around'
make: *** [vmlinux] Error 1

-- 
~Randy


