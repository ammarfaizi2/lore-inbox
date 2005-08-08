Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbVHHSkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbVHHSkm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 14:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVHHSkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 14:40:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:29636 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932177AbVHHSkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 14:40:42 -0400
Date: Mon, 8 Aug 2005 09:08:46 -0700
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>, ralf@linux-mips.org
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       linville@redhat.com
Subject: Re: pci_update_resource() getting called on sparc64
Message-ID: <20050808160846.GA7710@kroah.com>
References: <20050808.071211.74753610.davem@davemloft.net> <20050808144439.GA6478@kroah.com> <20050808.103304.55507512.davem@davemloft.net> <Pine.LNX.4.58.0508081131540.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508081131540.3258@g5.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 11:32:41AM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 8 Aug 2005, David S. Miller wrote:
> >
> > From: Greg KH <greg@kroah.com>
> > Date: Mon, 8 Aug 2005 07:44:40 -0700
> > 
> > > http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=43c34735524d5b1c9b9e5d63b49dd4c1b394bde4
> > > 
> > > Although in glancing at it, it might not be the reason...
> > 
> > No, that isn't it.
> > 
> > Perhaps it was one of those changes that Linus was doing
> > to deal with interrupt setting restoration after resume?
> 
> Not likely.
> 
> Sounds like fec59a711eef002d4ef9eb8de09dd0a26986eb77, which came in 
> through Greg. I'm surprised Greg didn't pick up on that one.

I didn't pick up on that one, as David acked it a while ago :)

{sigh}  I only pushed that one as Ralf insisted that he needed it for
some of his hardware and that there wasn't any bad side-affects.  Ralf,
any objections to removing this for 2.6.13?

thanks,

greg k-h
