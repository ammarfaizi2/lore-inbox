Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266500AbUHBMSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266500AbUHBMSv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 08:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266498AbUHBMSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 08:18:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1442 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262071AbUHBMRS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 08:17:18 -0400
Date: Mon, 2 Aug 2004 14:16:35 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: finding out the boot cpu number from userspace
Message-ID: <20040802121635.GE14477@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="N1GIdlSm9i+YlY4t"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--N1GIdlSm9i+YlY4t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

assuming cpu 0 is the boot cpu sounds fragile/incorrect, but for irqbalanced
I'd like to find out which cpu is the boot cpu, is there a good way of doing
so ?

The reason for needing this is that some firmware only likes running on the
boot cpu so I need to bind firmware-related irq's to that cpu ideally.

Greetings,
    Arjan van de Ven



--N1GIdlSm9i+YlY4t
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBDjCjxULwo51rQBIRAnXjAJ4vsQAOCBVnqN4B+vDk8YGYMrEHzACdEWBQ
/2xRuCo4pe9OWblvoRpZ3kw=
=lJ26
-----END PGP SIGNATURE-----

--N1GIdlSm9i+YlY4t--
