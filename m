Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263733AbTIBOc2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 10:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbTIBOc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 10:32:28 -0400
Received: from h80ad25e7.async.vt.edu ([128.173.37.231]:14464 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263733AbTIBOcE (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 10:32:04 -0400
Message-Id: <200309021431.h82EViEl014303@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: azarah@gentoo.org
Cc: KML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test4-mm3 
In-Reply-To: Your message of "Tue, 02 Sep 2003 06:14:04 +0200."
             <1062476044.5275.13.camel@nosferatu.lan> 
From: Valdis.Kletnieks@vt.edu
References: <3F4F22D3.9080104@freemail.hu> <200308291300.h7TD049n022785@turing-police.cc.vt.edu> <1062168946.19599.114.camel@workshop.saharacpt.lan> <200308291553.h7TFrcGG009390@turing-police.cc.vt.edu> <1062447809.5275.7.camel@nosferatu.lan> <200309012352.h81NqXT9006422@turing-police.cc.vt.edu>
            <1062476044.5275.13.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1364590517P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 02 Sep 2003 10:31:43 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1364590517P
Content-Type: text/plain; charset=us-ascii

On Tue, 02 Sep 2003 06:14:04 +0200, Martin Schlemmer said:

> The problem I have with the patch you had here, is you changed:
> 
> DEPMOD         = /sbin/depmod
> 
> to:
> 
> DEPMOD         = /sbin/depmod.old
> 
> which is only the one from module-init-tools on a RH system ....

Damn.  Somebody hand me a brown paper bag. :)

(Make note to self - next time, diff the right 2 versions, not the testing version ;)

I got misdirected by your comment "this will only work with RH based systems",
because (a) neither the RH9 or Rawhide tools include a depmod.old, (b)
depmod.old gets created on non-Redhat systems if you install the Rusty version,
and (c) using depmod.old *wont* work - so I totally failed to notice I'd
botched the value of $DEPMOD. ;)


--==_Exmh_1364590517P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD4DBQE/VKnPcC3lWbTT17ARAroGAJd/qpqS/eZxbKstFYJeROah3l3bAKDtuGNR
6B8q0UW6ElLDgg7+0xH8vA==
=BxiJ
-----END PGP SIGNATURE-----

--==_Exmh_1364590517P--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--==_Exmh_1364590517P
Content-Type: text/plain; charset=us-ascii

On Tue, 02 Sep 2003 06:14:04 +0200, Martin Schlemmer said:

> The problem I have with the patch you had here, is you changed:
> 
> DEPMOD         = /sbin/depmod
> 
> to:
> 
> DEPMOD         = /sbin/depmod.old
> 
> which is only the one from module-init-tools on a RH system ....

Damn.  Somebody hand me a brown paper bag. :)

(Make note to self - next time, diff the right 2 versions, not the testing version ;)

I got misdirected by your comment "this will only work with RH based systems",
because (a) neither the RH9 or Rawhide tools include a depmod.old, (b)
depmod.old gets created on non-Redhat systems if you install the Rusty version,
and (c) using depmod.old *wont* work - so I totally failed to notice I'd
botched the value of $DEPMOD. ;)


--==_Exmh_1364590517P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD4DBQE/VKnPcC3lWbTT17ARAroGAJd/qpqS/eZxbKstFYJeROah3l3bAKDtuGNR
6B8q0UW6ElLDgg7+0xH8vA==
=BxiJ
-----END PGP SIGNATURE-----

--==_Exmh_1364590517P--
