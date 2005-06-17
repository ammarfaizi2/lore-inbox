Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbVFQN4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbVFQN4M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 09:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbVFQN4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 09:56:12 -0400
Received: from h80ad262c.async.vt.edu ([128.173.38.44]:7439 "EHLO
	h80ad262c.async.vt.edu") by vger.kernel.org with ESMTP
	id S261976AbVFQN4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 09:56:07 -0400
Message-Id: <200506171355.j5HDtogk006607@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: abonilla@linuxwireless.org
Cc: "'Lars Roland'" <lroland@gmail.com>, "'Christian Kujau'" <evil@g-house.de>,
       "'Linux-Kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: tg3 in 2.6.12-rc6 and Cisco PIX SMTP fixup 
In-Reply-To: Your message of "Fri, 17 Jun 2005 07:33:05 MDT."
             <001f01c57341$1802c3b0$600cc60a@amer.sykes.com> 
From: Valdis.Kletnieks@vt.edu
References: <001f01c57341$1802c3b0$600cc60a@amer.sykes.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1119016549_11929P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 17 Jun 2005 09:55:49 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1119016549_11929P
Content-Type: text/plain; charset=us-ascii

On Fri, 17 Jun 2005 07:33:05 MDT, Alejandro Bonilla said:

> 	So what do we really have here? Problem with Cisco or a problem in the
> driver? Both?

Oh - the TCP scaling bits are sent in a TCP Option header - which is what the PIX
is gratuitously throwing out (presumably because they're "optional", given the
sorts of dain bramage we've seen from PIX boxen before.  For the longest time,
their 'SMTP Fixup' was anything but....)

--==_Exmh_1119016549_11929P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCstZlcC3lWbTT17ARArUDAKC77kVn7xxmLnU/SC2iW1J3tlv4/ACgkJ6p
hiDd5QuQBKqzu+u4Y20phDQ=
=20dD
-----END PGP SIGNATURE-----

--==_Exmh_1119016549_11929P--
