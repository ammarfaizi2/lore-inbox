Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264412AbUGIGyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264412AbUGIGyU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 02:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264499AbUGIGyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 02:54:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46277 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264412AbUGIGyR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 02:54:17 -0400
Subject: Re: GCC 3.4 and broken inlining.
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Zan Lynx <zlynx@acm.org>
Cc: ncunningham@linuxmail.org,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Jakub Jelinek <jakub@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1089326491.22042.68.camel@localhost.localdomain>
References: <1089287198.3988.18.camel@nigel-laptop.wpcb.org.au>
	 <20040708120719.GS21264@devserv.devel.redhat.com>
	 <1089288664.2687.23.camel@nigel-laptop.wpcb.org.au>
	 <200407090036.39323.vda@port.imtp.ilyichevsk.odessa.ua>
	 <1089324043.3098.3.camel@nigel-laptop.wpcb.org.au>
	 <1089326491.22042.68.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-PCnlz7sofCjpDUkznOp2"
Organization: Red Hat UK
Message-Id: <1089356043.2805.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 09 Jul 2004 08:54:03 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PCnlz7sofCjpDUkznOp2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


>=20
> I believe that just adding -funit-at-a-time as a compile option solves
> the problems with inline function body ordering.

... except that -funit-at-a-time causes some functions to use more than
4Kb of *extra* stack, even without CONFIG_4KSTACKS that's a ticking
timebomb of enormous magnitude..

--=-PCnlz7sofCjpDUkznOp2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA7kELxULwo51rQBIRAlhtAJ4xCTjCxSdmshV6VqpXE2IiWi4RLwCfXtrv
vr/fgI4YQF18TGvrwsCRnoo=
=ulCO
-----END PGP SIGNATURE-----

--=-PCnlz7sofCjpDUkznOp2--

