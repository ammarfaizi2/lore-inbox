Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbWESK0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWESK0m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 06:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWESK0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 06:26:42 -0400
Received: from canuck.infradead.org ([205.233.218.70]:61917 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S932254AbWESK0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 06:26:42 -0400
Subject: Re: [PATCH] Add Amstrad Delta NAND support.
From: David Woodhouse <dwmw2@infradead.org>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Jonathan McDowell <noodles@earth.li>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060519100303.GB17270@wohnheim.fh-wedel.de>
References: <20060518160940.GS7570@earth.li>
	 <20060518165728.GA26113@wohnheim.fh-wedel.de>
	 <20060519090142.GB7570@earth.li>
	 <20060519100303.GB17270@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 May 2006 11:26:31 +0100
Message-Id: <1148034391.3875.109.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-19 at 12:03 +0200, Jörn Engel wrote: 
> > > And please create a structure containing both struct mtd_info and
> > > struct nand_chip.  Then use sizeof(that structure)...
> > 
> > This format is used throughout the drivers/mtd/nand/ directory. I'd
> > suggest it'd be more appropriate to have a separate patch that did this
> > for all of them if it's desired, rather than having each driver do its
> > own thing.

It's fine as-is. The claim that it's nicer to introduce an extra
datatype just for the allocation is subjective, at best.

> > Agreed on all the spacing comments you raised; hangovers from toto.c
> > that I used as a base.
> 
> We have suboptimal code in the kernel, true.  I still prefer new code
> to have slightly higher standards, so the overall quality improves
> slowly.  Therefore, pointing to the other ugly duckling is not an
> excuse for being mud-covered. ;)
> 
> But you are right.  The other ducklings could use a bath as well.

They already got it.

-- 
dwmw2

