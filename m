Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265146AbUGODNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265146AbUGODNf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 23:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265222AbUGODNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 23:13:34 -0400
Received: from ozlabs.org ([203.10.76.45]:42941 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265146AbUGODNc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 23:13:32 -0400
Date: Thu, 15 Jul 2004 11:26:56 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Pavel Roskin <proski@gnu.org>
Cc: Francois Romieu <romieu@fr.zoreil.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, jt@hpl.hp.com,
       Dan Williams <dcbw@redhat.com>
Subject: Re: [PATCH] Slowly update in-kernel orinoco drivers to upstream current CVS
Message-ID: <20040715012656.GD3697@zax>
Mail-Followup-To: David Gibson <hermes@gibson.dropbear.id.au>,
	Pavel Roskin <proski@gnu.org>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Jeff Garzik <jgarzik@pobox.com>, jt@hpl.hp.com,
	Dan Williams <dcbw@redhat.com>
References: <20040712213349.A2540@electric-eye.fr.zoreil.com> <Pine.LNX.4.60.0407141605460.1799@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0407141605460.1799@marabou.research.att.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 04:15:59PM -0400, Pavel Roskin wrote:
> On Mon, 12 Jul 2004, Francois Romieu wrote:
> 
> >A serie of patches is available for at:
> >http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.7-mm7
> >
> >It contains 12 patches and applies against 2.6.7-mm7. The patches are
> >commented. The comments are partly taken from the cvs log by Pavel Roskin.
> 
> I hope the patches lead to the CVS version on the "for_linus" branch which 
> has no compatibility code.  I'm quite comfortable with the "for_linus" and 
> "Standalone" branches.
> 
> As for the HEAD branch, it has unfinished (skeleton only) prism_usb driver 
> meant for Intersil Prism USB devices (such as DWL-122).  It also has 
> working orinoco_usb driver.  Unfortunately, I don't feel good about that 
> code.  The way how this code is integrated with the common code is 
> questionable.  A lot of work would be needed to handle USB better. 
> That's not something that could be done before the next release.

I concur.

> I'm very busy now and I don't have time to finish the little bits I 
> planned for the 0.15 release.  However, the CVS version on the "for_linus" 
> branch is releasable and has no known regressions compared to any previous 
> version.  Feel free to apply the patches to the kernel now.  I expect to 
> have more time for free software in the end of August.

Good to hear.

> If David is OK, we could release the current code as version 0.15.  I'm OK 
> with it.  I have to adapt my ambitions to my time constraints.  

I'm reasonably comfortable with that.  I now have a handful of things
to commit before 0.15 which I've picked up while doing the merge with
mainline, but it's just whitespace and other trivialities.

> I'll 
> appreciate if my name is added to the MAINTAINERS file once the new driver 
> is committed.

Absolutely.  Haven't put that patch together yet, but it's coming :)

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
