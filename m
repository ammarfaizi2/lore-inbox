Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266823AbTGTPL7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 11:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267205AbTGTPL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 11:11:59 -0400
Received: from h80ad279a.async.vt.edu ([128.173.39.154]:9344 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266823AbTGTPL6 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 11:11:58 -0400
Message-Id: <200307201526.h6KFQs9K003972@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Tried to run 2.6.0-test1 
In-Reply-To: Your message of "Mon, 21 Jul 2003 00:03:57 +0900."
             <081701c34ed0$5be60070$64ee4ca5@DIAMONDLX60> 
From: Valdis.Kletnieks@vt.edu
References: <081701c34ed0$5be60070$64ee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1323788506P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 20 Jul 2003 11:26:54 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1323788506P
Content-Type: text/plain; charset=us-ascii

On Mon, 21 Jul 2003 00:03:57 +0900, Norman Diamond <ndiamond@wta.att.ne.jp>  said:

> What does the thing need in order to use modules?

 ftp://ftp.kernel.org/pub/linux/kernel/people/people/rusty/modules/

And read http://www.codemonkey.org.uk/post-halloween-2.5.txt for
all the OTHER stuff you might need...

> come up?  By the way there are also no tones from PCMCIA during the
> boot process so I'm pretty sure it's also not recognizing my LAN card,

The 'no tones' confused me too.  In 'make menuconfig', go to 'Input Device support',
select 'Misc' - this will add an entry 'PC Speaker Support'.  Check that, it will add
CONFIG_INPUT_PCSPKR which should make the beeps return.

If you hit other snags, *read the post-halloween file*.  Most of the gotchas are
in there already.  If you do what that says, and it STILL doesn't work, feel free to
post again - the whole point of the -testX series is so we can find all the remaining
gotchas and either fix or workaround them.

--==_Exmh_-1323788506P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/GrS+cC3lWbTT17ARAt86AJ9hndDO5l43W6yLPPHrvXXHV9BO5QCgyLlB
mPDV5EA8d1hqu0hQ6Ti8vok=
=oKRi
-----END PGP SIGNATURE-----

--==_Exmh_-1323788506P--
