Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135726AbRAYShv>; Thu, 25 Jan 2001 13:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135891AbRAYShm>; Thu, 25 Jan 2001 13:37:42 -0500
Received: from office.globe.cz ([212.27.204.26]:17417 "HELO gw.office.globe.cz")
	by vger.kernel.org with SMTP id <S135845AbRAYShZ>;
	Thu, 25 Jan 2001 13:37:25 -0500
Received: from ondrej.office.globe.cz (10.1.2.22)
  by vger.kernel.org with SMTP; 25 Jan 2001 18:37:22 -0000
To: Tim Fletcher <tim@parrswood.manchester.sch.uk>
Cc: Chris Mason <mason@suse.com>, <linux-kernel@vger.kernel.org>
Subject: ACPI error in 2.4.1-pre10 @ via82c686 (Was: 2.4.1-pre10 slowdown at boot.)
In-Reply-To: <Pine.LNX.4.30.0101251821260.5984-100000@pine.parrswood.manchester.sch.uk>
From: Ondrej Sury <ondrej@globe.cz>
Date: 25 Jan 2001 19:37:16 +0100
In-Reply-To: <Pine.LNX.4.30.0101251821260.5984-100000@pine.parrswood.manchester.sch.uk>
Message-ID: <874ryn5vhf.fsf@ondrej.office.globe.cz>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable

Tim Fletcher <tim@parrswood.manchester.sch.uk> writes:

> > > Are you using a VIA ide chipset? because a much slower version of the
> > > driver has been put in recently
> >
> > Yes, I am.  Is it THAT slow?  That could be it, I will try to be more
> > patient on next boot.
>=20
> I think that it is a temporey "safe but slow" driver until Vojtech Pavlik
> gets the driver to a state he and Andre Hendrick are happy with. iirc the
> driver has dma disabled for all VIA chipsets

I have discovered that it wasn't reiserfs problem.  I have disabled ACPI in
BIOS and everything is ok.  So I assume that something has changed in ACPI
between pre9 and pre10 versions and that something is broken in _my_
system.

=2D-=20
Ond=F8ej Sur=FD <ondrej@globe.cz>         Globe Internet s.r.o. http://glob=
e.cz/
Tel: +420235365000   Fax: +420235365009         Pl=E1ni=E8kova 1, 162 00 Pr=
aha 6
Mob: +420605204544   ICQ: 24944126             Mapa: http://globe.namape.cz/
GPG fingerprint:          CC91 8F02 8CDE 911A 933F  AE52 F4E6 6A7C C20D F273
--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP MESSAGE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.5 and Gnu Privacy Guard <http://www.gnupg.org/>

iEYEARECAAYFAjpwcmEACgkQ9OZqfMIN8nP7KgCfV/FFiws8Yr5uFJJlJzPxCm0c
KIAAnAmFfTe672JiL7zkk12Qq2GZEziw
=W6qU
-----END PGP MESSAGE-----
--=-=-=--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
