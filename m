Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbTHTFiZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 01:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbTHTFiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 01:38:25 -0400
Received: from h80ad24f8.async.vt.edu ([128.173.36.248]:20612 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261656AbTHTFiY (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 01:38:24 -0400
Message-Id: <200308200538.h7K5c4g8021142@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Pekka Savola <pekkas@netcore.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: host vs interface address ownership [Re: [2.4 PATCH] bugfix: ARP respond on all devices] 
In-Reply-To: Your message of "Wed, 20 Aug 2003 08:18:09 +0300."
             <Pine.LNX.4.44.0308200809280.32417-100000@netcore.fi> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.44.0308200809280.32417-100000@netcore.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-112107048P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 20 Aug 2003 01:38:04 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-112107048P
Content-Type: text/plain; charset=us-ascii

On Wed, 20 Aug 2003 08:18:09 +0300, Pekka Savola said:

> .. which *seems* (without knowing which RFCs and sections of them you 
> refer to for justifying host/interface ownership) to be a probable intent 
> of allowing either model.  Just as long as the external behaviour is 
> consistent, you can implement it with any internal structure you wish.

Hmm.. depends what you mean by "consistent"... "you can implement the
insides either way as long as the outsides look the same", or "you can do it
either way, as long as you do it the same way throughout the network".

The problem is that the *externally visible* behavior is different depending on
whether you choose host or interface ownership, and either model can probably
be made to work if *the rest of the network plays along*.


--==_Exmh_-112107048P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/Qwk8cC3lWbTT17ARAgcWAJ9py0wkA/QMerydhlT3u0SFPlt2XACdHHoX
2vjaSetO8pg+q8Ng18IhSCI=
=zZiB
-----END PGP SIGNATURE-----

--==_Exmh_-112107048P--
