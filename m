Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262403AbUKVVFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbUKVVFs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 16:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbUKVVEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 16:04:06 -0500
Received: from admingilde.org ([213.95.21.5]:38354 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S262403AbUKVU5j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 15:57:39 -0500
Date: Mon, 22 Nov 2004 21:56:20 +0100
From: Martin Waitz <tali@admingilde.org>
To: janitor@sternwelten.at
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, nacc@us.ibm.com
Subject: Re: [patch 4/4]  char/snsc: reorder set_current_state() and 	add_wait_queue()
Message-ID: <20041122205620.GA5806@admingilde.org>
Mail-Followup-To: janitor@sternwelten.at, akpm@osdl.org,
	linux-kernel@vger.kernel.org, nacc@us.ibm.com
References: <E1CVLHE-0002XB-AH@sputnik>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <E1CVLHE-0002XB-AH@sputnik>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.6+20040907i
X-Hashcash: 0:041122:akpm@osdl.org:fbfef5e844bb0bbe
X-Hashcash: 0:041122:janitor@sternwelten.at:46615b0af6af5ee7
X-Hashcash: 0:041122:nacc@us.ibm.com:05e89e11c1afa5eb
X-Hashcash: 0:041122:linux-kernel@vger.kernel.org:188a09ace156365f
X-Spam-Score: -9.1 (---------)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sat, Nov 20, 2004 at 03:47:03AM +0100, janitor@sternwelten.at wrote:
> Description: Reorder add_wait_queue() and set_current_state() as a
> signal could be lost in between the two functions.

couldn't you loose a wake event that way?

Perhaps you want to use prepare_to_wait()?


--=20
Martin Waitz

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBolJ0j/Eaxd/oD7IRAu+bAJ0dntGK8ViYA6oEOjyblgBhOlLKnACcCPcx
zojRrwKMJnFsSDEz25GShDI=
=+avD
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--

