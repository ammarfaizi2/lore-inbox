Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262902AbVFVIrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbVFVIrG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 04:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbVFVInQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 04:43:16 -0400
Received: from smtp04.auna.com ([62.81.186.14]:751 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S262845AbVFVIhs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 04:37:48 -0400
Date: Wed, 22 Jun 2005 08:37:46 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: [PATCH] devfs: remove devfs from Kconfig preventing it from
 being built
To: linux-kernel@vger.kernel.org
References: <20050621222419.GA23896@kroah.com>
	<20050621.155919.85409752.davem@davemloft.net>
	<20050622041330.GB27716@suse.de>
	<20050621.214527.71091057.davem@davemloft.net>
	<2cd57c900506212323ca68045@mail.gmail.com>
In-Reply-To: <2cd57c900506212323ca68045@mail.gmail.com> (from
	coywolf@gmail.com on Wed Jun 22 08:23:36 2005)
X-Mailer: Balsa 2.3.3
Message-Id: <1119429466l.8047l.1l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.212.68] Login:jamagallon@able.es Fecha:Wed, 22 Jun 2005 10:37:46 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.22, Coywolf Qi Hunt wrote:
> On 6/22/05, David S. Miller <davem@davemloft.net> wrote:
> > From: Greg KH <gregkh@suse.de>
> > Date: Tue, 21 Jun 2005 21:13:30 -0700
> > 
> > > On Tue, Jun 21, 2005 at 03:59:19PM -0700, David S. Miller wrote:
> > > > From: Greg KH <gregkh@suse.de>
> > > > Date: Tue, 21 Jun 2005 15:24:19 -0700
> > > >
> > > > However, this does mean I do need to reinstall a couple
> > > > debian boxes here to something newer before I can continue
> > > > doing kernel work in 2.6.x on them.
> > >
> > > Those boxes rely on devfs?
> > 
> > Yeah, when I forget to turn on DEVFS_FS and DEVFS_MOUNT in the
> > kernel config the machine won't boot. :-)
> > 
> > > Can't you just grab the "static dev" debian package and continue on?
> > > I'm sure there is one in there somewhere (don't really know for sure,
> > > not running debian anywhere here, sorry.)
> > >
> > > Or how about a tarball of a /dev tree?  Would that help you out?
> 
> There's /sbin/MAKEDEV on debian.
> 
> > 
> > I don't know if Debian has such a package.
> > 
> > Don't worry, I'll take care of this by simply reinstalling
> > and thus moving to udev.
> 
> Moving to udev is right. Still you need a "static dev" in case your
> udev not working.
> 
> Use /sbin/MAKEDEV from makedev package.
> 

A nice addition to udev package would be an standard minimal /dev tree
to allow booting till init and running udev as the first thing...
A tar.gz you could just unpack on a new box or on an initrd.

;)

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.12-jam1 (gcc 4.0.1 (4.0.1-0.2mdk for Mandriva Linux release 2006.0))


