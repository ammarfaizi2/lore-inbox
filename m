Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbUJYSCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbUJYSCf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 14:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbUJYSCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 14:02:15 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:23173 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261218AbUJYRyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 13:54:45 -0400
Message-Id: <200410251754.i9PHsVrI018284@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: Paulo Marques <pmarques@grupopie.com>
Cc: "Nico Augustijn." <kernel@janestarz.com>, hvr@gnu.org,
       clemens@endorphin.org, linux-kernel@vger.kernel.org
Subject: Re: Cryptoloop patch for builtin default passphrase 
In-Reply-To: Your message of "Mon, 25 Oct 2004 18:33:43 BST."
             <417D38F7.1040204@grupopie.com> 
From: Valdis.Kletnieks@vt.edu
References: <200410251354.31226.kernel@janestarz.com> <200410251719.i9PHJmOi009687@turing-police.cc.vt.edu>
            <417D38F7.1040204@grupopie.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-605258228P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 25 Oct 2004 13:54:31 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-605258228P
Content-Type: text/plain; charset=us-ascii

On Mon, 25 Oct 2004 18:33:43 BST, Paulo Marques said:

> I don't have any feelings about this patch, but it seems to me that you 
> could always store the contents of the nvram somewhere "safe" (you could 
> even write them down and take it to a safe deposit box in a bank :) ), 
> and, if those contents happen to change, you could always write them 
> again...

That's assuming that your machine will even *boot* correctly and cleanly if the
contents of the NVRAM are put back.

And if you're doing the "write it down and type it in again" thing, you might
as well just use a passphrase, as it's defeating the whole concept of
using /dev/nvram to xor against....

--==_Exmh_-605258228P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBfT3WcC3lWbTT17ARApk5AKCu+Zlgkw8vDcPjTiVa1NRm5vGMNQCfSRr3
q3sZPPawGavtJfbupMP2vPA=
=85yD
-----END PGP SIGNATURE-----

--==_Exmh_-605258228P--
