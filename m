Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264547AbTL0TvY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 14:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264549AbTL0TvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 14:51:24 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:22407 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S264547AbTL0TvW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 14:51:22 -0500
Subject: Re: Local APIC bug? (was: APM Suspend Problem)
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: schierlm@gmx.de
Cc: linux-kernel@vger.kernel.org, mochel@osdl.org
In-Reply-To: <S264397AbTL0TaT/20031227193019Z+16629@vger.kernel.org>
References: <16Jll-8mu-3@gated-at.bofh.it> <16Jlm-8mu-5@gated-at.bofh.it>
	 <16Jlm-8mu-7@gated-at.bofh.it> <16Jlm-8mu-9@gated-at.bofh.it>
	 <16Jll-8mu-1@gated-at.bofh.it>
	 <S264397AbTL0TaT/20031227193019Z+16629@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-O538Mq++Q9QktyPnbFHP"
Organization: Red Hat, Inc.
Message-Id: <1072554637.5222.12.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 27 Dec 2003 20:50:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-O538Mq++Q9QktyPnbFHP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> However, I'd appreciate if someone had any idea why the kernel crashes
> when trying to resume. Deadlocks...?

most bioses on laptops that I have seen don't actually restore the apic
state on resume (since they don't expect the apic to be used at all)
which results in entirely horked irq's on resume -> kernel crashes.

Over the last few years I've increasingly become convinced that (local)
apic use and laptops don't mix...



--=-O538Mq++Q9QktyPnbFHP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/7eKNxULwo51rQBIRArVhAJ9p2OfRqwmMnv2Ol7hSsKOO5DOA0wCfVbuh
6DpTwn60BEYeldVsoXJKHIM=
=/CpR
-----END PGP SIGNATURE-----

--=-O538Mq++Q9QktyPnbFHP--
