Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVBHANJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVBHANJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 19:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVBHANI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 19:13:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:45207 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261350AbVBHANG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 19:13:06 -0500
Date: Mon, 7 Feb 2005 16:18:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Daniel Drake <dsd@gentoo.org>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3: Kylix application no longer works?
Message-Id: <20050207161810.23fcc4f1.akpm@osdl.org>
In-Reply-To: <420801D7.3020405@gentoo.org>
References: <20050207221107.GA1369@elf.ucw.cz>
	<20050207145100.6208b8b9.akpm@osdl.org>
	<420801D7.3020405@gentoo.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake <dsd@gentoo.org> wrote:
>
> > # fs/binfmt_elf.c
> > #   2005/01/17 13:37:56-08:00 ecd@skynet.be +43 -19
> > #   [SPARC64]: Missing user access return value checks in fs/binfmt_elf.c and fs/compat.c
> > # 
> 
> I think so. For a short period we applied this patch to the Gentoo 2.6.10 
> kernel...
> 
> http://dev.gentoo.org/~dsd/gentoo-dev-sources/release-10.01/dist/1900_umem_catch.patch
> 
> ...but removed it once users complained it stopped kylix binaries from running.

Bah.  That's what happens when you fix stuff.

What's kylix?  The Borland C++ builder thing?

How should one set about reproducing this problem?
