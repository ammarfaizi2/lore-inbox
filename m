Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbVCRI1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVCRI1A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 03:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVCRI1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 03:27:00 -0500
Received: from ns.suse.de ([195.135.220.2]:47794 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261503AbVCRI0E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 03:26:04 -0500
Date: Fri, 18 Mar 2005 09:25:54 +0100
From: Kurt Garloff <garloff@suse.de>
To: Nick Piggin <npiggin@suse.de>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       Ian Pratt <Ian.Pratt@cl.cam.ac.uk>, Andi Kleen <ak@suse.de>
Subject: Re: 2.6.11 vs 2.6.10 slowdown on i686
Message-ID: <20050318082554.GA12536@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Nick Piggin <npiggin@suse.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Ian Pratt <Ian.Pratt@cl.cam.ac.uk>, Andi Kleen <ak@suse.de>
References: <E1DBtvc-0002c4-00@mta1.cl.cam.ac.uk> <42397A04.2060703@yahoo.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
In-Reply-To: <42397A04.2060703@yahoo.com.au>
X-Operating-System: Linux 2.6.11.1-4-default i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nick,

On Thu, Mar 17, 2005 at 11:37:24PM +1100, Nick Piggin wrote:
> Ian Pratt wrote:
> >fork: 166 -> 235  (40% slowdown)
> >exec: 857 -> 1003 (17% slowdown)
> >
> >I'm guessing this is down to the 4 level pagetables. This is rather a
> >surprise as I thought the compiler would optimise most of these
> >changes away. Apparently not.=20
>=20
> There are some changes in the current -bk tree (which are a
> bit in-flux at the moment) which introduce some optimisations.
>=20
> They should bring 2-level performance close to par with 2.6.10.
> If not, complain again :)

Is there a clean patchset that we should look at to test?

Regards,
--=20
Kurt Garloff, Director SUSE Labs, Novell Inc.

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCOpCSxmLh6hyYd04RAhDQAJ9+SxyXgatmZUr5aYSF668qHqweYACgkWDD
EYB8uUyQuHUV50nP3DpfMHA=
=Y4bt
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
