Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269324AbTGOSu6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 14:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269255AbTGOStw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 14:49:52 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:14208 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S269514AbTGOSs2 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 14:48:28 -0400
Message-Id: <200307151903.h6FJ3DBj002108@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: "B. D. Elliott" <bde@nwlink.com>, linux-kernel@vger.kernel.org
Subject: Re: "Where's the Beep?" (PCMCIA/vt_ioctl-s) 
In-Reply-To: Your message of "Tue, 15 Jul 2003 17:53:13 +1000."
             <16147.45801.812885.479853@gargle.gargle.HOWL> 
From: Valdis.Kletnieks@vt.edu
References: <20030715074826.EF8F46DC14@smtp3.pacifier.net>
            <16147.45801.812885.479853@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1227761111P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 15 Jul 2003 15:03:13 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1227761111P
Content-Type: text/plain; charset=us-ascii

On Tue, 15 Jul 2003 17:53:13 +1000, Neil Brown said:
> On Tuesday July 15, bde@nwlink.com wrote:
> > On my old DELL LM laptop the -2.5 series no longer issues any beeps when
> > a card is inserted.  The problem is in the kernel, as the test program
> > below (extracted from cardmgr) beeps on -2.4, but not on -2.5.
> 
> CONFIG_INPUT_PCSPKR
> 
> needs to be =y or =m and the module loaded.

Double ARGH.  Now I know *why* I didn't have it.

You also need CONFIG_INPUT_MISC in order to be able to *SEE* this option in menuconfig.

--==_Exmh_1227761111P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/FE/xcC3lWbTT17ARAj5sAKCh4bGqYmWHL25/qHnHYuBW1GsUjgCgwCeF
t7WiwCTHVvcyeLzk7ZOqANU=
=IGcn
-----END PGP SIGNATURE-----

--==_Exmh_1227761111P--
