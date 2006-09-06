Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751603AbWIFU2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbWIFU2W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 16:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbWIFU2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 16:28:22 -0400
Received: from 1wt.eu ([62.212.114.60]:15122 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751602AbWIFU2V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 16:28:21 -0400
Date: Wed, 6 Sep 2006 22:27:20 +0200
From: Willy Tarreau <w@1wt.eu>
To: Greg KH <greg@kroah.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, Fernando Vazquez <fernando@oss.ntt.co.jp>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       stable@kernel.org, "David S. Miller" <davem@davemloft.net>,
       devel@openvz.org, xemul@openvz.org
Subject: Re: [stable] [PATCH] IA64,sparc: local DoS with corrupted ELFs
Message-ID: <20060906202720.GA541@1wt.eu>
References: <44FC193C.4080205@openvz.org> <Pine.LNX.4.64.0609061120430.27779@g5.osdl.org> <20060906182733.GJ2558@parisc-linux.org> <20060906184509.GA15942@kroah.com> <20060906191215.GK2558@parisc-linux.org> <20060906192511.GA14579@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060906192511.GA14579@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2006 at 12:25:11PM -0700, Greg KH wrote:
> On Wed, Sep 06, 2006 at 01:12:16PM -0600, Matthew Wilcox wrote:
> > On Wed, Sep 06, 2006 at 11:45:09AM -0700, Greg KH wrote:
> > > On Wed, Sep 06, 2006 at 12:27:33PM -0600, Matthew Wilcox wrote:
> > > > On Wed, Sep 06, 2006 at 11:24:05AM -0700, Linus Torvalds wrote:
> > > > > If MIPS and parisc don't matter for the stable tree (very possible - there 
> > > > > are no big commercial distributions for them), then dammit, neither should 
> > > > > ia64 and sparc (there are no big commercial distros for them either). 
> > > > 
> > > > Erm, RHEL and SLES both support ia64.
> > > 
> > > Yes, but the -stable developers don't build for those arches, that's why
> > > it was missed here.
> > 
> > What's the easiest way to get coverage here?  Sending a parisc
> > workstation or server to someone?  Giving accounts to some/all of the
> > stable team?  Finding someone who cares about parisc to join the stable
> > team?
> 
> How about: Someone from that arch trying out the -stable release
> canidates to make sure it doesn't break anything on their arches /
> favorite machine?

IMHO it's even simpler than that. You already announce release candidates
with what you intend to push into next -stable. Those who complain that
-stable breaks on them just get what they deserve. They're free to announce
the problem and even provide a patch in order to fix the problem in next
-stable ASAP, but I find it a bit easy to complain about the -stable team
that some fixes break a few rarely tested pieces of software !

I'd prefer that we get slightly more -stable releases with a few ones
potentially wrong on rare occasions, than fewer ones which get released
only once everyone agrees (ie mostly never).

> And no, I really don't want a parisc machine here :)

I have one right here serving my web pages, but I have to check that
my toolchain is still OK (I don't build on it - 32 MB, NFS root). You
don't know what you're missing :-)

> thanks,
> 
> greg k-h

Regards,
Willy

