Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265984AbTIKEDY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 00:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265990AbTIKEDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 00:03:24 -0400
Received: from h80ad2681.async.vt.edu ([128.173.38.129]:11141 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265984AbTIKEDW (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 00:03:22 -0400
Message-Id: <200309110403.h8B43GSo003956@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata 
In-Reply-To: Your message of "Wed, 10 Sep 2003 20:43:34 PDT."
             <7F740D512C7C1046AB53446D3720017304AF3A@scsmsx402.sc.intel.com> 
From: Valdis.Kletnieks@vt.edu
References: <7F740D512C7C1046AB53446D3720017304AF3A@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-146537118P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 11 Sep 2003 00:03:16 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-146537118P
Content-Type: text/plain; charset=us-ascii

On Wed, 10 Sep 2003 20:43:34 PDT, "Nakajima, Jun" said:

> For maintenance and testing purposes, I think it's still better to make
> it conditional. If the errata are fixed, you might want to kill the
> condition depending on the stepping, for example. During the transition
> time, you need to support both the steppings until old ones go away
> (then remove the workaround).

We've still got conditionals for 486 chips.  How long a transition till the old
ones of *this* chipset go away?


--==_Exmh_-146537118P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/X/QDcC3lWbTT17ARAkZmAKCejWF1/xKtxSpHnrfFBO3PSyEohQCg3xTX
3jrTph6CE7E59Bee2bmfzNQ=
=pSCs
-----END PGP SIGNATURE-----

--==_Exmh_-146537118P--
