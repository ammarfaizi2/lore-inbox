Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbUKWRgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbUKWRgS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 12:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbUKWRfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 12:35:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56222 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261364AbUKWQXw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 11:23:52 -0500
Date: Tue, 23 Nov 2004 09:42:04 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "O. Sezer" <sezeroz@ttnet.net.tr>, linux-kernel@vger.kernel.org
Subject: Re: ISO9660 file size limitation
Message-ID: <20041123114204.GD4524@logos.cnet>
References: <20041118083638.CVFG2440.fep02.ttnet.net.tr@localhost> <20041118221052.GA26378@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041118221052.GA26378@animx.eu.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 05:10:53PM -0500, Wakko Warner wrote:
> > 2.6 took a better route making cruft a mount time option.
> > I use the attached patch against 2.4.28, ported from the
> > patches by Andries Brouwer posted at:
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=103420043728469&w=2
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=108808967926140&w=2
> > 
> > Why do I have a feeling that Marcelo would reject this :/
> 
> Hmm, dunno.  The diffs in the email definately took care of this as well.

Looks necessary and well tested, has just been applied to v2.4 tree.

> > diff -urN 28/fs/isofs/inode.c 28_aac/fs/isofs/inode.c
> > --- 28/fs/isofs/inode.c	2002-11-29 01:53:15.000000000 +0200
> > +++ 28_aac/fs/isofs/inode.c	2004-11-17 14:39:56.000000000 +0200
> > diff -urN 28/include/linux/iso_fs.h 28_aac/include/linux/iso_fs.h
> > --- 28/include/linux/iso_fs.h	2002-02-25 21:38:13.000000000 +0200
> > +++ 28_aac/include/linux/iso_fs.h	2004-11-17 14:39:57.000000000 +0200
> 
> -- 
>  Lab tests show that use of micro$oft causes cancer in lab animals
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
