Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265221AbUFAVMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265221AbUFAVMc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 17:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265223AbUFAVMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 17:12:32 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:5584 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265221AbUFAVMb (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 17:12:31 -0400
Message-Id: <200406012112.i51LC8SH001577@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: jsimmons@pentafluge.infradead.org
Cc: Sau Dan Lee <danlee@informatik.uni-freiburg.de>,
       Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: keyboard problem with 2.6.6 
In-Reply-To: Your message of "Tue, 01 Jun 2004 22:01:10 BST."
             <Pine.LNX.4.56.0406012158530.23458@pentafluge.infradead.org> 
From: Valdis.Kletnieks@vt.edu
References: <xb7r7t2b3mb.fsf@savona.informatik.uni-freiburg.de> <20040530111847.GA1377@ucw.cz> <xb71xl2b0to.fsf@savona.informatik.uni-freiburg.de> <20040530124353.GB1496@ucw.cz> <xb7aczq9he1.fsf@savona.informatik.uni-freiburg.de>
            <Pine.LNX.4.56.0406012158530.23458@pentafluge.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_804014301P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 01 Jun 2004 17:12:08 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_804014301P
Content-Type: text/plain; charset=us-ascii

On Tue, 01 Jun 2004 22:01:10 BST, jsimmons@pentafluge.infradead.org said:

> Why not use UML (user mode linux). Jon Smirl was using it to work on fbdev 
> drivers in userland. Interrupts where tricky to handle but it might 
> work fine now. I have to give it a try again. Once it is setup you can 
> develope kernel driver in userland.

UML helps the "boot/crash/reboot" cycle (and that sort of debugging was in
fact one of the early design goals of IBM's CP/67 and VM/370 systems). but
it doesn't help the fact that the infrastructure provided to kernel functions
is vastly different than the glibc-based infrastructure available in userspace....


--==_Exmh_804014301P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAvPEncC3lWbTT17ARAij3AKCJ0R1VLtse4QxbYiFs9hiFdj4rDgCeKydR
/1dtzRScB9uADGphHkfPhQ0=
=4j4X
-----END PGP SIGNATURE-----

--==_Exmh_804014301P--
