Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267368AbUHDSh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267368AbUHDSh5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 14:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267372AbUHDSh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 14:37:56 -0400
Received: from irulan.endorphin.org ([212.13.208.107]:22291 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S267368AbUHDShs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 14:37:48 -0400
Subject: Re: Linux 2.6.8-rc3 - BSD licensing
To: James Morris <jmorris@redhat.com>
Cc: Jari Ruusu <jariruusu@users.sourceforge.net>,
       Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>
In-Reply-To: <Xine.LNX.4.44.0408041156310.9291-100000@dhcp83-76.boston.redhat.com>
References: <Xine.LNX.4.44.0408041156310.9291-100000@dhcp83-76.boston.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-q3q1O8vf/4yVl82PeivP"
Message-Id: <1091644663.21675.51.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 04 Aug 2004 20:37:43 +0200
From: Fruhwirth Clemens <clemens-dated-1092508666.9420@endorphin.org>
X-Delivery-Agent: TMDA/0.92 (Kauai King)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-q3q1O8vf/4yVl82PeivP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-08-04 at 18:00, James Morris wrote:
> On Wed, 4 Aug 2004, Jari Ruusu wrote:
>=20
> > Linus Torvalds wrote:
> > > Summary of changes from v2.6.8-rc2 to v2.6.8-rc3
> > [snip]
> > > James Morris:
> > >   o [CRYPTO]: Add i586 optimized AES
> >=20
> > My work on aes-i586.S is only licensed under original three clause BSD
> > license. You do not have my permission to change the license.
> >=20
> > Either use original license or drop this code.
>=20
> Can you assert licensing restrictions which override the original author'=
s
> (Brian Gladman)?  I don't know the answer, just asking.

Short: override no; add yes.

Long:
The BSD license starts with[1]:
''Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:=
''

The conditions followed by that sentence are compatible with the GPL
(legally), but the GPL does not include a verbatim copy of those
conditions, therefor these conditions must not be stripped. Thus, the
''instead of'' clause, added below the BSD conditions, is invalid for
sure.

However, I could add additional conditions to the list. If you reread
[1] carefully you will come to the conclusion that adding restrictions
does not affect the 3-clauses and therefor is legal to do (imagine this
as a series of logical ANDs). That's exactly the reason the FSF calls
BSD permissive and that's the reason Microsoft has used the BSD TCP/IP
stack.

As a matter of principle I do not add additional restrictions as respect
for the original author's efforts. But James, David or Linus might do
that, and by accident choose these additional restrictions to be like
those of the GPL. I would understand such action as I'd would like to
see that every kernel code is protected by the GPL.

The impotent difference is, the code is not GPL only. It's Dual BSD/GPL.
('/' does not mean OR). As the BSD license is effectively a legal subset
of the GPL, the GPL is the dominant and defining license here. At the
end that's all we want.

I advise to replace the ALTERNATIVELY paragraph of aes-i586.S by:
''Additionally all provisions of the GNU General Public License (GPL)
must be met''.=20

--=20
Fruhwirth Clemens <clemens@endorphin.org>  http://clemens.endorphin.org

--=-q3q1O8vf/4yVl82PeivP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBESz2W7sr9DEJLk4RApvXAJsE06fvECUiwYMyWQaNbWG+4I1FVgCfZwbX
LoMzw+4OHPzj6W7tvgpFd7Y=
=eE/P
-----END PGP SIGNATURE-----

--=-q3q1O8vf/4yVl82PeivP--
