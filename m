Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVGTLhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVGTLhF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 07:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbVGTLhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 07:37:05 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:31762 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261169AbVGTLhC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 07:37:02 -0400
Date: Wed, 20 Jul 2005 13:40:01 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: LKML Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: inotify - i dont get a inotify device
Message-ID: <20050720114001.GB10223@irc.pl>
Mail-Followup-To: LKML Mailinglist <linux-kernel@vger.kernel.org>
References: <1121858078.17798.2.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+nBD6E3TurpgldQp"
Content-Disposition: inline
In-Reply-To: <1121858078.17798.2.camel@localhost>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+nBD6E3TurpgldQp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 20, 2005 at 01:14:38PM +0200, Kasper Sandberg wrote:
> hello.. i have a small problem with inotify in kernel 2.6.13-rc3-git4 -
> i do not get the inotify device, i know i build it in,
> gzcat /proc/config.gz | grep -i inotify confirms it, and i have a very
> new udev, where inotify is in the rules file, i tried udevstart but it
> did not create me the inotify device..
> anyone that can help? perhaps a fix is known?

 Inotify got converted to using syscall. There is no longer a device
node. You can check the details of using inotify here:
http://rlove.org/log/2005071401.html

--=20
Tomasz Torcz                 "God, root, what's the difference?"
zdzichu@irc.-nie.spam-.pl         "God is more forgiving."


--+nBD6E3TurpgldQp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFC3jgRThhlKowQALQRAqINAJ4pPuRVs5t94W5N0QPCHuQzLs5jiQCeOM7U
icnww560AdCPBVqNRW+o6po=
=xKQe
-----END PGP SIGNATURE-----

--+nBD6E3TurpgldQp--
