Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbWEQMS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbWEQMS6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 08:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbWEQMS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 08:18:58 -0400
Received: from pool-71-254-71-216.ronkva.east.verizon.net ([71.254.71.216]:38083
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750896AbWEQMS6 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 08:18:58 -0400
Message-Id: <200605171218.k4HCIt4L013978@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: linux cbon <linuxcbon@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: replacing X Window System !
In-Reply-To: Your message of "Wed, 17 May 2006 13:47:22 +0200."
             <20060517114722.90648.qmail@web26603.mail.ukl.yahoo.com>
From: Valdis.Kletnieks@vt.edu
References: <20060517114722.90648.qmail@web26603.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1147868335_4166P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 17 May 2006 08:18:55 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1147868335_4166P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, 17 May 2006 13:47:22 +0200, linux cbon said:

> - should the next generation window versions Y,Z etc.
> remain backward compatible with X ?

If it isn't backward compatible, people won't use it.  X may suck,
but it doesn't suck hard enough that people will abandon all their
currently mostly-working software.

> I think they should start something better and simpler
> from scratch and not backward compatible.

Feel free to write it.  Keep in mind that X doesn't even try to do
widgets - those are done in userspace libraries.  Let us know when you
have enough functionality to make converting worth thinking about.

> - should the kernel remain pure =22shell=22 or include
> some basic universal graphical universal window system

> I think second answer.

Actually, you've proved the opposite.  Consider if the kernel had *alread=
y*
included some universal window system (we'll call it W). At that point, y=
ou
can't easily write an X, Y, or Z if you don't like W.  If anything, the
*current* W (which happens to be called X11) is *too* friendly with the k=
ernel
already - witness all the headaches dealing with DRM and 'enable' attribu=
tes
and other hoops things have to jump through.

If anything, there should be even *less* kernel support for graphics.
That way, writing a Y or Z (or improving X) is easier to do without
destabilizing the kernel.


--==_Exmh_1147868335_4166P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEaxSvcC3lWbTT17ARAi7cAJ94waHKcVFAF26f4JTSNXAseNXhlQCfTqYg
dE037dljN0aEF6wBg/izaHY=
=VLfA
-----END PGP SIGNATURE-----

--==_Exmh_1147868335_4166P--
