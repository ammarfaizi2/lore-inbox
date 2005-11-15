Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbVKOHnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbVKOHnN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 02:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbVKOHnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 02:43:12 -0500
Received: from metis.extern.pengutronix.de ([83.236.181.26]:33924 "EHLO
	metis.extern.pengutronix.de") by vger.kernel.org with ESMTP
	id S1751364AbVKOHnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 02:43:11 -0500
Date: Tue, 15 Nov 2005 08:43:36 +0100
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: linux-kernel@vger.kernel.org
Subject: [klibc] bug on arm?
Message-ID: <20051115074336.GE1099@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Does anyone successfully use klibc on ARM? I get this when I try to
crosscompile klibc-1.1: 

----------8<----------8<----------8<----------8<----------8<----------
[...]
arm-softfloat-linux-gnu-ld  -o tests/environ.shared -e main interp.o
tests/environ.o -R libc.so
/opt/crosstool-0.32/arm-softfloat-linux-gnu/gcc-3.3.3-glibc-2.3.2/lib/gcc-lib/arm-softfloat-linux-gnu/3.3.3/libgcc.a
arm-softfloat-linux-gnu-ld: internal error: aborting at
/ptx/work/svn-rsc/ptxdist-0.7-trunk/build/crosstool-0.32/build/arm-softfloat-linux-gnu/gcc-3.3.3-glibc-2.3.2/binutils-2.14.90.0.5/ld/ldlang.c
line 3665 in lang_place_orphans
arm-softfloat-linux-gnu-ld: please report this bug
make[2]: *** [tests/environ.shared] Error 1
[...]
----------8<----------8<----------8<----------8<----------8<----------

Toolchain is a crosstool based on

	- gcc-3.3.3
	- glibc-2.3.2
	- binutils 2.14.90.0.5

Could this be a toolchain problem or has anyone else seen this? 

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9

