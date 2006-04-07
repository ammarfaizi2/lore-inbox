Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWDGFeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWDGFeM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 01:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWDGFeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 01:34:11 -0400
Received: from mail11.syd.optusnet.com.au ([211.29.132.192]:49796 "EHLO
	mail11.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932270AbWDGFeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 01:34:10 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>, ck list <ck@vds.kolivas.org>
Subject: [ANNOUNCE] Kernbench v0.41
Date: Fri, 7 Apr 2006 15:33:56 +1000
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7027232.uSc3ensRL8";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200604071533.58935.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart7027232.uSc3ensRL8
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Kernbench is a cpu throughput benchmark originally devised and used by Mart=
in=20
J.Bligh. It is designed to compare kernel changes on the same machine.

It runs a kernel compile at various numbers of concurrent jobs: 1/2 number =
of=20
cpus, optimal (default is 4xnumber of cpus) and maximal job count. Optional=
ly=20
it can also run single threaded. It then prints out a number of useful=20
statistics for the average of each group of runs and logs them to=20
kernbench.log

http://kernbench.kolivas.org

Direct download:
http://www.kernel.org/pub/linux/kernel/people/ck/apps/kernbench/kernbench-0=
=2E41.tar.bz2

Changes:
v0.41 Fixed make oldconfig

v0.40 Made all runs use the oldconfig if it exists. Changed to only do one
	warmup run before all the benchmarks. Added logging to kernbench.log
	Cleaned up the code substantially to reuse code where possible.
	Added standard deviation statistics courtesy of Peter Williams

=2Dck

--nextPart7027232.uSc3ensRL8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBENfnGZUg7+tp6mRURAr3gAJ4zG2Sy9OsDIiYBhrCVqkcf8eBFWgCaAhjW
zUZ2msW5Qlj/cns/xMd0oVE=
=jBPR
-----END PGP SIGNATURE-----

--nextPart7027232.uSc3ensRL8--
