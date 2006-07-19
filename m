Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030223AbWGSTM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbWGSTM2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 15:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbWGSTM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 15:12:28 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:64143 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1030223AbWGSTM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 15:12:27 -0400
X-Sasl-enc: XemMoRi8ATBJI3APkJp1HtfyMTVXO3ANhET0yb2n0+M+ 1153336339
Message-ID: <44BE8415.2040907@imap.cc>
Date: Wed, 19 Jul 2006 21:12:21 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.12) Gecko/20050915
X-Accept-Language: de,en,fr
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Matthias Andree <matthias.andree@gmx.de>,
       Grzegorz Kulewski <kangur@polcom.net>,
       Diego Calleja <diegocg@gmail.com>, arjan@infradead.org,
       caleb@calebgray.com
Subject: Re: Reiser4 Inclusion
References: <44BAFDB7.9050203@calebgray.com> <1153128374.3062.10.camel@laptopd505.fenrus.org> <Pine.LNX.4.63.0607171242350.10427@alpha.polcom.net> <20060717160618.013ea282.diegocg@gmail.com> <Pine.LNX.4.63.0607171611080.10427@alpha.polcom.net> <20060717155151.GD8276@merlin.emma.line.org> <Pine.LNX.4.61.0607180951480.16615@yvahk01.tjqt.qr> <20060718204718.GD18909@merlin.emma.line.org> <fake-message-id-1@fake-server.fake-domain> <84144f020607190403y1a659c99oc795ae244390c2ee@mail.gmail.com>            <44BE50A0.9070107@imap.cc> <200607191904.k6JJ4cf0002159@turing-police.cc.vt.edu>
In-Reply-To: <200607191904.k6JJ4cf0002159@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4C229C2DB2E5B307048F1AE3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4C229C2DB2E5B307048F1AE3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 19.07.2006 21:04, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 19 Jul 2006 17:32:48 +0200, Tilman Schmidt said:
> =20
>>Well, that doesn't make sense. You can't have your cake and eat it
>>too. Either you have out-of-tree code or you haven't. Documents
>>like stable_api_nonsense.txt explicitly discourage out-of-tree code,
>>which is formally equivalent to saying that all kernel code should
>>be in-tree. Therefore an attitude which says "go on developing that
>>code out-of-tree, it's not ready for inclusion yet" is in direct
>>contradiction with the foundations of the no-stable-API policy.
>=20
> Which part of "read Documentation/SubmittingPatches.txt and do what it =
says,
> or it doesn't get into the kernel" do you have trouble understanding?

None. Why do you think I'd have? And what relevance does this have to
the present discussion?

> It isn't a case of "out of tree code or you haven't". There's actually
> *three* major categories:
>=20
> 1) Code that's already in-tree and maintained.  These guys don't need t=
o
> worry about the API, as it will usually get handled free of charge.
>=20
> 2) Code that's out-of-tree, but a potential (after possible rework) can=
didate
> for submission (for instance, the hi-res timers, CKRM, some drivers, et=
c).
> These guys need to forward-port their code for API changes as they work=

> towards getting their code into the tree.
>=20
> 3) Code that's out-of-tree, but is so far out in left field that there'=
s
> no way it will ever go in.  For instance, that guy with the MVS JCL emu=
lator
> better not be holding his breath waiting.  And quite frankly, nobody el=
se
> really cares whether they forward port their code or not.

Correct. And you could easily subdivide it further. Your point being?

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enig4C229C2DB2E5B307048F1AE3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEvoQcMdB4Whm86/kRAlU0AJ4n/rCVJkTz2HLtaU1qwDkNUho9pwCfYBBm
AQXfZ/p6LnzXwxmnk9ss1Tw=
=KLxL
-----END PGP SIGNATURE-----

--------------enig4C229C2DB2E5B307048F1AE3--
