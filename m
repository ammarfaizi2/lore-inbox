Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbUFTTeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUFTTeu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 15:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263709AbUFTTeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 15:34:50 -0400
Received: from mail1.kontent.de ([81.88.34.36]:25835 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261500AbUFTTes convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 15:34:48 -0400
From: Oliver Neukum <oliver@neukum.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: DMA API issues
Date: Sun, 20 Jun 2004 21:34:52 +0200
User-Agent: KMail/1.6.2
Cc: Ian Molton <spyro@f2s.com>, rmk+lkml@arm.linux.org.uk, david-b@pacbell.net,
       Linux Kernel <linux-kernel@vger.kernel.org>, greg@kroah.com,
       tony@atomide.com, jamey.hicks@hp.com, joshua@joshuawise.com
References: <1087584769.2134.119.camel@mulgrave> <200406202002.47025.oliver@neukum.org> <1087759622.10858.97.camel@mulgrave>
In-Reply-To: <1087759622.10858.97.camel@mulgrave>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200406202134.58657.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Sonntag, 20. Juni 2004 21:27 schrieb James Bottomley:
> On Sun, 2004-06-20 at 13:02, Oliver Neukum wrote:
> > > The DMA API is about allowing devices to transact directly with memory
> > > behind the memory controller, it's an API that essentially allows the
> > > I/O controller and memory controller to communicate without CPU
> > > intervention.  This is still possible through the hypervisor, so the
> > > iSeries currently fully implements the DMA API.
> > 
> > Then what's the problem?
> 
> If you look at the diagram, you'll see that the OHCI memory isn't behind
> the memory controller...

And that means what? We don't care about how memory is implemented
in the machines we run on. All we care about is the consequences of the
implementation.
We have an area of memory here that the CPU and a subset of devices
can directly access. What to do about it?

	Regards
		Oliver
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA1ebgbuJ1a+1Sn8oRAnFdAJ45v2h3fUe7NIPVxyS9CmH69vEHLgCghgQe
qXQVLQOlkEabmPVqmCOaSq8=
=35je
-----END PGP SIGNATURE-----
