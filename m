Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262726AbTCJFXf>; Mon, 10 Mar 2003 00:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262727AbTCJFXf>; Mon, 10 Mar 2003 00:23:35 -0500
Received: from h80ad264b.async.vt.edu ([128.173.38.75]:36481 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S262726AbTCJFXe>; Mon, 10 Mar 2003 00:23:34 -0500
Message-Id: <200303100533.h2A5XoWS003419@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.1 02/18/2003 with nmh-1.0.4+dev
To: Hanna Linder <hannal@us.ibm.com>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFT] port of Lockmeter on i386 2.5.64 Patch 
In-Reply-To: Your message of "Sun, 09 Mar 2003 18:48:30 PST."
             <149620000.1047264510@w-hlinder> 
From: Valdis.Kletnieks@vt.edu
References: <149620000.1047264510@w-hlinder>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_679639356P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 10 Mar 2003 00:33:49 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_679639356P
Content-Type: text/plain; charset=us-ascii

On Sun, 09 Mar 2003 18:48:30 PST, Hanna Linder said:

> +config LOCKMETER
> +	bool "Kernel lock metering"
> +	depends on SMP

Should that be 'depends on SMP || PREEMPT'?  I remember the original 2.4
pre-empt patches had one to deal with instrumenting/breaking locks. Not sure
if that logic still applies...

--==_Exmh_679639356P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+bCO8cC3lWbTT17ARAoF+AJ9Xru3Z69jp5l5EnW24uxMEVoPy5QCg9XcN
v0cPI66EeO5cnd6wI+5Kin0=
=uuNA
-----END PGP SIGNATURE-----

--==_Exmh_679639356P--
