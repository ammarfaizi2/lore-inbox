Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263848AbTKXUAf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 15:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263866AbTKXUAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 15:00:35 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:56196 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263848AbTKXUAc (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 15:00:32 -0500
Message-Id: <200311242000.hAOK0RKL028022@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Mathieu Chouquet-Stringer <mathieu@newview.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hard links create local DoS vulnerability and security proble 
In-Reply-To: Your message of "Mon, 24 Nov 2003 14:25:31 EST."
             <xltptfhd0wk.fsf@shookay.newview.com> 
From: Valdis.Kletnieks@vt.edu
References: <200311241829.hAOITdKL014364@turing-police.cc.vt.edu>
            <xltptfhd0wk.fsf@shookay.newview.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1803202831P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 24 Nov 2003 15:00:27 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1803202831P
Content-Type: text/plain; charset=us-ascii

On Mon, 24 Nov 2003 14:25:31 EST, Mathieu Chouquet-Stringer said:

> It's always been my understanding that you cannot have suid shell script
> because you could easily change the IFS. Am i wrong? (

IFS is just one of the *many* issues (there's also a ton of race conditions
caused by #! handling, among other things).

You don't like the shell script, feel free to substitude in the C-language
equivalent that was posted previously :)

(And yes, I did it intentionally - figuring that at least one user on the
list would actually do it and leave a set-UID something lying around to
shoot themselves in the foot with, so weaponry loaded with blanks seemed a
good idea... ;)


--==_Exmh_1803202831P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/wmNbcC3lWbTT17ARAhfDAJ4wQbiTPmW0MTQ4BYgURVXKkVnmLgCg567a
0o7cojbZebtHAw1nPHzKqY4=
=RIT3
-----END PGP SIGNATURE-----

--==_Exmh_1803202831P--
