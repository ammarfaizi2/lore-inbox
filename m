Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267233AbTAKOUE>; Sat, 11 Jan 2003 09:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267235AbTAKOUE>; Sat, 11 Jan 2003 09:20:04 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:12804 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267233AbTAKOUA>; Sat, 11 Jan 2003 09:20:00 -0500
Date: Sat, 11 Jan 2003 14:28:40 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andi Kleen <ak@muc.de>
Cc: Christoph Hellwig <hch@infradead.org>, jgarzik@pobox.com, mantel@suse.de,
       Natalie.Protasevich@UNISYS.com, linux-kernel@vger.kernel.org
Subject: Re: UnitedLinux violating GPL?
Message-ID: <20030111142839.A29018@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andi Kleen <ak@muc.de>, jgarzik@pobox.com, mantel@suse.de,
	Natalie.Protasevich@UNISYS.com, linux-kernel@vger.kernel.org
References: <20030109224013$6e5e@gated-at.bofh.it> <20030111110011$3252@gated-at.bofh.it> <m3n0m729bb.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m3n0m729bb.fsf@averell.firstfloor.org>; from ak@muc.de on Sat, Jan 11, 2003 at 12:51:52PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2003 at 12:51:52PM +0100, Andi Kleen wrote:
> openssl is only compiled as a module in released kernels, so it is similar to
> the PPP BSD compression module.

It compiles parts of openssl which explicitly have a license that conflicts
with the GPL when CONFIG_PPP=y.  The bsd_comp stuff was only compilable as
module.

> In the current version the copyright note in es7000.[ch] reads:
> 
>  * Copyright (c) 2002 Unisys Corporation.  All Rights Reserved.
>  *
>  * This program is free software; you can redistribute it and/or modify it
>  * under the terms of version 2 of the GNU General Public License as
>  * published by the Free Software Foundation.
>  *
>  * This program is distributed in the hope that it would be useful, but
>  * WITHOUT ANY WARRANTY; without even the implied warranty of
>  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>  *
>  * Further, this software is distributed without any warranty that it is
>  * free of the rightful claim of any third person regarding infringement


>  * or the like.  Any license provided herein, whether implied or
>  * otherwise, applies only to this software file.  Patent licenses, if
>  * any, provided herein do not apply to combinations of this program with
>  * other software, or any other product whatsoever.

I don't think this clause is GPL-compliant.  But I'm not a lawyer, so..


