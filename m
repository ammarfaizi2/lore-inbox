Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265900AbUIAJwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265900AbUIAJwt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 05:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265928AbUIAJwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 05:52:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36068 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265900AbUIAJwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 05:52:46 -0400
Date: Wed, 1 Sep 2004 11:52:29 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: filia@softhome.net
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: f_ops flag to speed up compatible ioctls in linux kernel
Message-ID: <20040901095229.GA11908@devserv.devel.redhat.com>
References: <courier.41359B53.00007549@softhome.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <courier.41359B53.00007549@softhome.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 01, 2004 at 03:50:11AM -0600, filia@softhome.net wrote:
> Hi! 
> 
> Stop being arrogant.
> Can you please elaborate on how to make Linux kernel support e.g. motion 
> controllers? They do not fit *any* known to me driver interface. They have 
> several axes, they have about twenty parameters (float or integer), and 

parameters nicely fit in sysfs.

> they have several commands, a-la start, graceful stop, abrupt stop. Plus 
> obviously diagnostics - about ten another commands with absolutely 
> different parameters. And about ten motion monitoring commands. And this is 
> one example I were need to program. 

a write() interface doesn't work???
Hard to believe, you even call them commands.
fd = open("/dev/funkydevice");
write(fd, "start");

doesn't sound insane to me


--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBNZvdxULwo51rQBIRAn9TAJ9g/0vOI78N3IWlGQ+VIiRmiUM8GgCaA5nv
bge8ZZcZswhO2oUY5SUH1Cs=
=5Rhn
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
