Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264625AbUEEMs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264625AbUEEMs6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 08:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264635AbUEEMs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 08:48:58 -0400
Received: from moutng.kundenserver.de ([212.227.126.173]:3038 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264625AbUEEMss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 08:48:48 -0400
From: Patrick Dreker <patrick@dreker.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH] for idle=C1halt, 2.6.5
Date: Wed, 5 May 2004 14:48:25 +0200
User-Agent: KMail/1.6.2
Cc: "Allen Martin" <AMartin@nvidia.com>, <linux-kernel@vger.kernel.org>,
       "Ross Dickson" <ross@datscreative.com.au>,
       "Len Brown" <len.brown@intel.com>
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49FC2D@mail-sc-6-bk.nvidia.com> <200405040111.01514.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200405040111.01514.bzolnier@elka.pw.edu.pl>
X-message-flag: Please send plain text messages only. Thank you.
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_ZKOmAvw7xW5rR75";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405051448.25319.patrick@dreker.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:55d40479e9cc6e4ab087ddd2b9b4bce4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_ZKOmAvw7xW5rR75
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Dienstag, 4. Mai 2004 01:11 schrieb Bartlomiej Zolnierkiewicz:
> On Tuesday 04 of May 2004 00:09, Allen Martin wrote:
> > I'm happy to be able to make this information public to the Linux
> > community.  This information has been previously released to BIOS /
> > board vendors as an appnote, but in the interest of getting a workaround
> > into the hands of users the quickest we're making it public for possible
> > inclusion into the Linux kernel.
>
> This is a great news!  Below is an untested patch to address this issue.
The patch also applies cleanly to kernel 2.6.5, which is what I am running.=
=20
The machine is now running for more than 21 hours with APIC enabled and it=
=20
seems it is completely stable now. Without the patch I was able to lock the=
=20
system solid in less than a minute by just pushing some MB of data across t=
he=20
LAN. I have been running continuous network copies of a 400MB file for abou=
t=20
8 hours and experienced no problems.

As a side note: the idle CPU temperature reported by ACPI on my Shuttle=20
iDeq200N barebone has gone from approx. 50 degrees down to approx. 43=20
degrees.

Patrick
=2D-=20
Patrick Dreker

GPG KeyID  : 0xFCC2F7A7 (Patrick Dreker)
=46ingerprint: 7A21 FC7F 707A C498 F370  1008 7044 66DA FCC2 F7A7
Key available from keyservers

--Boundary-02=_ZKOmAvw7xW5rR75
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAmOKZcERm2vzC96cRArA+AKCTB25VrEHKitXdIrVYQgt2F83wwwCfTDNJ
1alWYcXxJBE6bwaUr3H/Css=
=lCL9
-----END PGP SIGNATURE-----

--Boundary-02=_ZKOmAvw7xW5rR75--
