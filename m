Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbVCORdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbVCORdH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 12:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261543AbVCORbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 12:31:22 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:32275 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261610AbVCORab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 12:30:31 -0500
Message-Id: <200503151730.j2FHUT3k018541@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Giuseppe Bilotta <bilotta78@hotpop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] I8K driver facelift 
In-Reply-To: Your message of "Tue, 15 Mar 2005 11:59:22 +0100."
             <MPG.1ca0de763cbc3456989715@news.gmane.org> 
From: Valdis.Kletnieks@vt.edu
References: <200502240110.16521.dtor_core@ameritech.net> <4233B65A.4030302@tuxrocks.com> <200503150812.j2F8CABo004744@turing-police.cc.vt.edu>
            <MPG.1ca0de763cbc3456989715@news.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1110907828_4720P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 15 Mar 2005 12:30:29 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1110907828_4720P
Content-Type: text/plain; charset=us-ascii

On Tue, 15 Mar 2005 11:59:22 +0100, Giuseppe Bilotta said:
> > According to your patch, the C840 has 2 temp sensors. I'll have to figure
> > out what the second one is (prob either the GPU or the disk drive?)
> 
> If it runs over 40 C easily it's probably the GPU :)

Well, (a) the next rev of the patch will hopefully provide more access to the
second thermal probe than just detecting its existence (it still doesn't do
the sysfs or whatever magic to make the actual value accessible), and (b) the
probe I *know* about is on the CPU, and runs over 40C easily as well (it's sitting
at 49C right now).  Remember we're talking about a laptop here, there's not
a lot of room for a big heat sink in there.. ;)

--==_Exmh_1110907828_4720P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCNxu0cC3lWbTT17ARAgj4AJ9QWk3vICNtWpGDK+mnZ1QispQzswCfWTQA
zR32c6Z8TAZr3E05Kpd+VO4=
=6zp1
-----END PGP SIGNATURE-----

--==_Exmh_1110907828_4720P--
