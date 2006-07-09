Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbWGIWzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbWGIWzq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 18:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWGIWzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 18:55:45 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:45549 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S932459AbWGIWzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 18:55:45 -0400
X-Sasl-enc: wQo5IRLz85pOSYQA3UT+XkZVRiCIDKkh+ZycMhyOP+jS 1152485740
Message-ID: <44B189D3.4090303@imap.cc>
Date: Mon, 10 Jul 2006 00:57:23 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.12) Gecko/20050915
X-Accept-Language: de,en,fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>, Mike Galbraith <efault@gmx.de>
Subject: Re: 2.6.18-rc1-mm1: /sys/class/net/ethN becoming symlink befuddled
 /sbin/ifup
References: <6wDCq-5xj-25@gated-at.bofh.it> <6wM2X-1lt-7@gated-at.bofh.it> <6wOxP-4QN-5@gated-at.bofh.it>
In-Reply-To: <6wOxP-4QN-5@gated-at.bofh.it>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8E6C74E5ACF958D5433ABF66"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8E6C74E5ACF958D5433ABF66
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09.07.2006 23:00, Andrew Morton wrote:

> On Sun, 09 Jul 2006 20:22:09 +0200
> Mike Galbraith <efault@gmx.de> wrote:
>=20
>>As $subject says, up-to-date SuSE 10.0 /sbin/ifup became confused...

Same here.

> I'd be suspecting
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc=
1/2.6.18-rc1-mm1/broken-out/gregkh-driver-network-class_device-to-device.=
patch.
>=20
> If you could do a `patch -R' of that one it'd really help, thanks.

Tried that, but failed with:

  LD      .tmp_vmlinux1
net/built-in.o: In function `dev_change_name':
: undefined reference to `class_device_rename'

Not sure whether that's an unclean patch reversal because of conflicts
with other patches (had a few "fuzz" and "offset" messages during the
patch -R), will have a look tomorrow.

HTH
Tilman

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Stuttgart ist viel sch=F6ner als Berlin!


--------------enig8E6C74E5ACF958D5433ABF66
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEsYnTMdB4Whm86/kRArXOAJ43e27KB456NbyYMPYj5gcZCU/A3gCfZbz5
jFEwQc0pWdt6m7AwiFGbasY=
=/cyn
-----END PGP SIGNATURE-----

--------------enig8E6C74E5ACF958D5433ABF66--
