Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbWIXWNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWIXWNe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 18:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWIXWNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 18:13:34 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:65480 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1751262AbWIXWNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 18:13:33 -0400
X-Sasl-enc: +1BIk2qpO0owTcT73m/zk0NTsVcuj1e3zEXzRxr0F6bz 1159136014
Message-ID: <4517036C.2050803@imap.cc>
Date: Mon, 25 Sep 2006 00:15:08 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.6) Gecko/20060729 SeaMonkey/1.0.4 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Chris Mason <mason@suse.com>,
       ext2-devel@lists.sourceforge.net, reiserfs-dev@namesys.com
Subject: Re: [2.6.18-rc7-mm1] slow boot
References: <4516B966.3010909@imap.cc> <20060924145337.ae152efd.akpm@osdl.org>
In-Reply-To: <20060924145337.ae152efd.akpm@osdl.org>
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA8DF09CCB0AC2DFA94F3BE57"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA8DF09CCB0AC2DFA94F3BE57
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 24.09.2006 23:53, Andrew Morton wrote:
> make-ext3-mount-default-to-barrier=3D1.patch takes my laptop's bootup t=
ime
> from 53 seconds to 68, which is rather painful.  In fact I'm inclined t=
o
> drop the patch because of this, and I'd also be quite concerned about t=
he
> similar reiserfs patch, make-reiserfs-default-to-barrier=3Dflush.patch.=


ReiserFS would be the relevant one for me. I'll go and see what
happens if I revert that one, then.

> But apart from that problem I see no differences in bootup time between=

> 2.6.18 and 2.6.18-mm1.
>=20
> Do you have the time to go through the
> http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt
> process?

I can't promise anything in the short term, but I'll try.

Thanks
Tilman

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Ungeoeffnet mindestens haltbar bis: (siehe Rueckseite)


--------------enigA8DF09CCB0AC2DFA94F3BE57
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD4DBQFFFwNsMdB4Whm86/kRAvXZAJ9nChCgwFrGmJF0wD//0+fBA6ADJwCYrSjB
uLsoO0reGnShtOwcfw4A+g==
=OYVh
-----END PGP SIGNATURE-----

--------------enigA8DF09CCB0AC2DFA94F3BE57--
