Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272119AbTGYOLs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 10:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272121AbTGYOLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 10:11:48 -0400
Received: from h80ad26ab.async.vt.edu ([128.173.38.171]:63105 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S272119AbTGYOLq (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 10:11:46 -0400
Message-Id: <200307251426.h6PEQs9g003992@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: koraq@xs4all.nl, linux-kernel@vger.kernel.org
Subject: Re: [2.4.22-pre7] speedtouch.o unresolved symbols 
In-Reply-To: Your message of "Fri, 25 Jul 2003 08:55:24 +0200."
             <200307250855.24218.baldrick@wanadoo.fr> 
From: Valdis.Kletnieks@vt.edu
References: <20030724202048.GA16411@spearhead>
            <200307250855.24218.baldrick@wanadoo.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1742705008P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 25 Jul 2003 10:26:54 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1742705008P
Content-Type: text/plain; charset=us-ascii

On Fri, 25 Jul 2003 08:55:24 +0200, Duncan Sands <baldrick@wanadoo.fr>  said:
> On Thursday 24 July 2003 22:20, koraq@xs4all.nl wrote:

> > /lib/modules/2.4.22-pre7/kernel/drivers/usb/speedtch.o depmod:        
> > shutdown_atm_dev_R0b9b1467
> > depmod:         atm_charge_Rf874f17b
> > depmod:         atm_dev_register_Rc23701a4
> > make: *** [_modinst_post] Error 1
> 
> You need to enable ATM support (CONFIG_ATM).  To do this, you
> need to enable support for experimental code (CONFIG_EXPERIMENTAL).

Also, the Speedtouch driver appears to be missing a #ifdef CONFIG_ATM or two?

--==_Exmh_1742705008P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/IT4ucC3lWbTT17ARAimyAKDlcmcvshSyd+4+OUiZvowIbzOyYQCeKWFQ
bF6EzVEvR3fz/bBX0iWfrgQ=
=Wq85
-----END PGP SIGNATURE-----

--==_Exmh_1742705008P--
