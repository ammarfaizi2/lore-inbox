Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbTJKOn5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 10:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263313AbTJKOn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 10:43:57 -0400
Received: from h80ad24a2.async.vt.edu ([128.173.36.162]:63880 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263309AbTJKOn4 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 10:43:56 -0400
Message-Id: <200310111443.h9BEhr6s022474@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test7 + X11 + screen savers vs. user 
In-Reply-To: Your message of "Sat, 11 Oct 2003 18:00:45 +0900."
             <228201c38fd6$32b82c90$5cee4ca5@DIAMONDLX60> 
From: Valdis.Kletnieks@vt.edu
References: <228201c38fd6$32b82c90$5cee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-412297664P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 11 Oct 2003 10:43:52 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-412297664P
Content-Type: text/plain; charset=us-ascii

On Sat, 11 Oct 2003 18:00:45 +0900, Norman Diamond <ndiamond@wta.att.ne.jp>  said:
> In 2.6.0-test1 through test7, when running X11, the screen saver kicks in
> about every 5 minutes.  I haven't checked the configuration but have
> confidence that it's obeying the timing correctly.  The problem is that it
> doesn't care whether the keyboard and mouse have been used during that time.

Which screen saver is this?

jwz's xscreensaver 4.13 mostly works for me with XFree86 4.3.0, and notices
keyboard activity and mouse cursor movement, but fails to detect mouse button
events - so if you're in a mail program and reading a lot of mail and hitting 'delete'
over and over, the screensaver can kick in anyhow.

I have to admit I've not tracked down if this is xscreensaver's fault, or the
X server's fault, or the kernel's fault.

--==_Exmh_-412297664P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/iBcocC3lWbTT17ARAmPPAJ4hFT0E8gi33mGNXa6Rvqbp0ayzqwCfQ4Ci
OhtRJGI+iWeMfy9QA3qzymA=
=IjpI
-----END PGP SIGNATURE-----

--==_Exmh_-412297664P--
