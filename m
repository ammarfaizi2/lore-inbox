Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVFVEpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVFVEpo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 00:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262640AbVFVEpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 00:45:44 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:64695
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261343AbVFVEpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 00:45:38 -0400
Date: Tue, 21 Jun 2005 21:45:27 -0700 (PDT)
Message-Id: <20050621.214527.71091057.davem@davemloft.net>
To: gregkh@suse.de
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devfs: remove devfs from Kconfig preventing it from
 being built
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050622041330.GB27716@suse.de>
References: <20050621222419.GA23896@kroah.com>
	<20050621.155919.85409752.davem@davemloft.net>
	<20050622041330.GB27716@suse.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg KH <gregkh@suse.de>
Date: Tue, 21 Jun 2005 21:13:30 -0700

> On Tue, Jun 21, 2005 at 03:59:19PM -0700, David S. Miller wrote:
> > From: Greg KH <gregkh@suse.de>
> > Date: Tue, 21 Jun 2005 15:24:19 -0700
> > 
> > However, this does mean I do need to reinstall a couple
> > debian boxes here to something newer before I can continue
> > doing kernel work in 2.6.x on them.
> 
> Those boxes rely on devfs?

Yeah, when I forget to turn on DEVFS_FS and DEVFS_MOUNT in the
kernel config the machine won't boot. :-)

> Can't you just grab the "static dev" debian package and continue on?
> I'm sure there is one in there somewhere (don't really know for sure,
> not running debian anywhere here, sorry.)
> 
> Or how about a tarball of a /dev tree?  Would that help you out?

I don't know if Debian has such a package.

Don't worry, I'll take care of this by simply reinstalling
and thus moving to udev.
