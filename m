Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbVIUOj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbVIUOj4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 10:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbVIUOj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 10:39:56 -0400
Received: from MAIL.13thfloor.at ([212.16.62.50]:18058 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1750999AbVIUOjz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 10:39:55 -0400
Date: Wed, 21 Sep 2005 16:39:54 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] eliminate CLONE_* duplications
Message-ID: <20050921143954.GA10137@MAIL.13thfloor.at>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20050921092132.GA4710@MAIL.13thfloor.at> <Pine.LNX.4.61.0509211252160.3743@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0509211252160.3743@scrub.home>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 12:55:10PM +0200, Roman Zippel wrote:
> Hi,
> 
> On Wed, 21 Sep 2005, Herbert Poetzl wrote:
> 
> > some archs (alpha,cris,ia64,ppc/64,v850) map those
> > values via asm-offsets.c, others (cris-*,hppa/64)
> > redefine the values in the asm code ...
> 
> Please fix cris-*,hppa/64 instead to use asm-offsets.c.

please elaborate _why_ we would want a bunch of
additional DEFINE entries in each arch instead of a
simple include file?

TIA,
Herbert

> bye, Roman
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
