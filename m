Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbTKLKE3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 05:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTKLKE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 05:04:29 -0500
Received: from safe15.bezeqint.net ([212.179.95.61]:32969 "EHLO
	safe15.bezeqint.net") by vger.kernel.org with ESMTP id S261812AbTKLKE1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 05:04:27 -0500
From: Okrain Genady <mafteah@mafteah.co.il>
Reply-To: mafteah@mafteah.co.il
Organization: Mafteah
To: Vid Strpic <vms@bofhlet.net>
Subject: Re: ide-scsi: "Sleeping function called from invalid context", 2.6.0-test9
Date: Wed, 12 Nov 2003 12:06:55 +0200
User-Agent: KMail/1.5.4
References: <20031112080119.GD21265@home.bofhlet.net>
In-Reply-To: <20031112080119.GD21265@home.bofhlet.net>
Cc: Berke Durak <obdk65536@ouvaton.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_/Ygs/fERvMBH7QP";
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200311121206.55323.mafteah@mafteah.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_/Ygs/fERvMBH7QP
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

Yep, I have that problem too.

On Wednesday 12 November 2003 10:01, Vid Strpic wrote:
> On Tue, Nov 11, 2003 at 04:30:41PM +0100, Berke Durak wrote:
> > I get a kernel problem while using cdrecord to write audio to a blank
> > CD-R.
> > This happens with 2.6.0-test6 and 2.6.0-test9 with kernel
> > preemptibility enabled.
> > The distribution is a Debian 3.0r1/testing.
> > Kernel output, cdrecord output and dmesg follows.
>
> [...]
>
> Oh wonderful.  It has happenned to me, too, test9, Slackware 9.1,
> cdrecord 2.0a19 (same as yours).  I think there's a problem with DMA -
> it wasnt' enabled when this happened.  When I enabled it, CD's burned
> normally.  And this happened only when I built SCSI support (sg, sr_mod)
> as modules.. when in core, DMA is enabled automatically and _stays_
> enabled...

=2D-=20
|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0Okr=
ain Genady
|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
=A0E-Mail=A0=A0=A0=A0=A0=A0=A0=A0=A0: mafteah@mafteah.co.il
=A0ICQ=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0: 73163402
=A0Home Page=A0=A0=A0=A0=A0=A0: http://www.mafteah.co.il/
=A0GnuGP=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0: 0x4F892EE6 At http://pgp.mit.edu/
=A0Fingerprint=A0=A0=A0=A0: 5853 E821 5EF2 69BC A9AE 3F24 1F7C F79F 408D 4A=
EE
|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|

--Boundary-02=_/Ygs/fERvMBH7QP
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/sgY/H3z3n0CNSu4RAtqzAJwNirx6Zb/OgN7gSqc+LnlF26tA5ACfZPcj
q9s/xg65BL3L0JBjGLpLWDo=
=SLpP
-----END PGP SIGNATURE-----

--Boundary-02=_/Ygs/fERvMBH7QP--

