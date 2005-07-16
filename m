Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVGPUyC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVGPUyC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 16:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVGPUyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 16:54:02 -0400
Received: from smtp2.globo.com ([200.208.9.169]:39314 "EHLO smtp2.globo.com")
	by vger.kernel.org with ESMTP id S261231AbVGPUyB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 16:54:01 -0400
Message-ID: <001a01c58a48$f15057e0$3dfea8c0@glupfire>
From: "GlupFire" <porranenhuma@globo.com>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel Panic: VFS cannot open a root device
Date: Sat, 16 Jul 2005 17:57:08 -0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




> Hi , i have kernel 2.4.29 at slack 10.1 and when I upgrade my kernel to
> 2.6.11 I get these erros on booting
>
> VFS: Cannot open a root device "301" or unknow block
> please append a correct "root" boot option
> KERNEL PANIC :  not syncing; VFS; Unable to mount root fs on unknown-block
> (3,1)
>
> I have compiled my kernel with my IDE support and also with my file system
> support with built-in option.
>
> My LILO.CONF
> image = /boot/vmlinuz-2.6.11
> root = /dev/hda1
> label = 2.6.11
> initrd = /boot/initrd.gz
> read-only
>
> I googled this problem, and I think is a kind of bug, and i tryed to patch
> the kernel with Alan Cox patch 2.6.11-ac7.bzip  and I get these ::
> bzip2 -dc /usr/src/patch-2.6.11.ac7.bzip | patch -p1 -s
> 1 out of hunk FAILED --saving rejects to file Makefike.rej
>
> and I cat the file Makefile.rej
>
> ***************
> *** 1,8 ****
> VERSION = 2
> PATCHLEVEL = 6
> SUBLEVEL = 11
> - EXTRAVERSION =
> - NAME=Woozy Numbat
>
> # *DOCUMENTATION*
> # To see a list of typical targets execute "make help"
> --- 1,8 ---- 
> VERSION = 2
> PATCHLEVEL = 6
> SUBLEVEL = 11
> + EXTRAVERSION = ac7
> + NAME=AC
>
> # *DOCUMENTATION*
> # To see a list of typical targets execute "make help"
>
> I'm stuck! The patch dont work fine ( I think the patch is not installed
> succesfully on my kernel )
> I'm booting with my image of kernel 2.4.29..... i'm 5 days tryng to solve
> this problem ...
> any kind of help is wellcome... sorry for my english.
>

