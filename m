Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263786AbTKKVY7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 16:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263792AbTKKVY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 16:24:59 -0500
Received: from gw02.mail.saunalahti.fi ([195.197.172.116]:56776 "EHLO
	gw02.mail.saunalahti.fi") by vger.kernel.org with ESMTP
	id S263786AbTKKVY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 16:24:58 -0500
Message-ID: <009001c3a89a$af611130$54dc10c3@amos>
From: "Kaj-Michael Lang" <milang@tal.org>
To: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0311101723110.2001-100000@logos.cnet>
Subject: Re: Linux 2.4.23-rc1
Date: Tue, 11 Nov 2003 23:27:59 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
>
> Here goes -rc1.
>
> It contains network driver fixes (b44, tg3, 8139cp), several x86-64
> bugfixes, amongst others.

Compiling for Alpha fails with:
...
gcc -D__KERNEL__ -I/work/collection/talinux/kernel/kernel24/tmp/alpha/linux-
2.4.22/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-alia
sing -fno-common -fomit-frame-pointer -pipe -mno-fp-regs -ffixed-8 -mcpu=ev5
 -Wa,-mev6   -nostdinc -iwithprefix
nclude -DKBUILD_BASENAME=agpgart_be  -DEXPORT_SYMTAB -c agpgart_be.c
agpgart_be.c:52: asm/msr.h: No such file or directory
agpgart_be.c:493: warning: `agp_generic_create_gatt_table' defined but not
used
agpgart_be.c:627: warning: `agp_generic_free_gatt_table' defined but not
used
...

Same config works fine for 2.4.22

-- 
Kaj-Michael Lang , milang@tal.org

