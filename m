Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267142AbSKMIBR>; Wed, 13 Nov 2002 03:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267145AbSKMIBQ>; Wed, 13 Nov 2002 03:01:16 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:56208 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267142AbSKMIBQ>; Wed, 13 Nov 2002 03:01:16 -0500
Message-Id: <4.3.2.7.2.20021113090719.00b51470@mail.dns-host.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Wed, 13 Nov 2002 09:08:15 +0100
To: linux-kernel@vger.kernel.org
From: Margit Schubert-While <margit@margit.com>
Subject: Linux 2.5.47-ac2
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/i386/kernel/built-in.o: In function `gdt_48':
arch/i386/kernel/built-in.o(.data+0x15c1): undefined reference to 
`boot_gdt_table'
drivers/built-in.o: In function `acpi_system_suspend':
drivers/built-in.o(.text+0x230d8): undefined reference to `do_suspend_lowlevel'
net/built-in.o: In function `p8022_request':
net/built-in.o(.text+0xf972): undefined reference to 
`llc_build_and_send_ui_pkt'
net/built-in.o: In function `register_8022_client':
net/built-in.o(.text+0xf9c9): undefined reference to `llc_sap_open'
net/built-in.o: In function `unregister_8022_client':
net/built-in.o(.text+0xfa04): undefined reference to `llc_sap_close'
net/built-in.o: In function `snap_request':
net/built-in.o(.text+0xfb4e): undefined reference to 
`llc_build_and_send_ui_pkt'
net/built-in.o: In function `snap_init':
net/built-in.o(.init.text+0x5f1): undefined reference to `llc_sap_open'
make: *** [vmlinux] Error 1

