Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263229AbTJONpK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 09:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263184AbTJONpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 09:45:10 -0400
Received: from [64.238.111.222] ([64.238.111.222]:20865 "EHLO Borogove")
	by vger.kernel.org with ESMTP id S263229AbTJONpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 09:45:06 -0400
Subject: Re: Transparent compression in the FS
From: Josh Litherland <josh@temp123.org>
Reply-To: josh@temp123.org
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031015133305.GF24799@bitwizard.nl>
References: <1066163449.4286.4.camel@Borogove>
	 <20031015133305.GF24799@bitwizard.nl>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-CzovM2jVl5Z+IDJkk9eC"
Message-Id: <1066225505.1740.10.camel@Borogove>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 15 Oct 2003 09:45:06 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CzovM2jVl5Z+IDJkk9eC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-10-15 at 09:33, Erik Mouw wrote:

> Nowadays disks are so incredibly cheap, that transparent compression
> support is not realy worth it anymore (IMHO).

Well, just a for-instance... my application is for a data recovery
company.  We have 4 bulk servers with a total of around 2TB of storage,
so we're certainly availing ourselves of the low prices of IDE disks.=20
Most of this stuff is just archival; we keep it around as long as
possible in case our customers discover a month later that they're
missing a file or two.  We could probably increase our capacity by a
factor of 5 by compressing these volumes, and the performance penalties
wouldn't hurt us.  Honestly, if this is not a supportable thing, we will
probably just elect to incur the overhead of tar -j'ing things after the
customer signs off on the job.
=20
I'm leaning on The Management to find and pay someone to support this in
ext3, but I don't think that's in the near future, unfortunately.

--=20
Josh Litherland (josh@temp123.org)

--=-CzovM2jVl5Z+IDJkk9eC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/jU9hBrTD/Ik9kigRAqGfAJsFnch5t0BExyNziHeX6mSmxOJf+gCcDDCf
dogEeWRiCJqQK7d/kvj0QdI=
=3pJE
-----END PGP SIGNATURE-----

--=-CzovM2jVl5Z+IDJkk9eC--
