Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269280AbUJKV7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269280AbUJKV7Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 17:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269301AbUJKV40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 17:56:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:3974 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269316AbUJKVyp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 17:54:45 -0400
Date: Mon, 11 Oct 2004 14:58:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jack Byer <ojbyer@usa.net>
Cc: linux-kernel@vger.kernel.org, Thayne Harbaugh <tharbaugh@lnxi.com>
Subject: Re: 2.6.9-rc4-mm1
Message-Id: <20041011145838.051c1a9d.akpm@osdl.org>
In-Reply-To: <cke3fj$eoh$1@sea.gmane.org>
References: <20041011032502.299dc88d.akpm@osdl.org>
	<cke3fj$eoh$1@sea.gmane.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please don't remove me from Cc:

Jack Byer <ojbyer@usa.net> wrote:
>
> When I try to compile this kernel, I get the following error:
> 
>    Using /usr/src/linux-2.6.9-rc4-mm1 as source for kernel
>    CHK     include/linux/version.h
> make[2]: `arch/i386/kernel/asm-offsets.s' is up to date.
>    CHK     include/asm-i386/asm_offsets.h
>    CHK     include/linux/compile.h
>    GEN_INITRAMFS_LIST usr/initramfs_list
> Using shipped usr/initramfs_list
>    CPIO    usr/initramfs_data.cpio
> ERROR: unable to open 'usr/initramfs_list': No such file or directory

You need to create usr/initramfs_list.

Thayne, some documentation would be nice.
