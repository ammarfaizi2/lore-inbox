Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265317AbUGDCRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265317AbUGDCRz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 22:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265331AbUGDCRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 22:17:55 -0400
Received: from ozlabs.org ([203.10.76.45]:2179 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265317AbUGDCRv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 22:17:51 -0400
Date: Sun, 4 Jul 2004 12:13:04 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: jt@hpl.hp.com, Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Dan Williams <dcbw@redhat.com>, Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Update in-kernel orinoco drivers to upstream current CVS
Message-ID: <20040704021304.GD25992@zax>
Mail-Followup-To: David Gibson <hermes@gibson.dropbear.id.au>,
	Francois Romieu <romieu@fr.zoreil.com>, jt@hpl.hp.com,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Dan Williams <dcbw@redhat.com>, Pavel Roskin <proski@gnu.org>
References: <20040702222655.GA10333@bougret.hpl.hp.com> <20040703010709.A22334@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040703010709.A22334@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 03, 2004 at 01:07:09AM +0200, Francois Romieu wrote:
> Jean Tourrilhes <jt@bougret.hpl.hp.com> :
> [...]
> > 	The difference between 0.13e and 0.15rc1+ is not small. I
> > believe Pavel did a good job in splitting the various patches in small
> > pieces when adding them to the CVS, and David has tracked the kernel,
> > but reconciliating the two branches is no trivial matter.
> 
> I have extracted a few things from the bz2 ball that Dan sent (against
> 2.6.7-mm5 which already contains some orinoco bits):
> 
> -rw-r--r--    1 romieu   users        4564 jui  3 00:47 orinoco-10.patch
> -rw-r--r--    1 romieu   users       15999 jui  3 00:47 orinoco-20.patch
> -rw-r--r--    1 romieu   users       33135 jui  3 00:47 orinoco-30.patch
> -rw-r--r--    1 romieu   users       11463 jui  3 00:47 orinoco-40.patch
> 
> Available at http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.7-mm5/
> 
> So far the patches lack comments but they are quite simple.

Aha, that's a good start.  During the week I'll try to look at these,
put my rubber stamp on them, and send them on to Jeff.

One thing I notice though (from your later ones, actually) is that you
seem to be moving from current 2.6 to the CVS HEAD branch.  That
includes the orinoco_usb stuff, which I still don't think is done
right and would rather not push.  I know this is asking a bir of a
favour, given how useless I've been at doing the update myself, but
your patches would be much more useful if they aimed at the CVS
"for_linus" branch.

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
