Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263859AbTFYEEe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 00:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263921AbTFYEEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 00:04:34 -0400
Received: from h80ad26cf.async.vt.edu ([128.173.38.207]:4992 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263859AbTFYEEc (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 00:04:32 -0400
Message-Id: <200306250418.h5P4IWdA001565@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: shemminger@osdl.org
Cc: "ismail (cartman) donmez" <kde@myrealbox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Weird modem behaviour in 2.5.73-mm1 
In-Reply-To: Your message of "Tue, 24 Jun 2003 23:27:57 EDT."
             <200306250327.h5P3RwH8001577@turing-police.cc.vt.edu> 
From: Valdis.Kletnieks@vt.edu
References: <200306242102.49356.kde@myrealbox.com>
            <200306250327.h5P3RwH8001577@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1101955502P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 25 Jun 2003 00:18:31 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1101955502P
Content-Type: text/plain; charset=us-ascii

On Tue, 24 Jun 2003 23:27:57 EDT, Valdis.Kletnieks@vt.edu said:

Reverting this one cset makes the modem work for me under 2.5.73-mm1.
With it in place, pppd hung up before even finishing the option
negotiations.  With it reverted, it's staying up.  There's apparently
something subtly wrong with the part that hits ppp_generic.c, although
I admit not understanding enough to see exactly what.

> #	           ChangeSet	1.1348.1.42 -> 1.1348.1.43
> #	 drivers/net/pppoe.c	1.31    -> 1.32   
> #	drivers/net/ppp_generic.c	1.33    -> 1.34   
> #
> # The following is the BitKeeper ChangeSet Log
> # --------------------------------------------
> # 03/06/23	shemminger@osdl.org	1.1348.1.43
> # [NET]: Convert PPPoE to new style protocol.
> # --------------------------------------------


--==_Exmh_-1101955502P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE++SKXcC3lWbTT17ARAuNxAKCCrSrekyiDD9G+g0+GSRubqvh7XwCgrZh/
6kL7ljbFDaQjdVR4AczRGEk=
=BLwG
-----END PGP SIGNATURE-----

--==_Exmh_-1101955502P--
