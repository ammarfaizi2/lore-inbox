Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264809AbTE1RVU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 13:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264812AbTE1RVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 13:21:20 -0400
Received: from ik-dynamic-66-102-74-246.kingston.net ([66.102.74.246]:26120
	"EHLO linux.interlinx.bc.ca") by vger.kernel.org with ESMTP
	id S264809AbTE1RVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 13:21:19 -0400
Date: Wed, 28 May 2003 13:34:33 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: local apic timer ints not working with vmware: nolocalapic
Message-ID: <20030528173432.GA21379@linux.interlinx.bc.ca>
References: <2C8EEAE5E5C@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <2C8EEAE5E5C@vcnet.vc.cvut.cz>
User-Agent: Mutt/1.4.1i
Mail-Followup-To: brian@interlinx.bc.ca, linux-kernel@vger.kernel.org
From: brian@interlinx.bc.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2003 at 11:56:29AM +0200, Petr Vandrovec wrote:
>=20
> Just get VMware 3 or 4

Unfortunately, I cannot currently afford to buy (outright -- there is
no upgrade path from 2 to 4) a newer version of VMware.  Really, other
than this issue of the local APIC timer, I don't really need or care
to have a newer version of VMware anyway.

> - they (properly) emulate APIC timer and you'll
> get information that host bus is running at 66.xxxx MHz. With VMware 2
> you have to boot with noapic.

If only this worked.  I tried noapic, but it still tries to use the
local APIC timer interrupts.  noapic seems to only disable IO-APIC.
That is why I was "proposing" a new kernel command line arg,
"nolocalapic".

b.

--=20
Brian J. Murrell

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+1PMol3EQlGLyuXARAp/xAKD1KhSTEn2ECWIPfLrvXb0C9qmn8wCeJO/w
A6HnfdbpNKa+a4reRg/3FtA=
=sWL5
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
--mYCpIKhGyMATD0i+--
