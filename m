Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266256AbSLCVQu>; Tue, 3 Dec 2002 16:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266271AbSLCVQu>; Tue, 3 Dec 2002 16:16:50 -0500
Received: from SMTP6.andrew.cmu.edu ([128.2.10.86]:19137 "EHLO
	smtp6.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id <S266256AbSLCVQt>; Tue, 3 Dec 2002 16:16:49 -0500
Date: Tue, 3 Dec 2002 16:24:17 -0500 (EST)
From: Steinar Hauan <hauan@cmu.edu>
X-X-Sender: hauan@unix46.andrew.cmu.edu
To: linux-kernel@vger.kernel.org
Subject: 2.4.20 raid performance
Message-ID: <Pine.LNX.4.44L-027.0212031614350.21735-100000@unix46.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

  we have a database server (dual p4 xeon, E7500 chipset) with an Adaptec
  AIC-7899 RAID-0 controller vs Seagate Cheetah 15k rpm disks.

  using a custom 2.4.20 kernel and hdparm, we only get a sustained write
  speed of approx 60mb/s  ... versus more than 100 on a RedHat rpm kernel.
  (2.4.18 and later) with no change in raid configuration.

  does anyone know if RedHat have modified the raid setup in their kernels
  or if there are specific options in the kernel config that could lead
  to the above performance degradation?

  any pointers would be appreciated. kernel config file available
  on http://steinar.cheme.cmu.edu/config.p4-2.4.20 for one week.

regards,
--
  Steinar Hauan, dept of ChemE  --  hauan@cmu.edu
  Carnegie Mellon University, Pittsburgh PA, USA

