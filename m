Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263860AbUDNSaf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 14:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264255AbUDNSaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 14:30:35 -0400
Received: from ns.suse.de ([195.135.220.2]:10220 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263860AbUDNSa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 14:30:27 -0400
Date: Wed, 14 Apr 2004 20:30:21 +0200
From: Kurt Garloff <garloff@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Non-Exec stack patches
Message-ID: <20040414183021.GQ16701@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	linux-kernel@vger.kernel.org
References: <9AB83E4717F13F419BD880F5254709E5011EBABA@scsmsx402.sc.intel.com> <20040414094702.GC8888@mail.shareable.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0fZkDq/H4AmqaB8D"
Content-Disposition: inline
In-Reply-To: <20040414094702.GC8888@mail.shareable.org>
X-Operating-System: Linux 2.6.5-2-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0fZkDq/H4AmqaB8D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 14, 2004 at 10:47:02AM +0100, Jamie Lokier wrote:
> People looking at PROT_EXEC page table flags might want to be aware
> that <asm-um/pgtable.h> mimics the behaviour of i386: read implies and
> is implied by exec, write implies read.
>=20
> That might mean user-mode linux doesn't provide no-exec-stack
> protection even when the underlying kernel does offer it.  I'm not sure.

I thought UML only runs on i386.
And on i386, you have no NX feature.
You can run i386 UML on AMD64 (with 64bit kernel) though.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                            Cologne, DE=20
SUSE LINUX AG, Nuernberg, DE                          SUSE Labs (Head)

--0fZkDq/H4AmqaB8D
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAfYM9xmLh6hyYd04RAqq9AJ4lsOAGNBvrazp4fkmzY6nXdbr4hgCgq8JT
Md22uAt533v1v0B6Gnc5AEI=
=8xfi
-----END PGP SIGNATURE-----

--0fZkDq/H4AmqaB8D--
