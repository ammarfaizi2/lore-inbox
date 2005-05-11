Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbVEKAH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbVEKAH1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 20:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVEKAHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 20:07:25 -0400
Received: from attila.bofh.it ([213.92.8.2]:23498 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id S261854AbVEKAFa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 20:05:30 -0400
Date: Wed, 11 May 2005 02:05:19 +0200
To: Greg KH <gregkh@suse.de>, "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       Rusty Russell <rusty@rustcorp.com.au>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Roman Kagan <rkagan@mail.ru>
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
Message-ID: <20050511000519.GA17762@wonderland.linux.it>
Mail-Followup-To: Greg KH <gregkh@suse.de>,
	"Alexander E. Patrakov" <patrakov@ums.usu.ru>,
	Rusty Russell <rusty@rustcorp.com.au>,
	linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, Roman Kagan <rkagan@mail.ru>
References: <1115717357.10222.1.camel@localhost.localdomain> <20050510094339.GC6346@wonderland.linux.it> <4280AFF4.6080108@ums.usu.ru> <20050510172447.GA11263@wonderland.linux.it> <20050510201355.GB3226@suse.de> <20050510203156.GA14979@wonderland.linux.it> <20050510205239.GA3634@suse.de> <20050510210823.GB15541@wonderland.linux.it> <20050510232207.A7594@banaan.localdomain> <20050511015509.B7594@banaan.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <20050511015509.B7594@banaan.localdomain>
User-Agent: Mutt/1.5.9i
From: md@Linux.IT (Marco d'Itri)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 11, Erik van Konijnenburg <ekonijn@xs4all.nl> wrote:

Thank you for your patch! I have two comments:
- the blacklist should be used only if modprobe is run by the kernel
  (check $SEQNUM?)
- I think it could just look at the directory, the old file can be
  trivially moved or simlinked in it on upgrades.

--=20
ciao,
Marco

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCgUw/FGfw2OHuP7ERAn76AJsG2VY+gjrW0wYBg37/57RMDFFm2wCfQsn9
URAVs+wwdfG4Vmk61yWzI54=
=FDa5
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
