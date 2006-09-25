Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751787AbWIYBId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbWIYBId (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 21:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751789AbWIYBId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 21:08:33 -0400
Received: from pool-71-254-65-206.ronkva.east.verizon.net ([71.254.65.206]:3527
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751782AbWIYBIc (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 21:08:32 -0400
Message-Id: <200609250107.k8P17h8A019714@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Joerg Roedel <joro-lkml@zlug.org>
Cc: jamal <hadi@cyberus.ca>, Jan-Benedict Glaw <jbglaw@lug-owl.de>,
       Patrick McHardy <kaber@trash.net>, davem@davemloft.net,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 00/03][RESUBMIT] net: EtherIP tunnel driver
In-Reply-To: Your message of "Sat, 23 Sep 2006 15:27:36 +0200."
             <20060923132736.GA345@zlug.org>
From: Valdis.Kletnieks@vt.edu
References: <20060923120704.GA32284@zlug.org> <20060923121327.GH30245@lug-owl.de> <1159015118.5301.19.camel@jzny2>
            <20060923132736.GA345@zlug.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1159146463_16795P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 24 Sep 2006 21:07:43 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1159146463_16795P
Content-Type: text/plain; charset=us-ascii

On Sat, 23 Sep 2006 15:27:36 +0200, Joerg Roedel said:

> (I assume you are speaking of the position of the 3 in the header). The
> RFC is not clear at this point. It defines that the first 4 bits in the
> 16 bit Ethernet header MUST be 0011. But it don't defines the
> byteorder of that 16 bit word nor if the least or most significant bit
> comes first.

Unless stated otherwise, it's pretty safe to assume that all "on the wire" data
mentioned in an RFC is in 'network byte order'.  That's why hton*() and ntoh*()
functions exist...

Is there something in the RFC that suggests that a byte order other than
'network order' is possible/acceptable there?

--==_Exmh_1159146463_16795P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFFyvfcC3lWbTT17ARAsOTAKDec+tjKGbWpGug29jg4SmPmkT02QCgumNE
f5rOne55cvmC3bawERalwlc=
=K3FP
-----END PGP SIGNATURE-----

--==_Exmh_1159146463_16795P--
