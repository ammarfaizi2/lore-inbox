Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270445AbTHLPDm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 11:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270447AbTHLPDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 11:03:42 -0400
Received: from h80ad2614.async.vt.edu ([128.173.38.20]:63361 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S270445AbTHLPDl (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 11:03:41 -0400
Message-Id: <200308121503.h7CF3JfZ009007@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: generic strncpy - off-by-one error 
In-Reply-To: Your message of "Tue, 12 Aug 2003 23:50:06 +0900."
             <m2y8xzx74x.wl%ysato@users.sourceforge.jp> 
From: Valdis.Kletnieks@vt.edu
References: <m21xvrynnk.wl%ysato@users.sourceforge.jp>
            <m2y8xzx74x.wl%ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1588741396P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 12 Aug 2003 11:03:18 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1588741396P
Content-Type: text/plain; charset=us-ascii

On Tue, 12 Aug 2003 23:50:06 +0900, Yoshinori Sato <ysato@users.sourceforge.jp>  said:

> -	while (count) {
> +	while (count > 1) {

Given that count is a size_t, which seems to be derived from 'unsigned int'  or
'unsigned long' on every platform, how are these any different?


--==_Exmh_-1588741396P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/OQG2cC3lWbTT17ARAuUWAJ4/wUoQ7qKwZw/UqGGbsBEfLM3DTgCgp8AI
BP2ZxQtVa10xb67YPS8K2Iw=
=1pnm
-----END PGP SIGNATURE-----

--==_Exmh_-1588741396P--
