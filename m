Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVCZWuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVCZWuq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 17:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVCZWuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 17:50:46 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:5642 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261332AbVCZWud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 17:50:33 -0500
Date: Sat, 26 Mar 2005 22:50:26 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ARM] Group device drivers together under their own menu
Message-ID: <20050326225026.D23306@flint.arm.linux.org.uk>
Mail-Followup-To: Matthew Wilcox <matthew@wil.cx>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200503261912.j2QJC192031517@hera.kernel.org> <20050326214141.GR21986@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050326214141.GR21986@parcelfarce.linux.theplanet.co.uk>; from matthew@wil.cx on Sat, Mar 26, 2005 at 09:41:41PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2005 at 09:41:41PM +0000, Matthew Wilcox wrote:
> On Sat, Mar 05, 2005 at 11:58:51AM +0000, Linux Kernel Mailing List wrote:
> > ChangeSet 1.1982.137.48, 2005/03/05 11:58:51+00:00, rmk@flint.arm.linux.org.uk
> > 
> > 	[ARM] Group device drivers together under their own menu
> 
> Any reason you can't merge ARM's options into the drivers/*/Kconfig (with
> appropriate conditionals) and use drivers/Kconfig?

Dunno.  Haven't gotten around to sorting that out yet, and I don't
particularly fancy trying to fight any corners over it.

I think, a while back, it was thought to be better to keep ARM separate
to keep the conditionals out of drivers/Kconfig.

If the general concensus has changed, I might eventually sort it out if
it causes enough trouble, or people think there's sufficient value to it.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
