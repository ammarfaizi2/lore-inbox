Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132145AbRAFPlR>; Sat, 6 Jan 2001 10:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132146AbRAFPlH>; Sat, 6 Jan 2001 10:41:07 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:11531 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132145AbRAFPk7>; Sat, 6 Jan 2001 10:40:59 -0500
Subject: Re: [PATCH] svgalib error in mmap documentation
To: matan@svgalib.org
Date: Sat, 6 Jan 2001 15:42:22 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <Pine.LNX.4.21_heb2.09.0101061029360.1256-100000@matan.home> from "Matan Ziv-Av" at Jan 06, 2001 10:33:27 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14EvUA-0001Bg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +If you want svgalib programs to run with kernel 2.4.0 or newer, svgalib
> +needs to be compiled without background support (BACKGROUND not defined in
> +Makefile.cfg). This is relevant to any svgalib version.
> +This is because svgalib uses mmap of /proc/mem to emulate vga's memory bank
> +switching when in background, and kernel 2.4.0 stopped supporting this feature.

2.4 has real support for shared mappings, so you can I suspect do it properly
now

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
