Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964988AbWH2OP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbWH2OP2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 10:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbWH2OP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 10:15:28 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:40115 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S964984AbWH2OP1 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 10:15:27 -0400
Message-Id: <200608291414.k7TEETg8003595@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Lee Trager <Lee@PicturesInMotion.net>
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Machek <pavel@ucw.cz>,
       B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, seife@suse.de
Subject: Re: HPA Resume patch
In-Reply-To: Your message of "Mon, 28 Aug 2006 22:14:34 EDT."
             <44F3A30A.3090509@PicturesInMotion.net>
From: Valdis.Kletnieks@vt.edu
References: <44F15ADB.5040609@PicturesInMotion.net> <20060827150608.GA4534@ucw.cz> <20060827170501.GD30609@kernel.dk>
            <44F3A30A.3090509@PicturesInMotion.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1156860868_3126P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 29 Aug 2006 10:14:29 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1156860868_3126P
Content-Type: text/plain; charset=us-ascii

On Mon, 28 Aug 2006 22:14:34 EDT, Lee Trager said:

> Thinkpad users. Anyway my only question is how to I get my patched
> signed off by someone?

You read Documentation/SubmittingPatches, and follow the directions there,
and remember to merge in any comments people might have...

> +	err = ide_do_drive_cmd(drive, &rq, ide_head_wait);
> +
> +	if (err == 0 && drv->resume)

Often better written as:

	if (!err && drv->resume)

--==_Exmh_1156860868_3126P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFE9EvEcC3lWbTT17ARAhsmAJ9HOcLzLEnR3g7RSUG+RprFTGS8nwCeMVKR
EvI5vJ8N/7zUzxIMwehfvFk=
=fAM3
-----END PGP SIGNATURE-----

--==_Exmh_1156860868_3126P--
