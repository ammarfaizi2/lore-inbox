Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270471AbTHLQT6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 12:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270479AbTHLQT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 12:19:58 -0400
Received: from h80ad2614.async.vt.edu ([128.173.38.20]:43139 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S270471AbTHLQT5 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 12:19:57 -0400
Message-Id: <200308121619.h7CGJpfZ010471@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: William Gallafent <william.gallafent@virgin.net>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
       linux kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: generic strncpy - off-by-one error 
In-Reply-To: Your message of "Tue, 12 Aug 2003 16:54:05 BST."
             <Pine.LNX.4.53.0308121652020.13364@officebedroom.oldvicarage> 
From: Valdis.Kletnieks@vt.edu
References: <m21xvrynnk.wl%ysato@users.sourceforge.jp> <m2y8xzx74x.wl%ysato@users.sourceforge.jp> <200308121503.h7CF3JfZ009007@turing-police.cc.vt.edu>
            <Pine.LNX.4.53.0308121652020.13364@officebedroom.oldvicarage>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1544888756P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 12 Aug 2003 12:19:50 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1544888756P
Content-Type: text/plain; charset=us-ascii

On Tue, 12 Aug 2003 16:54:05 BST, William Gallafent said:

> Er, consider the case of count == 1. Fenceposts can be dangerous things.

Amen, given the original code and the first attempt to fix it.  I was actually
trolling for "accidentally correct" versus "intentionally correct".

/Valdis (who has posted "convince me the code is right THIS time"  waay too
many times on waaay too many lists already today - including one count-the-on-bits
scheme that only worked for an all-zeros input.. ;)

--==_Exmh_-1544888756P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/OROmcC3lWbTT17ARAn9BAJ0ZWyZEpvQ0VdYXxLRKMqmLc9FbpwCgq1O9
udZSR4PoA+fiuu+hNeKU3gk=
=PbnR
-----END PGP SIGNATURE-----

--==_Exmh_-1544888756P--
