Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267944AbUHKFer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267944AbUHKFer (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 01:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267946AbUHKFer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 01:34:47 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:22664 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id S267944AbUHKFep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 01:34:45 -0400
Date: Tue, 10 Aug 2004 22:33:21 -0700
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: Possible dcache BUG
Message-ID: <20040810223321.62e530f7@laptop.delusion.de>
In-Reply-To: <Pine.LNX.4.58.0408102213250.1839@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
	<20040808113930.24ae0273.akpm@osdl.org>
	<200408100012.08945.gene.heskett@verizon.net>
	<200408102342.12792.gene.heskett@verizon.net>
	<Pine.LNX.4.58.0408102044220.1839@ppc970.osdl.org>
	<20040810211849.0d556af4@laptop.delusion.de>
	<Pine.LNX.4.58.0408102201510.1839@ppc970.osdl.org>
	<Pine.LNX.4.58.0408102213250.1839@ppc970.osdl.org>
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__10_Aug_2004_22_33_21_-0700_vp/LAuOJO06+Y_MI"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__10_Aug_2004_22_33_21_-0700_vp/LAuOJO06+Y_MI
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 10 Aug 2004 22:15:34 -0700 (PDT) Linus Torvalds (LT) wrote:

LT> Udo, that's a simple thing to check. If it's the slab balancing changes, 
LT> then you should be able to test it with just a
LT> 
LT> 	bk cset -x1.1830.4.3
LT> 
LT> if you have the current BK and are a BK user, or by just revertign the 
LT> patch here ("patch -R -p1" from inside your linux source tree) if you're 
LT> not a BK user..

Linus,

Thanks for the patch. I'll run it for a few days and see how things turn out.

-Udo.

--Signature=_Tue__10_Aug_2004_22_33_21_-0700_vp/LAuOJO06+Y_MI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBGa+inhRzXSM7nSkRAtZBAJ9PqJQYwe4X4JP3ODTUUzDXGGjZhwCeK23E
qNuF12VDSxzUfudDPKib6rc=
=f7Ax
-----END PGP SIGNATURE-----

--Signature=_Tue__10_Aug_2004_22_33_21_-0700_vp/LAuOJO06+Y_MI--
