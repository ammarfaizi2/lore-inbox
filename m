Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268106AbUHKQdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268106AbUHKQdj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 12:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268105AbUHKQdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 12:33:39 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:35988 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S268106AbUHKQbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 12:31:18 -0400
Message-Id: <200408102350.i7ANoCnQ021376@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: Alan Jenkins <sourcejedi@phonecoop.coop>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cd burning: kernel / userspace? 
In-Reply-To: Your message of "Tue, 10 Aug 2004 10:51:30 BST."
             <41189AA2.3010908@phonecoop.coop> 
From: Valdis.Kletnieks@vt.edu
References: <41189AA2.3010908@phonecoop.coop>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1867280476P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 10 Aug 2004 19:50:12 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1867280476P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <22412.1092181802.1@turing-police.cc.vt.edu>

On Tue, 10 Aug 2004 10:51:30 BST, Alan Jenkins said:

> Why can't a similar method be used for DAO writing?  Packet writing and 
> Mount Rainer support belongs in the kernel - why not normal cd burning?  
> On modern "burnproof" hardware, it should be possible to use dd to write 
> your disk image to the cdrecorder device.  I'm guessing that this just 
> isn't as interesting, especially with userspace programs available to do 
> the job.

Even less "interesting", but what *I*'d like to be able to do is:

# dump -0 -B 700000 -f /dev/hdb -u -z3 /home

and then just swap to the next CD/RW after -B blocks...

Dumping to a 700M temp file and then cdrecord'ing the temp file really gets old
after 15 or 20 CD's (and even playing double-buffering games using -F to switch
around isn't all it's cracked up to be..)

--==_Exmh_1867280476P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBGV80cC3lWbTT17ARAkaIAKC6NTGkyc8iRNSdxMwFnjG1Lp36nACePkRf
op7GMfpdyxZov2Qpsvpjh0E=
=bSyc
-----END PGP SIGNATURE-----

--==_Exmh_1867280476P--
