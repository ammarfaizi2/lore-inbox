Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965035AbWA3XD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965035AbWA3XD5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 18:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965028AbWA3XD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 18:03:57 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:17612
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965025AbWA3XDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 18:03:55 -0500
Date: Mon, 30 Jan 2006 15:02:44 -0800 (PST)
Message-Id: <20060130.150244.81476469.davem@davemloft.net>
To: sdbrady@ntlworld.com
Cc: ralf@linux-mips.org, grundler@parisc-linux.org, mita@miraclelinux.com,
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
In-Reply-To: <20060130195004.GA25860@miranda.arrow>
References: <20060129071242.GA24624@miranda.arrow>
	<20060130170647.GC3816@linux-mips.org>
	<20060130195004.GA25860@miranda.arrow>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stuart Brady <sdbrady@ntlworld.com>
Date: Mon, 30 Jan 2006 19:50:04 +0000

> Shame about popc on SPARC.  However, ffz is cheese, regardless of pops.
> (On sparc64, ffs is too.)  I'll wait for the generic bitops patches to
> be dealt with (or not) and then submit a patch fixing this if needed.

I'm happy with any improvement you might make here, for sure.

The sparc64 ffz() implementation was done so dog stupid like that
so that the code would be small since this gets inlined all over
the place.

So if you can keep it small and improve it, or make it a bit larger
and uninline it, that's great.
