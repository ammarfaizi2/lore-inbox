Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265141AbUFATDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265141AbUFATDV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 15:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265144AbUFATDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 15:03:20 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:20675 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265141AbUFATCw (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 15:02:52 -0400
Message-Id: <200406011902.i51J2mZ3016721@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: FabF <fabian.frederick@skynet.be>
Cc: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       linux-kernel@vger.kernel.org
Subject: Re: why swap at all? 
In-Reply-To: Your message of "Tue, 01 Jun 2004 20:36:23 +0200."
             <1086114982.2278.5.camel@localhost.localdomain> 
From: Valdis.Kletnieks@vt.edu
References: <E1BUwEH-00030X-00@calista.eckenfels.6bone.ka-ip.net>
            <1086114982.2278.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_482188856P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 01 Jun 2004 15:02:48 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_482188856P
Content-Type: text/plain; charset=us-ascii

On Tue, 01 Jun 2004 20:36:23 +0200, FabF said:

> I guess we have a design problem right here.We could add per-process
> swappiness attribute.That swap thread becomes boring coz we're looking
> globally what's going wrong locally.

Hmm.. do we need to worry about the same DoS issues we need to worry about with
mlock and friends?  I know I can trust myself to not do stupid things to said
flags on my laptop (well... not twice anyhow ;).  On the other hand, I have
systems with clueless users, and the even more dangerous half-clued users.  And
then I have a bunch of machines in our security lab, where Bad Things happen
all the time... 


--==_Exmh_482188856P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAvNLYcC3lWbTT17ARAlXfAKChoFPxbTQM/yluLmjQCh1yBrKByQCgv79q
H8l4ELjs3ncfKBfoUNmz+LU=
=yAow
-----END PGP SIGNATURE-----

--==_Exmh_482188856P--
