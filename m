Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262054AbUKDC2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262054AbUKDC2o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 21:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbUKDC2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 21:28:34 -0500
Received: from ozlabs.org ([203.10.76.45]:54486 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262086AbUKDC0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 21:26:49 -0500
Date: Thu, 4 Nov 2004 13:12:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: jgarzik@mandrakesoft.com, orinoco-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Cosmetic updates for orinoco driver
Message-ID: <20041104021228.GA3949@zax>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	jgarzik@mandrakesoft.com, orinoco-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20041103022444.GA14267@zax> <20041103154407.4d9833ca.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041103154407.4d9833ca.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 03:44:07PM -0800, Andrew Morton wrote:
> David Gibson <david@gibson.dropbear.id.au> wrote:
> >
> > This patch reformats printk()s and some other cosmetic strings in the
> > orinoco driver.  Also moves, removes, and adds ratelimiting in some
> > places.  Behavioural changes are trivial/cosmetic only.  This reduces
> > the cosmetic/trivial differences between the current kernel version,
> > and the CVS version of the driver; one small step towards full merge.
> 
> This produces a ghastly reject storm against Jeff's bk-netdev tree.
> 
> I dunno how Jeff wants to handle that.  I stuck a copy of his current patch
> (against 2.6.10-rc1) at
> http://www.zip.com.au/~akpm/linux/patches/stuff/bk-netdev.patch and shall
> now run away.

Ah, looks like Al Viro did the ioread/iowrite conversion while I
wasn't looking.  Ok, with that netdev patch I should be able to fix
things up (and merge the iowrite conversion back into CVS).

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
