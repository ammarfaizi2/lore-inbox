Return-Path: <linux-kernel-owner+w=401wt.eu-S1030271AbXAECDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030271AbXAECDF (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 21:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030260AbXAECDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 21:03:05 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:41896 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030274AbXAECDD (ORCPT
	<RFC822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 21:03:03 -0500
Message-Id: <200701050202.l0522sS2004940@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Frederik Deweerdt <deweerdt@free.fr>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm 8/8] user ns: implement user ns unshare
In-Reply-To: Your message of "Thu, 04 Jan 2007 16:52:53 CST."
             <20070104225253.GA3087@sergelap.austin.ibm.com>
From: Valdis.Kletnieks@vt.edu
References: <20070104180635.GA11377@sergelap.austin.ibm.com> <20070104181310.GI11377@sergelap.austin.ibm.com> <20070104190700.GB17863@slug> <200701042223.l04MNZB2002002@turing-police.cc.vt.edu>
            <20070104225253.GA3087@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1167962574_3266P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 04 Jan 2007 21:02:54 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1167962574_3266P
Content-Type: text/plain; charset=us-ascii

On Thu, 04 Jan 2007 16:52:53 CST, "Serge E. Hallyn" said:
> Quoting Valdis.Kletnieks@vt.edu (Valdis.Kletnieks@vt.edu):
> > On Thu, 04 Jan 2007 19:07:00 GMT, Frederik Deweerdt said:
> > > >  	int err = 0;
> > >         ^^^^^^^^^^^^
> > > The "= 0" is superfluous here.
> > 
> > Umm?  bss gets cleared automagically, but when did we start auto-zeroing
> > the stack?
> 
> No, no, that's what i thought he meant at first too, but I actually
> manually set err on all paths anyway  :)

Oh.  So it's *really* just "superfluous until somebody changes the code"...



--==_Exmh_1167962574_3266P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFnbHOcC3lWbTT17ARAuN6AKCupR4WkNe9tceLm7MkIIF3S/JRTgCeL4bB
0MqNHEQNfMOpBeZX6D+Ukr4=
=MHy5
-----END PGP SIGNATURE-----

--==_Exmh_1167962574_3266P--
