Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbTI3P3i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 11:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbTI3P3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 11:29:38 -0400
Received: from h80ad2612.async.vt.edu ([128.173.38.18]:44447 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261581AbTI3P3g (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 11:29:36 -0400
Message-Id: <200309301529.h8UFTNvl019529@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: -mregparm=3 (was Re: [PATCH] i386 do_machine_check() is redundant. 
In-Reply-To: Your message of "Tue, 30 Sep 2003 10:28:40 +0200."
             <3F793EB8.7010605@aitel.hist.no> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.44.0309291142430.3626-100000@home.osdl.org> <200309291954.h8TJsm6p002210@turing-police.cc.vt.edu>
            <3F793EB8.7010605@aitel.hist.no>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-11006188P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 30 Sep 2003 11:29:23 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-11006188P
Content-Type: text/plain; charset=us-ascii

On Tue, 30 Sep 2003 10:28:40 +0200, Helge Hafting said:

> Nvidia can fix this easily. Either by having several versions of
> their closed-source thing, or by having a open "interface" that
> uses nvidia's calling convention for talking to their proprietary
> binary code, and whatever the kernel uses for talking to the kernel.

Well, they do have an open interface.  I've apparently just not gotten all the
__attribute((regparm(0))) in the right places yet. ;)


--==_Exmh_-11006188P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/eaFTcC3lWbTT17ARAj4XAJ9W2Ce46Y7Xar90KgW1JC3CrfwgEwCfTa2p
NzPOy7wxEoJ0BlHSyjTc0Yk=
=66wg
-----END PGP SIGNATURE-----

--==_Exmh_-11006188P--
