Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268138AbTAKU12>; Sat, 11 Jan 2003 15:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268141AbTAKU12>; Sat, 11 Jan 2003 15:27:28 -0500
Received: from eamail1-out.unisys.com ([192.61.61.99]:61603 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S268138AbTAKU11>; Sat, 11 Jan 2003 15:27:27 -0500
Message-ID: <3FAD1088D4556046AEC48D80B47B478C022BD8DC@usslc-exch-4.slc.unisys.com>
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: Andi Kleen <ak@muc.de>, "'Christoph Hellwig'" <hch@infradead.org>,
       "'alan@lxorguk.ukuu.org.uk'" <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, mantel@suse.de,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       linux-kernel@vger.kernel.org
Subject: RE: UnitedLinux violating GPL?
Date: Sat, 11 Jan 2003 14:34:46 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Unisys gave people their code to use GPL. At worst the mythical 'suse evil
>empire' forgot to fix a comment or two. (comment from Alan Cox)


I can explain what happened with Unisys GPL: Unisys intended to give the
souce out under GPL, but we didn't know exactly how to do this. So, we just
copied the clauses from some other source (I believe it was some IBM
authored file) and used it. Even though it looked like a good way to go,
SuSE asked us to fix some wording so it serve better to expression of GPL. I
realize that when it come to companies not individuals giving out their code
under GPL, all sorts of problems can come up and everyone is understandably
careful... 

Well, maybe, someone needs to establish an unquestionable wording so
everyone can use it. We would be happy to change our license any time to
make it compliant.


-Natalie Protasevich
Unisys

-----Original Message-----
From: Christoph Hellwig [mailto:hch@infradead.org]
Sent: Saturday, January 11, 2003 7:29 AM
To: Andi Kleen
Cc: Christoph Hellwig; jgarzik@pobox.com; mantel@suse.de;
Natalie.Protasevich@UNISYS.com; linux-kernel@vger.kernel.org
Subject: Re: UnitedLinux violating GPL?


On Sat, Jan 11, 2003 at 12:51:52PM +0100, Andi Kleen wrote:
> openssl is only compiled as a module in released kernels, so it is similar
to
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

