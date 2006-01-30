Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWA3EDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWA3EDf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 23:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbWA3EDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 23:03:34 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:16361
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750805AbWA3EDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 23:03:33 -0500
Date: Sun, 29 Jan 2006 20:03:35 -0800 (PST)
Message-Id: <20060129.200335.69237695.davem@davemloft.net>
To: sdbrady@ntlworld.com
Cc: grundler@parisc-linux.org, mita@miraclelinux.com,
       linux-kernel@vger.kernel.org, ink@jurassic.park.msu.ru, spyro@f2s.com,
       dev-etrax@axis.com, dhowells@redhat.com, ysato@users.sourceforge.jp,
       torvalds@osdl.org, linux-ia64@vger.kernel.org, takata@linux-m32r.org,
       linux-m68k@vger.kernel.org, gerg@uclinux.org, linux-mips@linux-mips.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       linux390@de.ibm.com, linuxsh-dev@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, uclinux-v850@lsi.nec.co.jp, ak@suse.de,
       chris@zankel.net
Subject: Re: [parisc-linux] Re: [PATCH 3/6] C-language equivalents of
 include/asm-*/bitops.h
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060129071242.GA24624@miranda.arrow>
References: <20060126230443.GC13632@colo.lackof.org>
	<20060126230353.GC27222@flint.arm.linux.org.uk>
	<20060129071242.GA24624@miranda.arrow>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stuart Brady <sdbrady@ntlworld.com>
Date: Sun, 29 Jan 2006 07:12:42 +0000

> There are versions of hweight*() for sparc64 which use POPC when
> ULTRA_HAS_POPULATION_COUNT is defined, but AFAICS, it's never defined.

That's right, the problem here is that no chips actually implement
the instruction in hardware, it is software emulated, ie. useless :-)
