Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262614AbVFVENz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262614AbVFVENz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 00:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbVFVENz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 00:13:55 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:38450 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S262614AbVFVENm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 00:13:42 -0400
Date: Tue, 21 Jun 2005 21:13:30 -0700
From: Greg KH <gregkh@suse.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devfs: remove devfs from Kconfig preventing it from being built
Message-ID: <20050622041330.GB27716@suse.de>
References: <20050621222419.GA23896@kroah.com> <20050621.155919.85409752.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050621.155919.85409752.davem@davemloft.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2005 at 03:59:19PM -0700, David S. Miller wrote:
> From: Greg KH <gregkh@suse.de>
> Date: Tue, 21 Jun 2005 15:24:19 -0700
> 
> > Here's a much smaller patch to simply disable devfs from the build.  If
> > this goes well, and there are no complaints for a few weeks, I'll resend
> > my big "devfs-die-die-die" series of patches that rip the whole thing
> > out of the kernel tree.
> > 
> > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> I know the rational behind this.
> 
> However, this does mean I do need to reinstall a couple
> debian boxes here to something newer before I can continue
> doing kernel work in 2.6.x on them.

Those boxes rely on devfs?

Can't you just grab the "static dev" debian package and continue on?
I'm sure there is one in there somewhere (don't really know for sure,
not running debian anywhere here, sorry.)

Or how about a tarball of a /dev tree?  Would that help you out?

thanks,

greg k-h
