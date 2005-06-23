Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbVFWDsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbVFWDsN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 23:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbVFWDsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 23:48:13 -0400
Received: from atpro.com ([12.161.0.3]:58898 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S262020AbVFWDsG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 23:48:06 -0400
Date: Wed, 22 Jun 2005 23:45:04 -0400
From: Jim Crilly <jim@why.dont.jablowme.net>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: "David S. Miller" <davem@davemloft.net>, gregkh@suse.de, torvalds@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devfs: remove devfs from Kconfig preventing it from being built
Message-ID: <20050623034504.GL21897@mail>
Mail-Followup-To: "Martin J. Bligh" <mbligh@mbligh.org>,
	"David S. Miller" <davem@davemloft.net>, gregkh@suse.de,
	torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20050621.214527.71091057.davem@davemloft.net> <258190000.1119422406@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <258190000.1119422406@[10.10.2.4]>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/21/05 11:40:06PM -0700, Martin J. Bligh wrote:
> >> > However, this does mean I do need to reinstall a couple
> >> > debian boxes here to something newer before I can continue
> >> > doing kernel work in 2.6.x on them.
> >> 
> >> Those boxes rely on devfs?
> > 
> > Yeah, when I forget to turn on DEVFS_FS and DEVFS_MOUNT in the
> > kernel config the machine won't boot. :-)
> > 
> >> Can't you just grab the "static dev" debian package and continue on?
> >> I'm sure there is one in there somewhere (don't really know for sure,
> >> not running debian anywhere here, sorry.)
> >> 
> >> Or how about a tarball of a /dev tree?  Would that help you out?
> > 
> > I don't know if Debian has such a package.
> > 
> > Don't worry, I'll take care of this by simply reinstalling
> > and thus moving to udev.
> 
> ??? I use debian sarge all the time with kernel.org kernels that don't
> have devfs compiled in, and I don't use udev either. Works across ia32,
> x86_64, and PPC64 (32 bit userspace) at least, with no trouble at all,
> out of the box. I did the same with Woody as well before that ...

I think he's just saying that since he did the install with devfs enabled
and has been using devfs device names, a conversion back to 'standard'
names would be a major PITA. It's definately possible to convert, but if
there's not much on the boxes a reinstall might be quicker.

> 
> M.

Jim.

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
