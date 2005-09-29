Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbVI2HAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbVI2HAR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 03:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbVI2HAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 03:00:17 -0400
Received: from smtp1.pp.htv.fi ([213.243.153.37]:45204 "EHLO smtp1.pp.htv.fi")
	by vger.kernel.org with ESMTP id S932101AbVI2HAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 03:00:16 -0400
Date: Thu, 29 Sep 2005 10:00:10 +0300
From: Paul Mundt <lethal@linux-sh.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 20/21] mm: sh64 hugetlbpage.c
Message-ID: <20050929070010.GB2960@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com> <Pine.LNX.4.61.0509251710200.3490@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0509251710200.3490@goblin.wat.veritas.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 25, 2005 at 05:11:58PM +0100, Hugh Dickins wrote:
> The sh64 hugetlbpage.c seems to be erroneous, left over from a bygone
> age, clashing with the common hugetlb.c.  Replace it by a copy of the
> sh hugetlbpage.c.  Except, delete that mk_pte_huge macro neither uses.
>=20
> Signed-off-by: Hugh Dickins <hugh@veritas.com>
> ---
>=20
>  arch/sh/mm/hugetlbpage.c   |    2=20
>  arch/sh64/mm/hugetlbpage.c |  188 ++------------------------------------=
-------
>  2 files changed, 12 insertions(+), 178 deletions(-)
>=20
Looks good, thanks Hugh.

Acked-by: Paul Mundt <lethal@linux-sh.org>

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFDO5D61K+teJFxZ9wRAje8AJ48q8dtdkup4BXeQ41hnabXPb8+DQCfXwyN
vNl9l3Ykrsb7zZ0VXT/e3oY=
=J4Q+
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
