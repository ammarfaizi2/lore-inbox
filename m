Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288787AbSAaAjR>; Wed, 30 Jan 2002 19:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287386AbSAaAjH>; Wed, 30 Jan 2002 19:39:07 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:2529 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S289369AbSAaAiv>;
	Wed, 30 Jan 2002 19:38:51 -0500
Date: Wed, 30 Jan 2002 19:38:49 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: David Dyck <dcd@tc.fluke.com>, linux-kernel@vger.kernel.org,
        R.E.Wolff@BitWizard.nl
Subject: Re: 2.5.3 missing <linux/malloc.h>
Message-ID: <20020130193849.A18001@havoc.gtf.org>
In-Reply-To: <Pine.LNX.4.33.0201301239370.19671-100000@dd.tc.fluke.com> <20020130154434.L763@lynx.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020130154434.L763@lynx.adilger.int>; from adilger@turbolabs.com on Wed, Jan 30, 2002 at 03:44:34PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 03:44:34PM -0700, Andreas Dilger wrote:
> > and I've noticed that many source files have
> >   #include <linux/slab.h>     /* kmalloc(), kfree() */
> > instead of trying to include linux/malloc.h
> 
> That's because they have been updated, and the other ones have not.
> Don't ask me _why_ it was changed that way, but it was.

Cuz malloc.h has been an empty shell since the 2.0.x days or so.

	Jeff



