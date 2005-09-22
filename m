Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030440AbVIVQq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030440AbVIVQq5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 12:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030445AbVIVQq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 12:46:57 -0400
Received: from h80ad25aa.async.vt.edu ([128.173.37.170]:47590 "EHLO
	h80ad25aa.async.vt.edu") by vger.kernel.org with ESMTP
	id S1030440AbVIVQq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 12:46:56 -0400
Message-Id: <200509221646.j8MGkYo3017314@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: "Artem B. Bityutskiy" <dedekind@yandex.ru>
Cc: Pavel Machek <pavel@ucw.cz>, J Engel <joern@wohnheim.fh-wedel.de>,
       Peter Menzebach <pm-mtd@mw-itcon.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: data loss on jffs2 filesystem on dataflash 
In-Reply-To: Your message of "Thu, 22 Sep 2005 14:48:39 +0400."
             <43328C07.9070001@yandex.ru> 
From: Valdis.Kletnieks@vt.edu
References: <432817FF.10307@yandex.ru> <4329251C.7050102@mw-itcon.de> <4329288B.8050909@yandex.ru> <43292AC6.40809@mw-itcon.de> <43292E16.70401@yandex.ru> <43292F91.9010302@mw-itcon.de> <432FE1EF.9000807@yandex.ru> <432FEF55.5090700@mw-itcon.de> <433006D8.4010502@yandex.ru> <20050920133244.GC4634@wohnheim.fh-wedel.de> <20050921190759.GC467@openzaurus.ucw.cz>
            <43328C07.9070001@yandex.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1127407593_8815P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 22 Sep 2005 12:46:33 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1127407593_8815P
Content-Type: text/plain; charset=us-ascii

On Thu, 22 Sep 2005 14:48:39 +0400, "Artem B. Bityutskiy" said:

> Joern meant that if HDD starts a block write operation, it will 
> accomplish it even if power-fail happens (probably there are some 
> capacitors there). So, it is impossible, say, that HDD has written one 
> half of a sector and has not written the other half.

Hard drives contain capacitors to prevent writing of runt sectors on
a powerfail?  Didn't we go around this a while ago and decide it's mostly
urban legend, and that plenty of people have seen runt/bad sectors?

--==_Exmh_1127407593_8815P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDMt/pcC3lWbTT17ARAvWrAKD+ol8IKTtsWzg7oVXZraXsj1yxFACeNym8
XjbFyaWC2g76EDoe+PeoqJk=
=0Kbc
-----END PGP SIGNATURE-----

--==_Exmh_1127407593_8815P--
