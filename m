Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270727AbTHLQJl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 12:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270471AbTHLQJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 12:09:41 -0400
Received: from mail.suse.de ([213.95.15.193]:36104 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S270462AbTHLQJj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 12:09:39 -0400
To: Valdis.Kletnieks@vt.edu
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
       linux kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: generic strncpy - off-by-one error
References: <m21xvrynnk.wl%ysato@users.sourceforge.jp>
	<m2y8xzx74x.wl%ysato@users.sourceforge.jp>
	<200308121503.h7CF3JfZ009007@turing-police.cc.vt.edu>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I'm an East Side TYPE..
Date: Tue, 12 Aug 2003 18:09:27 +0200
In-Reply-To: <200308121503.h7CF3JfZ009007@turing-police.cc.vt.edu> (Valdis
 Kletnieks's message of "Tue, 12 Aug 2003 11:03:18 -0400")
Message-ID: <jewudix3go.fsf@sykes.suse.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Valdis.Kletnieks@vt.edu writes:

|> On Tue, 12 Aug 2003 23:50:06 +0900, Yoshinori Sato <ysato@users.sourcefo=
rge.jp>  said:
|>=20
|> > -	while (count) {
|> > +	while (count > 1) {
|>=20
|> Given that count is a size_t, which seems to be derived from 'unsigned i=
nt'  or
|> 'unsigned long' on every platform, how are these any different?

Let's suppose count =3D=3D 1.

Andreas.

=2D-=20
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 N=FCrnberg
Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/ORFBRNUhS4J2TtURApMyAJ0Ztlec1ahWQHzzasyEZ+dzGVDBagCgxTz/
lsfE7oym0DfoXjyvgNgv+RM=
=MKNC
-----END PGP SIGNATURE-----
--=-=-=--
