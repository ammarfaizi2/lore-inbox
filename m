Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbUCWQB3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 11:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262623AbUCWQB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 11:01:29 -0500
Received: from poros.telenet-ops.be ([195.130.132.44]:51882 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S262609AbUCWQB1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 11:01:27 -0500
From: Jan De Luyck <lkml@kcore.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] Sysfs for framebuffer
Date: Tue, 23 Mar 2004 17:01:16 +0100
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Kronos <kronos@kronoz.cjb.net>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
References: <20040320174956.GA3177@dreamland.darkstar.lan> <200403231211.09334.lkml@kcore.org> <20040323122627.GA22830@lambda>
In-Reply-To: <20040323122627.GA22830@lambda>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200403231701.19786.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 23 March 2004 13:26, Sven Luther wrote:

> > - From a users point of view: if there are only to be framebuffer devices
> > listed in this class, why not call it just what it is: "Framebuffer" ?
> > Naming it after something it is only in a broad sense makes no sense to
> > me. I'd be looking in /sys/.../framebuffer instead of /sys/.../graphics
> > or /display.
>
> Notice that /display is what is used by most OF implementations, so this
> kinda makes sense. I would vote like BenH on this if i was consulted.

OF implementations?

>
> > Display would be the EDID info of my screen (physical), and graphics...
> > well... I'd half expect something like capture cards to be there...
>
> But this also makes sense, still, i guess we are concerned with more
> info than just the framebuffer, right ?

Yup. What's in a name indeed. But one might try to make it as non-confusing as 
possible.

Kind regards,

Jan De Luyck

- -- 
Anything is possible on paper.
		-- Ron McAfee
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAYF9OUQQOfidJUwQRAlUCAJ9gevHf51xYtw7Zu4PAAI3Lq+VvJgCbByUB
c2zgx+ZzG9zKZo/9Lslr76s=
=zzhB
-----END PGP SIGNATURE-----
