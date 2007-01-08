Return-Path: <linux-kernel-owner+w=401wt.eu-S1751473AbXAHH3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbXAHH3W (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 02:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbXAHH3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 02:29:22 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:41992 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751473AbXAHH3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 02:29:21 -0500
Date: Mon, 8 Jan 2007 18:29:33 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kyle McMartin <kyle@parisc-linux.org>,
       Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       parisc-linux@lists.parisc-linux.org
Subject: Re: [PATCH] Common compat_sys_sysinfo (v2)
Message-Id: <20070108182933.b8153945.sfr@canb.auug.org.au>
In-Reply-To: <200701080654.27100.arnd@arndb.de>
References: <20070107144850.GB3207@athena.road.mcmartin.ca>
	<20070107154045.GD3207@athena.road.mcmartin.ca>
	<20070108104347.83a004aa.sfr@canb.auug.org.au>
	<200701080654.27100.arnd@arndb.de>
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__8_Jan_2007_18_29_33_+1100_bWnQA1q=iCU4iHvx"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__8_Jan_2007_18_29_33_+1100_bWnQA1q=iCU4iHvx
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Jan 2007 06:54:26 +0100 Arnd Bergmann <arnd@arndb.de> wrote:
>
> > People have complined before that this adds a whole stack frame to the
> > "normal" syscall path. =A0Personally I don't care, but it has been
> > mentioned.
>
> It might be a concern for something like 'read' which is called frequently
> and in strange ways, but for 'sysinfo' this really should not matter.

Absolutely true.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__8_Jan_2007_18_29_33_+1100_bWnQA1q=iCU4iHvx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFofLdFdBgD/zoJvwRAq3sAJ95UYU7B9QntiOwuoCpeSqQyn4/KACgkx4h
bp1COzzonDn88eiRhxqHf8Y=
=4qXW
-----END PGP SIGNATURE-----

--Signature=_Mon__8_Jan_2007_18_29_33_+1100_bWnQA1q=iCU4iHvx--
