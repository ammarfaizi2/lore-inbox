Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263819AbTKFSAu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 13:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263813AbTKFSAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 13:00:49 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:17028 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263812AbTKFSAn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 13:00:43 -0500
Subject: RE: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b6).
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Linux-SCSI <linux-scsi@vger.kernel.org>
In-Reply-To: <B179AE41C1147041AA1121F44614F0B0598CE6@AVEXCH02.qlogic.org>
References: <B179AE41C1147041AA1121F44614F0B0598CE6@AVEXCH02.qlogic.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-hTaqNPdIuC6MyHrxeaeO"
Organization: Red Hat, Inc.
Message-Id: <1068141595.5234.10.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 06 Nov 2003 18:59:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hTaqNPdIuC6MyHrxeaeO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-11-06 at 18:45, Andrew Vasquez wrote:

> No.  We've had this IOWR problem since the inception of 5.x series
> driver.  Software (SMS 3.0) has been built on top of the this IOCTL

how about removing most if not all of these ioctls ?
The scsi layer has a *generic* "send passthrough" mechanism already for
example.



--=-hTaqNPdIuC6MyHrxeaeO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/qowaxULwo51rQBIRAu6SAJ0eYuH+qU6ZO7NOuv3/6D6WLSPtbwCeNpa/
Uk2Bx05M7abbBYJcwwPceQ4=
=vBdR
-----END PGP SIGNATURE-----

--=-hTaqNPdIuC6MyHrxeaeO--
