Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272871AbTHKRBg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 13:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272837AbTHKQ64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:58:56 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:17280 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S272871AbTHKQ4W (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 12:56:22 -0400
Message-Id: <200308111656.h7BGuI0r002197@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Gerd Knorr <kraxel@bytesex.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove version.h from bttv 
In-Reply-To: Your message of "Mon, 11 Aug 2003 18:30:54 +0200."
             <87isp45f7l.fsf@bytesex.org> 
From: Valdis.Kletnieks@vt.edu
References: <E19mCuP-0003dj-00@tetrachloride>
            <87isp45f7l.fsf@bytesex.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-669453556P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 11 Aug 2003 12:56:18 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-669453556P
Content-Type: text/plain; charset=us-ascii

On Mon, 11 Aug 2003 18:30:54 +0200, Gerd Knorr <kraxel@bytesex.org>  said:
> davej@redhat.com writes:
> 
> > -#include <linux/version.h>
> > +
> >  #define BTTV_VERSION_CODE KERNEL_VERSION(0,9,11)
>                              ^^^^^^^^^^^^^^
> 
> I'm pretty sure this will break the build ...

Not if all consumers of that .h file have already #included version.h (perhaps
indirectly).


--==_Exmh_-669453556P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/N8qxcC3lWbTT17ARAhbUAKDez3Tb9lFK5lKQPF/FMNtdctNpeACeO0H0
LgB2ZK5KUjQpCEJPNHscpb8=
=tey2
-----END PGP SIGNATURE-----

--==_Exmh_-669453556P--
