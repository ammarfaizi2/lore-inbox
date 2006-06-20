Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbWFTFEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWFTFEW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 01:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWFTFEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 01:04:22 -0400
Received: from pool-72-66-192-191.ronkva.east.verizon.net ([72.66.192.191]:2246
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751112AbWFTFEV (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 01:04:21 -0400
Message-Id: <200606200504.k5K5408u008666@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Willy Tarreau <w@1wt.eu>
Cc: David Luyer <david@luyer.net>,
       Samuel Thibault <samuel.thibault@ens-lyon.org>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       linux-kernel@vger.kernel.org
Subject: Re: emergency or init=/bin/sh mode and terminal signals
In-Reply-To: Your message of "Tue, 20 Jun 2006 06:28:02 +0200."
             <20060620042802.GI13255@w.ods.org>
From: Valdis.Kletnieks@vt.edu
References: <20060619220920.GB5788@implementation.residence.ens-lyon.fr> <C0BD782F.CF80%david@luyer.net>
            <20060620042802.GI13255@w.ods.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1150779839_5895P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Jun 2006 01:03:59 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1150779839_5895P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Jun 2006 06:28:02 +0200, Willy Tarreau said:
> Then, I think that a solution which would fit everyone's needs would be=

> to add a command line parameter (eg: =22setsid=3D1=22) which will allow=

> the two lines to be executed whatever the init or shell. This way,
> you want a session ? -> =22init=3D/bin/sh setsid=3D1=22.

Get 2 for the price of one:

init=3D/bin/something_that_does_setsid_in_userspace_and_doesnt_clutter_ke=
rnel

Or once you get a =23 prompt from /bin/sh, 'exec /bin/something_saner'.

Remember - if it's trivially done in userspace, it probably shouldn't
be cluttering the kernel.

--==_Exmh_1150779839_5895P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEl4G/cC3lWbTT17ARAgZNAJ9+7ttTvg2gLVUIG97qAvw10KdbrgCg39zv
MHmJbFVfeHeUG1Vvjj20/hE=
=u38E
-----END PGP SIGNATURE-----

--==_Exmh_1150779839_5895P--
