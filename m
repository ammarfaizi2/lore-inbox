Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270240AbTGRNdF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 09:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266141AbTGRNc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 09:32:26 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:47343 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S265922AbTGRNcA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 09:32:00 -0400
Subject: Re: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b4).
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Linux-SCSI <linux-scsi@vger.kernel.org>
In-Reply-To: <20030718122304.A23013@infradead.org>
References: <B179AE41C1147041AA1121F44614F0B0598B10@AVEXCH02.qlogic.org>
	 <20030718122304.A23013@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-UosHasdCtsmxJdpSCcPC"
Organization: Red Hat, Inc.
Message-Id: <1058536002.5950.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 18 Jul 2003 15:46:42 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UosHasdCtsmxJdpSCcPC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-07-18 at 13:23, Christoph Hellwig wrote:
> =20
>  - qla2x00_intr_handler should use spin_lock, not spin_lock_irqsave

possibly correct; on x86 irq handlers run with interrupts enabled for
example; just too dangerous to do this esp if error recovery and similar
code calls this from process context as well (iirc a few places do)


--=-UosHasdCtsmxJdpSCcPC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/F/pCxULwo51rQBIRAmrfAKCKhmljEk+c46kWOiu/AhwLPVXxaACgk3uu
TgYvrp2zOo8ertEh0stE6m4=
=/kuj
-----END PGP SIGNATURE-----

--=-UosHasdCtsmxJdpSCcPC--
