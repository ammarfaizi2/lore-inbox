Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263763AbTFDSNR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 14:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbTFDSNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 14:13:17 -0400
Received: from smtp-out.comcast.net ([24.153.64.113]:49654 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S263763AbTFDSNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 14:13:15 -0400
Date: Wed, 04 Jun 2003 14:25:33 -0400
From: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Subject: Re: orinoco_cs module removal problem
In-reply-to: <20030604175121.GA1709@apathy.black-flower>
To: Maciej <maciej@apathy.killer-robot.net>
Cc: linux-kernel@vger.kernel.org
Message-id: <20030604182533.GA18983@butterfly.hjsoft.com>
MIME-version: 1.0
Content-type: multipart/signed; boundary="k+w/mQv8wyuph6w0";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
User-Agent: Mutt/1.5.4i
References: <20030604175121.GA1709@apathy.black-flower>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 04, 2003 at 12:51:21PM -0500, Maciej wrote:
> I just switched from 2.5.68 to 2.5.70, and I'm having trouble removing
> the orinoco_cs module on the fly. After bringing the interface down,
> doing an "rmmod orinoco_cs" causes the rmmod process to lock up, and
> subseqeunt invocations of lsmod and 'cat /proc/modules' to do the=20
same.
> I get a bunch of messages like the following in the kernel log:
> "unregister_netdevice: waiting for eth2 to become free. Usage count =3D=
=20
1
> However, eth2, the orinoco device, no longer exists (it's not listed
> in /proc/net/dev).

i've seen this also with my orinoco_cs and my 3c574_cs.
--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+3jmdCGPRljI8080RAmkLAJsEMN1MLlGgxltwsFumWX5S0zXWwgCeJYYN
10PtCLw6J0u2ssQuGLpzDuc=
=/xvf
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
