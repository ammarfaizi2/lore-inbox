Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263542AbTGKPt2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 11:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264082AbTGKPt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 11:49:28 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:57353 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S263542AbTGKPtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 11:49:19 -0400
Date: Fri, 11 Jul 2003 09:03:55 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
Message-ID: <20030711090355.C27491@one-eyed-alien.net>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030711140219.GB16433@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="XMCwj5IQnwKtuyBG"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030711140219.GB16433@suse.de>; from davej@codemonkey.org.uk on Fri, Jul 11, 2003 at 03:02:19PM +0100
Organization: One Eyed Alien Networks
X-Copyright: (C) 2003 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XMCwj5IQnwKtuyBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2003 at 03:02:19PM +0100, Dave Jones wrote:
> USB:
> ~~~~
> - Very little user visible changes, the only noticable 'major' change
>   is that there is now only one UHCI driver. As noted elsewhere, usbdevfs=
=20
>   got renamed to usbfs.

We may want to mention here that usb-storage has changed behavior.  A
device which is disconnected and then re-connected is not re-associated
with the old /dev/ node.  Also some performance enhancements.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

I see you've been reading alt.sex.chubby.sheep voraciously.
					-- Tanya
User Friendly, 11/24/97

--XMCwj5IQnwKtuyBG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/Dt/rIjReC7bSPZARAs9eAJ9xA3vGZBiYqIEa9tqioOK1ykBZugCcDR17
u4eIs6cmZcHmTzcmp+RtsqA=
=1VwI
-----END PGP SIGNATURE-----

--XMCwj5IQnwKtuyBG--
