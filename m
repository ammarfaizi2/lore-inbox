Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266243AbUHaSEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266243AbUHaSEl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 14:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266188AbUHaSC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 14:02:56 -0400
Received: from the-village.bc.nu ([81.2.110.252]:64136 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266115AbUHaSCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 14:02:44 -0400
Subject: Re: [parisc-linux] [PATCH] New error codes for Alpha, MIPS,
	PA-RISC, Sparc & Sparc64
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, rth@twiddle.net, linux-mips@linux-mips.org,
       HPPA List <parisc-linux@parisc-linux.org>, sparclinux@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <13071.1093965134@redhat.com>
References: <20040830232445.0b5aad79.akpm@osdl.org>
	 <13071.1093965134@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093971614.599.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 31 Aug 2004 18:00:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-08-31 at 16:12, David Howells wrote:
> The attached patch adds the new error codes I added for key-related errors to
> those archs that don't make use of <asm-generic/errno.h>, including Alpha,
> MIPS, PA-RISC, Sparc and Sparc64. This is required to compile with CONFIG_KEYS
> on those platforms.

The patch seems to be mixing the fixups for remapping these error codes
into sparc, hpux, osf/1 and other compatibility layers on the platforms

