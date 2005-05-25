Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261547AbVEYUNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbVEYUNd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 16:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbVEYUNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 16:13:33 -0400
Received: from 1-1-4-20a.ras.sth.bostream.se ([82.182.72.90]:45464 "EHLO
	garbo.kenjo.org") by vger.kernel.org with ESMTP id S261547AbVEYUN3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 16:13:29 -0400
Subject: Re: NFS corruption on 2.6.11.7
From: Kenneth Johansson <ken@kenjo.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1116936088.10707.39.camel@lade.trondhjem.org>
References: <1116888428.5206.14.camel@tiger>
	 <1116894917.11483.111.camel@lade.trondhjem.org>
	 <1116929711.6237.8.camel@tiger>
	 <1116936088.10707.39.camel@lade.trondhjem.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-zwaszzLro9Rkk4trfNfF"
Date: Wed, 25 May 2005 22:13:27 +0200
Message-Id: <1117052007.9884.10.camel@tiger>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zwaszzLro9Rkk4trfNfF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-05-24 at 08:01 -0400, Trond Myklebust wrote:

> Again, please could you give us more details on how you are doing these
> tests: what hardware (i.e. what NIC, switch, server, memory,...), lsmod
> output, (and ditto for the server).

After changing the mount option to use tcp instead of udp I have now
read several gigabytes without a single error.=20

Is there some fundamental difference in how nfs over upd and tcp is
handled regarding the packet contents like tcp using the tcp checksum
and udp not using the udp checksum or something like that?

Are there any counters for checksum errors in udp and tcp that can be
read ?? I faild to spot anything in /proc.

--=-zwaszzLro9Rkk4trfNfF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBClNxnmDGOmJIy9x8RAs4fAJ4+r7WkNZJeQYv2OUtYfokyD5YK7gCeJMN9
ldE7YhM0A32atEyjK1X2L7o=
=GXjC
-----END PGP SIGNATURE-----

--=-zwaszzLro9Rkk4trfNfF--

