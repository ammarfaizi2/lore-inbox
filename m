Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265715AbUFIIxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265715AbUFIIxI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 04:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265716AbUFIIxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 04:53:08 -0400
Received: from [210.17.128.84] ([210.17.128.84]:39685 "EHLO
	mail.keycommasia.com") by vger.kernel.org with ESMTP
	id S265715AbUFIIxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 04:53:04 -0400
Message-ID: <000501c44dff$1d8919a0$fd010a0a@vbman>
From: "Simon Chow" <simonchow@keycommasia.com>
To: <linux-arm@lists.arm.linux.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Kernel 2.6.6 for SMDK2410 Compilation Problem
Date: Wed, 9 Jun 2004 16:52:26 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have tried kernel 2.6.6 to 2.6.7-rc3
Using Samsung S3C2410 - SMDK2410, when 'Support for console on S3C2410
serial port' is chosen, I have the following compilation problem:

drivers/built-in.o(.init.text+0x1084): In function
`serial_s3c2410_console_setup' : undefined reference to `uart_parse_options'
drivers/built-in.o(.init.text+0x10c0): In function
`serial_s3c2410_console_setup' : undefined reference to `uart_set_options'
make: *** [.tmp_vmlinux1] Error 1

Can anyone help solve this problem?

