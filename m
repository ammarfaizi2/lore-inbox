Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263572AbTJWNJB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 09:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbTJWNJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 09:09:01 -0400
Received: from mta01-svc.ntlworld.com ([62.253.162.41]:12169 "EHLO
	mta01-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S263572AbTJWNI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 09:08:59 -0400
Date: Thu, 23 Oct 2003 14:08:25 +0100 (BST)
From: linux-kernel-98382@slimyhorror.com
X-X-Sender: ben@baphomet.bogo.bogus
To: linux-kernel@vger.kernel.org
Subject: Build failure on x86-64, 2.6.0-test8-bk3
Message-ID: <Pine.LNX.4.58.0310231406010.20204@baphomet.bogo.bogus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  LD      .tmp_vmlinux1
drivers/built-in.o(.init.text+0xed4): In function `acpi_bus_init':
: undefined reference to `acpi_pic_set_level_irq'
make: *** [.tmp_vmlinux1] Error 1

acpi_pic_set_level_irq only appears to be defined inside arch/i386

