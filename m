Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUCNOj6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 09:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbUCNOj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 09:39:58 -0500
Received: from oliv.bezeqint.net ([192.115.104.12]:57557 "EHLO
	oliv.bezeqint.net") by vger.kernel.org with ESMTP id S263003AbUCNOjz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 09:39:55 -0500
Date: Sun, 14 Mar 2004 16:39:06 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: finding out the value of HZ from userspace
Message-ID: <20040314143906.GF3829@luna.mooo.com>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <20040311141703.GE3053@luna.mooo.com> <200403140245.i2E2jKSx005375@eeyore.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403140245.i2E2jKSx005375@eeyore.valparaiso.cl>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2004 at 11:45:17PM -0300, Horst von Brand wrote:
> Micha Feigin <michf@post.tau.ac.il> said:
> > Is it possible to find out what the kernel's notion of HZ is from user
> > space?
> 
> What for? It should be invisible to userspace...
> 

Its not. Some proc interfaces expect time in jiffies, which means
knowing HZ (bdflush in 2.4 or xfs for example).

> > It seem to change from system to system and between 2.4 (100 on i386)
> > to 2.6 (1000 on i386).
> 
> And can also be tweaked when compiling, and depends on architecture, and...
> -- 
> Dr. Horst H. von Brand                   User #22616 counter.li.org
> Departamento de Informatica                     Fono: +56 32 654431
> Universidad Tecnica Federico Santa Maria              +56 32 654239
> Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>  
>  +++++++++++++++++++++++++++++++++++++++++++
>  This Mail Was Scanned By Mail-seCure System
>  at the Tel-Aviv University CC.
> 
