Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263264AbTFPCcr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 22:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbTFPCcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 22:32:47 -0400
Received: from netmagic.net ([206.14.125.10]:22507 "EHLO mail.netmagic.net")
	by vger.kernel.org with ESMTP id S263264AbTFPCco (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 22:32:44 -0400
Subject: Re: PROBLEM: 2.4.21 crashes hard running cdrecord in X.
From: Per Nystrom <centaur@netmagic.net>
Reply-To: pnystrom@netmagic.net
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1055728825.1482.8.camel@spike.sunnydale>
References: <1055722972.1502.39.camel@spike.sunnydale>
	 <200306161055.13996.kernel@kolivas.org>
	 <1055728825.1482.8.camel@spike.sunnydale>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-W4VJZBDo+PxW+OjoMt1L"
Organization: 
Message-Id: <1055731591.2028.4.camel@spike.sunnydale>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 15 Jun 2003 19:46:31 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-W4VJZBDo+PxW+OjoMt1L
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Alright, I've really gotten it narrowed down now.

The hard crash occurs only when magicdev is running.  I tried turning
off all my preferences for auto- mounting, running, and playing
data/audio cds in my preferences, and voila!  cdrecord works without a
hiccup in X too.

I will not revert to my nvidia driver for a few days anyway, in case I
can help debug this further -- just let me know what to do.  This looks
like a pretty serious problem, since the upshot is that userspace
programs are able to bring the kernel down.  I'd be happy to help if I
can.

Per


--=-W4VJZBDo+PxW+OjoMt1L
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA+7S+HuQMWIGtm8TQRApR+AJ9ADVBbWjV1SpxTpkLA7Mhdfe88VQCfR+/N
WcBVGcRDokWcPk3urHU7shM=
=4AfA
-----END PGP SIGNATURE-----

--=-W4VJZBDo+PxW+OjoMt1L--

