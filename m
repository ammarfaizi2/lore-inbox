Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267370AbUG2AdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267370AbUG2AdE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 20:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267385AbUG2A3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 20:29:49 -0400
Received: from ozlabs.org ([203.10.76.45]:2729 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267394AbUG2A3D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 20:29:03 -0400
Date: Thu, 29 Jul 2004 10:19:18 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>, jt@hpl.hp.com,
       Dan Williams <dcbw@redhat.com>, Pavel Roskin <proski@gnu.org>,
       Orinoco Development List <orinoco-devel@lists.sourceforge.net>
Subject: Re: [0/15] orinoco merge preliminaries
Message-ID: <20040729001918.GD15321@zax>
Mail-Followup-To: Francois Romieu <romieu@fr.zoreil.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	jt@hpl.hp.com, Dan Williams <dcbw@redhat.com>,
	Pavel Roskin <proski@gnu.org>,
	Orinoco Development List <orinoco-devel@lists.sourceforge.net>
References: <20040712213349.A2540@electric-eye.fr.zoreil.com> <40F57D78.9080609@pobox.com> <20040715010137.GB3697@zax> <41068E4B.2040507@pobox.com> <20040728065128.GC16908@zax> <20040729005029.A11537@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040729005029.A11537@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 12:50:29AM +0200, Francois Romieu wrote:
> David Gibson <hermes@gibson.dropbear.id.au> :
> [...]
> > Ok, patchbombing commences.
> 
> I have updated/resynced my serie on top of 2.6.8-rc2-mm1 + the 15
> posted patches.
> 
> The patches are available at
> http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.8-rc2-mm1/patches/
> 
> A (patch-scripts) tarball is available at:
> http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.8-rc2-mm1/blob.tar.bz2
> 
> The difference with the 'for_linus' branch which is still to be splitted:
> http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.8-rc2-mm1/TODO.patch

Ah.. note that some changes in mainline I've folded back into CVS
rather than the other way around.  Also, in the process of the merge
I've made some whitespace and other such cleanups which I've folded
back into CVS.  Your TODO patch has bogus diffs reverting those
changes, so you'll want to update your CVS tree and rediff.

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
