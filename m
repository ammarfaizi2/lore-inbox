Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265696AbUFOPxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265696AbUFOPxV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 11:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265736AbUFOPxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 11:53:21 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2832 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265696AbUFOPxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 11:53:20 -0400
Date: Tue, 15 Jun 2004 16:53:14 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/5] kbuild: default kernel image
Message-ID: <20040615165314.A7666@flint.arm.linux.org.uk>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
References: <20040614204029.GA15243@mars.ravnborg.org> <20040614204405.GB15243@mars.ravnborg.org> <20040614220549.L14403@flint.arm.linux.org.uk> <20040615044020.GC16664@mars.ravnborg.org> <20040615093807.A1164@flint.arm.linux.org.uk> <20040615153836.GC11113@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040615153836.GC11113@smtp.west.cox.net>; from trini@kernel.crashing.org on Tue, Jun 15, 2004 at 08:38:36AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 08:38:36AM -0700, Tom Rini wrote:
> I think what Sam was saying is that you document what boards are
> supported by what firmwares, in the Kconfig.  But what I don't think Sam
> saw would be just how ugly that's going to look (and become another
> point where every new board port touches, and possibly conflicts with
> another new board port).

Indeed - however, take a peek at arch/arm/tools/mach-types - that's a
list of the various machines which the ARM kernel may or may not have
been ported to.  Something suggests that creating a list of machine
types in the Kconfig help documentation will probably be unmanageable.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
