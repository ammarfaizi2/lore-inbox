Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965096AbVLOA72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965096AbVLOA72 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 19:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965099AbVLOA72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 19:59:28 -0500
Received: from smtp04.auna.com ([62.81.186.14]:43733 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S965096AbVLOA72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 19:59:28 -0500
Date: Thu, 15 Dec 2005 02:01:38 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-mm@kvack.org, Andi Kleen <ak@suse.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Christoph Lameter <clameter@sgi.com>
Subject: Re: [RFC3 01/14] Add some consts for inlines in mm.h
Message-ID: <20051215020138.171e1cdd@werewolf.auna.net>
In-Reply-To: <20051215001420.31405.76332.sendpatchset@schroedinger.engr.sgi.com>
References: <20051215001415.31405.24898.sendpatchset@schroedinger.engr.sgi.com>
	<20051215001420.31405.76332.sendpatchset@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed-Claws 1.9.100cvs90 (GTK+ 2.8.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_yWhYnNVu.C8+2nxP2ljNeGa;
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.219.198] Login:jamagallon@able.es Fecha:Thu, 15 Dec 2005 01:59:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_yWhYnNVu.C8+2nxP2ljNeGa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Dec 2005 16:14:20 -0800 (PST), Christoph Lameter <clameter@sgi.c=
om> wrote:

> [PATCH] const attributes for some inlines in mm.h
>=20
> Const attributes allow the compiler to generate more efficient code by
> allowing callers to keep arguments of struct page in registers.
>=20

Even if it does not keep them in registers, at least it doesn't duplicate
them...

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.14-jam4 (gcc 4.0.2 (4.0.2-1mdk for Mandriva Linux release 2006.1))

--Sig_yWhYnNVu.C8+2nxP2ljNeGa
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDoMByRlIHNEGnKMMRAlY2AJ9BOfl8TiS1LFwZCEm7doFWDCl1aQCeJVNF
53yql0dHIeSTroVD3xCRU0E=
=re74
-----END PGP SIGNATURE-----

--Sig_yWhYnNVu.C8+2nxP2ljNeGa--
