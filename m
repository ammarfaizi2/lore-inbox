Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbTK1DWg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 22:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbTK1DWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 22:22:36 -0500
Received: from h80ad24b3.async.vt.edu ([128.173.36.179]:6533 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261947AbTK1DWe (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 22:22:34 -0500
Message-Id: <200311280322.hAS3M602016305@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Tonnerre Anklin <thunder@keepsake.ch>
Cc: Kai Germaschewski <kai.germaschewski@gmx.de>,
       Werner Cornelius <werner@isdn4linux.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [I4L] hfcpci missing MODULE_LICENSE 
In-Reply-To: Your message of "Fri, 28 Nov 2003 03:00:03 +0100."
             <20031128020003.GG1635@dbintra.dmz.lightweight.ods.org> 
From: Valdis.Kletnieks@vt.edu
References: <20031128020003.GG1635@dbintra.dmz.lightweight.ods.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_273047486P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 27 Nov 2003 22:22:05 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_273047486P
Content-Type: text/plain; charset=us-ascii

On Fri, 28 Nov 2003 03:00:03 +0100, Tonnerre Anklin <thunder@keepsake.ch>  said:

> If this is compiled as a module and then loaded, the kernel is tainted
> because of a missing module license.

True.  However..

> Also,  according to  many european  laws, software  which  is released
> under no license must not be used.

No way to verify this.  I mostly understand the US copyright code as
it impacts my work, but have no idea what the other side of that puddle
does legally (and for that matter, I don't claim to know what the other
side of the other, even bigger, puddle is)...

> <URL:http://keepsake.keepsake.ch/~thunder/noyau/2.6.0-test11-ta1/hfcpci_license.xml>

which says: "I guess the license is meant to be GPL."  And so it was almost
certainly intended to be.

> +MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Kai Germaschewski <kai.germaschewski@gmx.de>/Werner Cornelius <werner@isdn4linux.de>");


Unfortunately, neither you nor I nor anybody but Kai or Werner (or their
assignees) can do this, as I understand the law.  The only proper resolutions
here are to get one of them to make some sort of statement (I suspect even a
"Yea, it's GPL, we just forgot the macro" e-mail from one of them would be good
enough), or to pull the code out of the 2.6.0 tree till it *is* resolved.

(Sorry to be a stickler, but this is the sort of thing that Darl and
company would love to make a point about - we *do* need to keep careful
track of the actual source and license status of every line....)

Kai? Werner? You out there?


--==_Exmh_273047486P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/xr9dcC3lWbTT17ARAp16AKCGGvouy/xVvvJAK3OOnHh7yq1LEACePFV/
/SWhElc+e+cnpYWpsxkhs9M=
=UuEB
-----END PGP SIGNATURE-----

--==_Exmh_273047486P--
