Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266212AbUGJL0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266212AbUGJL0t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 07:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266213AbUGJL0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 07:26:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3480 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266212AbUGJL0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 07:26:47 -0400
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: ismail =?ISO-8859-1?Q?d=F6nmez?= <ismail.donmez@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, Redeeman <lkml@metanurb.dk>,
       LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <2a4f155d040710035512f21d34@mail.gmail.com>
References: <20040709182638.GA11310@elte.hu>
	 <1089407610.10745.5.camel@localhost> <20040710080234.GA25155@elte.hu>
	 <20040710085044.GA14262@elte.hu>
	 <2a4f155d040710035512f21d34@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WdlXj6KawUJKjLksNy2o"
Organization: Red Hat UK
Message-Id: <1089458801.2704.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 10 Jul 2004 13:26:41 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WdlXj6KawUJKjLksNy2o
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-07-10 at 12:55, ismail d=C3=B6nmez wrote:
> Tested on 2.6.7-bk20, Pentium3 700 mhz, 576 mb RAM
>=20
> I did cp -rf big_folder new_folder . Then opened up a gui ftp client
> and music in amarok started to skip like for 2-3 seconds.

that somewhat sounds more like a disk IO stall... which IO scheduler are
you using ?

(I can recommend using CFQ for this)


--=-WdlXj6KawUJKjLksNy2o
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA79JxxULwo51rQBIRAtJXAJ9bWIts7TjlP4og0OSQraK7sOpohgCfYzTi
FHtWVWsfr+waGsc2YTeCnuI=
=9m/A
-----END PGP SIGNATURE-----

--=-WdlXj6KawUJKjLksNy2o--

