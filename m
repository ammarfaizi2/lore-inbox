Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267464AbUBSSXH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 13:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267350AbUBSSXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 13:23:07 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:13699 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S267464AbUBSSXD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 13:23:03 -0500
Subject: Re: [PATCH] ppc64: fix debugger() warnings
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, anton@samba.org
In-Reply-To: <200402190609.i1J69Hhl001602@hera.kernel.org>
References: <200402190609.i1J69Hhl001602@hera.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-aIbscuTe4kLYUgiiNUT9"
Organization: Red Hat, Inc.
Message-Id: <1077214972.9115.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 19 Feb 2004 19:22:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-aIbscuTe4kLYUgiiNUT9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-02-19 at 05:45, Linux Kernel Mailing List wrote:

> +static inline int debugger(struct *pt_regs regs) { return 0; }
> +static inline int debugger_bpt(struct *pt_regs regs) { return 0; }
> +static inline int debugger_sstep(struct *pt_regs regs) { return 0; }

I guess these work a LOT better if you type them as "struct pt_regs
*regs) instead of 'struct *pt_regs regs'

--=-aIbscuTe4kLYUgiiNUT9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBANP78xULwo51rQBIRAipDAKCAiqAiplESuH88g02aGoVp7l+VdACeJVn8
ErfWTe1xSsYwrbWCCx2Lv/g=
=1EO4
-----END PGP SIGNATURE-----

--=-aIbscuTe4kLYUgiiNUT9--
