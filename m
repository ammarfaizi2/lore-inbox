Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbWIGPiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWIGPiS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 11:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWIGPiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 11:38:18 -0400
Received: from cantor2.suse.de ([195.135.220.15]:64973 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932227AbWIGPiR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 11:38:17 -0400
Date: Thu, 7 Sep 2006 08:37:46 -0700
From: Greg KH <greg@kroah.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, Fernando Vazquez <fernando@oss.ntt.co.jp>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       stable@kernel.org, "David S. Miller" <davem@davemloft.net>,
       devel@openvz.org, xemul@openvz.org
Subject: Re: [stable] [PATCH] IA64,sparc: local DoS with corrupted ELFs
Message-ID: <20060907153746.GA29602@kroah.com>
References: <44FC193C.4080205@openvz.org> <Pine.LNX.4.64.0609061120430.27779@g5.osdl.org> <20060906182733.GJ2558@parisc-linux.org> <20060906184509.GA15942@kroah.com> <20060906191215.GK2558@parisc-linux.org> <20060906192511.GA14579@kroah.com> <1157634702.30159.89.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157634702.30159.89.camel@aeonflux.holtmann.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 03:11:42PM +0200, Marcel Holtmann wrote:
> Hi Greg,
> 
> > > > Yes, but the -stable developers don't build for those arches, that's why
> > > > it was missed here.
> > > 
> > > What's the easiest way to get coverage here?  Sending a parisc
> > > workstation or server to someone?  Giving accounts to some/all of the
> > > stable team?  Finding someone who cares about parisc to join the stable
> > > team?
> > 
> > How about: Someone from that arch trying out the -stable release
> > canidates to make sure it doesn't break anything on their arches /
> > favorite machine?
> 
> this won't work for security hot-fixes, because you basically don't do a
> release candidate for them. We should think about this, too.

Well, short of me and Chris getting one of every arch out there (which I
don't recommend), I think we will just get by as we have been doing in
the past.

thanks,

greg k-h
