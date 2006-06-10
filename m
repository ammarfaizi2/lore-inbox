Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030358AbWFJOHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030358AbWFJOHT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 10:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030364AbWFJOHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 10:07:19 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:60178 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1030358AbWFJOHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 10:07:17 -0400
Date: Sat, 10 Jun 2006 16:07:14 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Theodore Tso <tytso@mit.edu>, Sven-Haegar Koch <haegar@sdinet.de>,
       Michael Poole <mdpoole@troilus.org>, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       cmm@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 0/13] extents and 48bit ext3
Message-ID: <20060610140713.GA1475@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Theodore Tso <tytso@mit.edu>, Sven-Haegar Koch <haegar@sdinet.de>,
	Michael Poole <mdpoole@troilus.org>, Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@osdl.org>,
	Christoph Hellwig <hch@infradead.org>, cmm@us.ibm.com,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <20060609091327.GA3679@infradead.org> <20060609030759.48cd17a0.akpm@osdl.org> <44899653.1020007@garzik.org> <87irnab33v.fsf@graviton.dyn.troilus.org> <Pine.LNX.4.64.0606100245130.12765@mercury.sdinet.de> <20060610010651.GA20202@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060610010651.GA20202@thunk.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 09:06:51PM -0400, Theodore Tso wrote:
> On Sat, Jun 10, 2006 at 02:49:32AM +0200, Sven-Haegar Koch wrote:
> > I see a different problem with "ext3 + extends is not ext3 anymore" when 
> > the feature goes mainstream:
> > - user with old distri, no extends in use, no kernel support for them
> > - user has some kind of problem
> > - uses new rescue disk (aka knoppix at the time of problem) - that then
> >   is current stuff, and certainly uses extents - fixes problem on disk
> >   (may be a simple as running lilo/grub from chroot, happens often for me)
> > - tries to boot back into his distri -> *boom* he lost
> 
> Incorrect, because unless you explicitly enable the use of extents,
> the mere act of using a new kernel such as might be found on knoppix
> will not result in the filesystem utilizing the extent feature.

And how shall the rescue/live CD know whether to use the feature?

  OG.
