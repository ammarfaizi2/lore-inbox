Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265788AbUAMWLQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 17:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265784AbUAMWLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 17:11:15 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:9345 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S265783AbUAMWLI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 17:11:08 -0500
Subject: Re: Proposed enhancements to MD
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Scott Long <scott_long@adaptec.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-raid <linux-raid@vger.kernel.org>,
       Neil Brown <neilb@cse.unsw.edu.au>
In-Reply-To: <20040113134107.A7646@lists.us.dell.com>
References: <40033D02.8000207@adaptec.com> <40043C75.6040100@pobox.com>
	 <20040113134107.A7646@lists.us.dell.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-CSPhqZAP0rRo10gdZEWm"
Organization: Red Hat, Inc.
Message-Id: <1074031848.4981.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 13 Jan 2004 23:10:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CSPhqZAP0rRo10gdZEWm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> Ideally in 2.6 one can use device mapper, but DM hasn't been
> incorporated into 2.4 stock, I know it's not in RHEL 3, and I don't
> believe it's included in SLES8.  Can anyone share thoughts on if a DDF
> solution were built on top of DM, that DM could be included in 2.4
> stock, RHEL3, or SLES8?  Otherwise, Adaptec will be stuck with two
> different solutions anyhow, one for 2.4 (they're proposing enhancing
> MD), and DM for 2.6.

Well it's either putting DM into 2.4 or forcing some sort of partitioned
MD into 2.4. My strong preference would be DM in that cases since it's
already in 2.6 and is actually designed for the
multiple-superblock-formats case.



--=-CSPhqZAP0rRo10gdZEWm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBABGzoxULwo51rQBIRAvB3AJ975gLeupCNmZHRCDZ41DylR+7cWgCgn5/9
5lsgj7bmuCMG+c5VuTD5aC8=
=Q7RG
-----END PGP SIGNATURE-----

--=-CSPhqZAP0rRo10gdZEWm--
