Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWDYSIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWDYSIx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 14:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWDYSIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 14:08:53 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:40135 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932161AbWDYSIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 14:08:52 -0400
Message-Id: <200604251808.k3PI8Y06004736@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Avi Kivity <avi@argo.co.il>
Cc: dtor_core@ameritech.net, Kyle Moffett <mrmacman_g4@mac.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules 
In-Reply-To: Your message of "Tue, 25 Apr 2006 20:53:01 +0300."
             <444E61FD.7070408@argo.co.il> 
From: Valdis.Kletnieks@vt.edu
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com> <1145911546.1635.54.camel@localhost.localdomain> <444D3D32.1010104@argo.co.il> <A6E165E4-8D43-4CF8-B48C-D4B0B28498FB@mac.com> <444DCAD2.4050906@argo.co.il> <9E05E1FA-BEC8-4FA8-811E-93CBAE4D47D5@mac.com> <444E524A.10906@argo.co.il> <d120d5000604251010kd56580fl37a0d244da1eaf45@mail.gmail.com> <444E5A3E.1020302@argo.co.il> <d120d5000604251028h67e552ccq7084986db6f1cdeb@mail.gmail.com>
            <444E61FD.7070408@argo.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1145988514_2618P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 25 Apr 2006 14:08:34 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1145988514_2618P
Content-Type: text/plain; charset=us-ascii

On Tue, 25 Apr 2006 20:53:01 +0300, Avi Kivity said:

> Additionally, C++ guarantees that if an exception is thrown after 
> spin_lock() is called, then the spin_unlock() will also be called. 
> That's an interesting mechanism by itself.

Gaak.  So let me get this straight - We lock something, then we hit
an exception because something corrupted the lock.  Then we *unlock* it
so more code can trip over it.

Sometimes the correct semantic is to *leave it locked*.

--==_Exmh_1145988514_2618P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFETmWhcC3lWbTT17ARAl87AKCIf/xrOHxHfx/CvvQQ2PMz/VTqtgCZAQYk
utqgWKkinOgFEd4AnLBe9dU=
=fnrf
-----END PGP SIGNATURE-----

--==_Exmh_1145988514_2618P--
