Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbVATTYC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbVATTYC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 14:24:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbVATTYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 14:24:01 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:35593 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261731AbVATTVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 14:21:35 -0500
Message-Id: <200501201921.j0KJLVsG005475@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Andreas Gruenbacher <agruen@suse.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Fix ea-in-inode default ACL creation 
In-Reply-To: Your message of "Thu, 20 Jan 2005 20:09:24 +0100."
             <1106248164.15959.69.camel@winden.suse.de> 
From: Valdis.Kletnieks@vt.edu
References: <1106245344.15959.13.camel@winden.suse.de> <200501201856.j0KIuiif016865@turing-police.cc.vt.edu>
            <1106248164.15959.69.camel@winden.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1106248889_12559P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 20 Jan 2005 14:21:30 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1106248889_12559P
Content-Type: text/plain; charset=us-ascii

On Thu, 20 Jan 2005 20:09:24 +0100, Andreas Gruenbacher said:
> On Thu, 2005-01-20 at 19:56, Valdis.Kletnieks@vt.edu wrote:
> > [...] I'm failing to see how adding *another* zero operation [...] is going to help the
> > fact [...]
> 
> It's an ancient kernel hackers trick:  ;)
> > +		EXT3_I(inode)->i_state &= ~EXT3_STATE_NEW;

Damn. I saw every *other* line of the patch but that one. Literally.

(Make note to self - if a cold is making your eyes water and itch too
much to wear your contacts, you probably can't see well enough to read code ;)

--==_Exmh_1106248889_12559P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFB8AS5cC3lWbTT17ARAulzAKDp6ASmYSD77j38+bfZlsb46EHQcQCgiRks
V3Kju2ynKRlh4jjt8D2WfTc=
=xsEj
-----END PGP SIGNATURE-----

--==_Exmh_1106248889_12559P--
