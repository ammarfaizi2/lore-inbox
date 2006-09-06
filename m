Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWIFTah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWIFTah (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 15:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWIFTah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 15:30:37 -0400
Received: from mail.kroah.org ([69.55.234.183]:24472 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932084AbWIFTag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 15:30:36 -0400
Date: Wed, 6 Sep 2006 12:25:11 -0700
From: Greg KH <greg@kroah.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Linus Torvalds <torvalds@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       tony.luck@intel.com, linux-ia64@vger.kernel.org,
       Fernando Vazquez <fernando@oss.ntt.co.jp>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       stable@kernel.org, "David S. Miller" <davem@davemloft.net>,
       devel@openvz.org, xemul@openvz.org
Subject: Re: [stable] [PATCH] IA64,sparc: local DoS with corrupted ELFs
Message-ID: <20060906192511.GA14579@kroah.com>
References: <44FC193C.4080205@openvz.org> <Pine.LNX.4.64.0609061120430.27779@g5.osdl.org> <20060906182733.GJ2558@parisc-linux.org> <20060906184509.GA15942@kroah.com> <20060906191215.GK2558@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060906191215.GK2558@parisc-linux.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2006 at 01:12:16PM -0600, Matthew Wilcox wrote:
> On Wed, Sep 06, 2006 at 11:45:09AM -0700, Greg KH wrote:
> > On Wed, Sep 06, 2006 at 12:27:33PM -0600, Matthew Wilcox wrote:
> > > On Wed, Sep 06, 2006 at 11:24:05AM -0700, Linus Torvalds wrote:
> > > > If MIPS and parisc don't matter for the stable tree (very possible - there 
> > > > are no big commercial distributions for them), then dammit, neither should 
> > > > ia64 and sparc (there are no big commercial distros for them either). 
> > > 
> > > Erm, RHEL and SLES both support ia64.
> > 
> > Yes, but the -stable developers don't build for those arches, that's why
> > it was missed here.
> 
> What's the easiest way to get coverage here?  Sending a parisc
> workstation or server to someone?  Giving accounts to some/all of the
> stable team?  Finding someone who cares about parisc to join the stable
> team?

How about: Someone from that arch trying out the -stable release
canidates to make sure it doesn't break anything on their arches /
favorite machine?

And no, I really don't want a parisc machine here :)

thanks,

greg k-h
