Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVE1QHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVE1QHS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 12:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbVE1QHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 12:07:18 -0400
Received: from heisenberg.zen.co.uk ([212.23.3.141]:45282 "EHLO
	heisenberg.zen.co.uk") by vger.kernel.org with ESMTP
	id S261152AbVE1QHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 12:07:13 -0400
Message-Id: <200505281607.j4SG7Cal009463@StraightRunning.com>
From: "Colin Harrison" <colin.harrison@virgin.net>
To: <linux-kernel@vger.kernel.org>
Subject: patch-2.6.12-rc5-git3 'make install' undefined reference 
Date: Sat, 28 May 2005 17:07:11 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Copyright: Copyright (c) 2005 Colin Harrison
X-Domain: StraightRunning.com
X-Admin: colin@straightrunning.com
X-Originating-Heisenberg-IP: [62.3.107.196]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I'm getting an undefined reference in 'make install' with
patch-2.6.12-rc5-git3

arch/i386/kernel/built-in.o(.init.text+0x1710): In function `setup_arch':
: undefined reference to `acpi_boot_table_init'
arch/i386/kernel/built-in.o(.init.text+0x1715): In function `setup_arch':
: undefined reference to `acpi_boot_init'
make: *** [.tmp_vmlinux1] Error 1


# CONFIG_ACPI is not set in my .config

Kernel compiles cleanly with patch-2.6.12-rc5-git2.
More information can be supplied as required.

Thanks

Colin Harrison

