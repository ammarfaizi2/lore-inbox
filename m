Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbUCUTgG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 14:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbUCUTgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 14:36:06 -0500
Received: from smtprelay01.ispgateway.de ([62.67.200.156]:29380 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S261202AbUCUTgD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 14:36:03 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] Sysfs for framebuffer
Date: Sun, 21 Mar 2004 09:02:33 +0100
User-Agent: KMail/1.6
Cc: Greg KH <greg@kroah.com>, Kronos <kronos@kronoz.cjb.net>,
       linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
References: <20040320174956.GA3177@dreamland.darkstar.lan> <20040320215219.GA20277@dreamland.darkstar.lan> <20040320215909.GA26277@kroah.com>
In-Reply-To: <20040320215909.GA26277@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200403210902.35913.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 20 March 2004 22:59, Greg KH wrote:
> Well, /sys/class/video is already taken by the V4L core code, so if
> "graphics" doesn't confuse people, it's ok with me.

I think it DOES confuse people. If they see that, they think the kernel
has (got) a graphics subsystem (now). That is simply not true, since it
is not even the lowest layer of the graphics subsystem in Linux, except
on a few special cases. It is just an basic accelerated 2D framebuffer. 
No more, no less.

When we have all devices in that class, that are needed to run fully
accelerated 3D graphics, without any direct hardware access, then we
could call it "graphics class" without any confusion.

So PLEASE consider this confusion or people will start argueing with me
whether Linux has an in kernel graphics subsystem (like KGI once) and
not all people can be convinced by code, because not all are coders
anymore ;-)


Thanks & regards

Ingo Oeser

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAXUwZU56oYWuOrkARAi2SAKCWOIOvQp5PtVbfZuudMoiXauX1OACg0Ji4
s0R/gqsMRXLbsm5iU2c4MDg=
=K/NA
-----END PGP SIGNATURE-----

