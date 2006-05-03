Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030224AbWECPy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbWECPy3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 11:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbWECPy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 11:54:29 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:49628 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1030224AbWECPy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 11:54:28 -0400
Message-Id: <200605031554.k43Fs3gg008022@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Michael Holzheu <HOLZHEU@de.ibm.com>
Cc: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>, akpm@osdl.org,
       Greg KH <greg@kroah.com>, ioe-lkml@rameria.de,
       linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>,
       mschwid2@de.ibm.com, Pekka J Enberg <penberg@cs.Helsinki.FI>
Subject: Re: [PATCH] s390: Hypervisor File System 
In-Reply-To: Your message of "Wed, 03 May 2006 15:18:41 +0200."
             <OFF044ED40.56CCD284-ON42257163.0048A5F3-42257163.00491F2C@de.ibm.com> 
From: Valdis.Kletnieks@vt.edu
References: <OFF044ED40.56CCD284-ON42257163.0048A5F3-42257163.00491F2C@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1146671642_2627P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 03 May 2006 11:54:03 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1146671642_2627P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, 03 May 2006 15:18:41 +0200, Michael Holzheu said:
> Of course=21 But the convention must be, that If userspace wants to
> access the data, it has to use our standard linux
> parser. If it accesses the data directly, this is broken.

Yet another case of Eternal Optimism flying in the face of Reality... ;)

a) you can't *force* the use of your parser.
b) this creates a userspace dependency that can get messy if the parser i=
s buggy
or requires modification to deal with a kernel change.


--==_Exmh_1146671642_2627P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEWNIacC3lWbTT17ARAtHQAKDy56ZK1dRyA+BKwCMpSreGuTNpxQCfQUq6
l1OOFJSLZDKb0dFayr/O5KI=
=G0rh
-----END PGP SIGNATURE-----

--==_Exmh_1146671642_2627P--
