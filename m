Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264966AbUGOBZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264966AbUGOBZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 21:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265971AbUGOBYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 21:24:06 -0400
Received: from ozlabs.org ([203.10.76.45]:33466 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264966AbUGOBJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 21:09:26 -0400
Date: Thu, 15 Jul 2004 11:01:37 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Francois Romieu <romieu@fr.zoreil.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>, jt@hpl.hp.com,
       Dan Williams <dcbw@redhat.com>, Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Slowly update in-kernel orinoco drivers to upstream current CVS
Message-ID: <20040715010137.GB3697@zax>
Mail-Followup-To: David Gibson <hermes@gibson.dropbear.id.au>,
	Jeff Garzik <jgarzik@pobox.com>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	jt@hpl.hp.com, Dan Williams <dcbw@redhat.com>,
	Pavel Roskin <proski@gnu.org>
References: <20040712213349.A2540@electric-eye.fr.zoreil.com> <40F57D78.9080609@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40F57D78.9080609@pobox.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 02:37:44PM -0400, Jeff Garzik wrote:
> Francois Romieu wrote:
> >A serie of patches is available for at:
> >http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.7-mm7
> >
> >It contains 12 patches and applies against 2.6.7-mm7. The patches are
> >commented. The comments are partly taken from the cvs log by Pavel Roskin.
> >
> >Tarball available at:
> >http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.7-mm7/orinoco.tar.bz2
> >
> >Please review/comment/suggest a target to patch-bomb.
> 
> Feel free to patchbomb me in private.
> 
> Ideally the obvious, simple-to-review changes come first?

I've started to have a look at the patches.  Unfortunately, they're
still not really as logically separated as they should be.  Which I
guess means I wasn't sufficiently disciplined putting them into CVS in
the first place.

I've started working on my own series of logical patches, starting
with, as you say the "content free" ones first.  Initial set with
series file at
       http://www.ozlabs.org/people/dgibson/orinoco-patches

Nothing there so far that should cause any functional change.

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
