Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263653AbTJaWpm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 17:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263669AbTJaWpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 17:45:42 -0500
Received: from h80ad273a.async.vt.edu ([128.173.39.58]:45478 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263653AbTJaWpk (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 17:45:40 -0500
Message-Id: <200310312245.h9VMjZr5029965@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Omen Wild <Omen.Wild@Dartmouth.EDU>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Remote memory access through FireWire? 
In-Reply-To: Your message of "Fri, 31 Oct 2003 17:36:28 EST."
             <20031031223628.GB11607@descolada.dartmouth.edu> 
From: Valdis.Kletnieks@vt.edu
References: <20031031223628.GB11607@descolada.dartmouth.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-528249359P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 31 Oct 2003 17:45:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-528249359P
Content-Type: text/plain; charset=us-ascii

On Fri, 31 Oct 2003 17:36:28 EST, Omen Wild <Omen.Wild@Dartmouth.EDU>  said:

> "As you know, IEEE1394 is a bus and OHCI supports physical access to
> the host memory. 

Supporting something as part of the hardware/protocol design is one thing.

Writing the device driver to support it is another (I'm sure that *before* you crash,
you have to set bits in the appropriate OHCI structures).

Actually allowing it to be enabled is a third thing.

Having said that, it *would* make for an interesting kgdb enhancement. :)

--==_Exmh_-528249359P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/ouYPcC3lWbTT17ARAkAZAKDk6Z6cI2MgRZ25eYIKWhxGI+UQQACg3hMm
pbNBj/4thmtyBN6tGFBpYhw=
=eie0
-----END PGP SIGNATURE-----

--==_Exmh_-528249359P--
