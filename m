Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262712AbVE1MGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262712AbVE1MGq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 08:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262713AbVE1MGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 08:06:46 -0400
Received: from clem.clem-digital.net ([68.16.168.10]:2452 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S262712AbVE1MGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 08:06:45 -0400
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200505281206.j4SC6iLa015878@clem.clem-digital.net>
Subject: 2.6.12-rc5-git3 fails compile -- acpi_boot_table_init
To: linux-kernel@vger.kernel.org (linux-kernel)
Date: Sat, 28 May 2005 08:06:44 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL7]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fyi:


  LD      .tmp_vmlinux1
arch/i386/kernel/built-in.o: In function `setup_arch':
arch/i386/kernel/built-in.o(.init.text+0x14ec): undefined reference to `acpi_boot_table_init'
arch/i386/kernel/built-in.o(.init.text+0x14f1): undefined reference to `acpi_boot_init'
make: *** [.tmp_vmlinux1] Error 1

-- 
Pete Clements 
