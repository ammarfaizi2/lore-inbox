Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269298AbUJKWML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269298AbUJKWML (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 18:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269292AbUJKWLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 18:11:01 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:36487 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S269289AbUJKWKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 18:10:35 -0400
Date: Mon, 11 Oct 2004 15:10:34 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jack Byer <ojbyer@usa.net>, linux-kernel@vger.kernel.org,
       Thayne Harbaugh <tharbaugh@lnxi.com>
Subject: Re: 2.6.9-rc4-mm1
Message-ID: <20041011221034.GD8121@smtp.west.cox.net>
References: <20041011032502.299dc88d.akpm@osdl.org> <cke3fj$eoh$1@sea.gmane.org> <20041011145838.051c1a9d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041011145838.051c1a9d.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2004 at 02:58:38PM -0700, Andrew Morton wrote:
> 
> Please don't remove me from Cc:
> 
> Jack Byer <ojbyer@usa.net> wrote:
> >
> > When I try to compile this kernel, I get the following error:
> > 
> >    Using /usr/src/linux-2.6.9-rc4-mm1 as source for kernel
> >    CHK     include/linux/version.h
> > make[2]: `arch/i386/kernel/asm-offsets.s' is up to date.
> >    CHK     include/asm-i386/asm_offsets.h
> >    CHK     include/linux/compile.h
> >    GEN_INITRAMFS_LIST usr/initramfs_list
> > Using shipped usr/initramfs_list
> >    CPIO    usr/initramfs_data.cpio
> > ERROR: unable to open 'usr/initramfs_list': No such file or directory
> 
> You need to create usr/initramfs_list.
> 
> Thayne, some documentation would be nice.

Was this was O= ?  I could be mis-remembering things, but there is a
default usr/initramfs_list, but when you compile with O=, you don't get
the default list.

-- 
Tom Rini
http://gate.crashing.org/~trini/
