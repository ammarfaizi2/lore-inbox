Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbVILTRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbVILTRp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 15:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbVILTRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 15:17:45 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52939 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932120AbVILTRo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 15:17:44 -0400
Date: Mon, 12 Sep 2005 20:17:44 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: [PATCHSET] 2.6.13-git12-bird1
Message-ID: <20050912191744.GN25261@ZenIV.linux.org.uk>
References: <20050905035848.GG5155@ZenIV.linux.org.uk> <20050905155522.GA8057@mipter.zuzino.mipt.ru> <20050905160313.GH5155@ZenIV.linux.org.uk> <20050905164712.GI5155@ZenIV.linux.org.uk> <20050905212026.GL5155@ZenIV.linux.org.uk> <20050907183131.GF5155@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050907183131.GF5155@ZenIV.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patchset moved to -git12.  News:
	* playing catch-up with spinlock changes (m68k build got broken)
	* playing catch-up with kbuild changes (arm, uml)
	* usual assorted build fixes
	* assorted sparse annotations
	* beginning of endianness annotations merge: RPC patches from Alexey
	* beginning of linux/irq.h work

Patch is in usual place.  Patch itself is patch-2.6.13-git12-bird1.bz2,
splitup is in patchset/, logs in logs/*/*log21c.

Shortlog follows.

Alexey Dobriyan:
	*	sunrpc endianness annotations
	*	lockd endianness annotations
	*	nfs endianness annotations
Russell King:
	*	assorted arm annotations
Al Viro:
	*	C99 initializers (ray_cs)
	*	OUTPUT_ARCH() on ppc should be powerpc:common
	*	UML early build sanitized
	*	__iomem annotations (epca)
	*	__iomem annotations (i810-i2c)
	*	__iomem annotations (sata_promise)
	*	__iomem annotations (sata_sil)
	*	__iomem annotations (sata_vsc)
	*	__user annotations (saa6588)
	*	beginning of linux/irq.h cleanup - amd64
	*	bogus casts in lne390
	*	cyblafb: portability fixes, sanitized work with pointers
	*	fixed dependency in early arm build
	*	ibm_emac annotations
	*	missing include (cs89x0)
	*	s2io: use %p, damnit...
	*	sparc exports: no more wanking with weak aliases for .div et.al.
	*	trivial sparse warnings in net/*
	*	uml kconfig sanitized around drivers/net
	*	updated m68k vmlinux.lds to include LOCK_TEXT
