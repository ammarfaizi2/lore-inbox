Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbWARD1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbWARD1A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 22:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbWARD1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 22:27:00 -0500
Received: from h80ad245a.async.vt.edu ([128.173.36.90]:30145 "EHLO
	h80ad245a.async.vt.edu") by vger.kernel.org with ESMTP
	id S932344AbWARD07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 22:26:59 -0500
Message-Id: <200601180325.k0I3P8tF008591@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Andi Kleen <ak@suse.de>, Arjan van de Ven <arjan@infradead.org>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Keith Owens <kaos@ocs.com.au>, Akinobu Mita <mita@miraclelinux.com>,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH 3/4] compact print_symbol() output 
In-Reply-To: Your message of "Tue, 17 Jan 2006 22:05:27 EST."
             <200601172208_MC3-1-B612-EE86@compuserve.com> 
From: Valdis.Kletnieks@vt.edu
References: <200601172208_MC3-1-B612-EE86@compuserve.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1137554707_3023P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 17 Jan 2006 22:25:07 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1137554707_3023P
Content-Type: text/plain; charset=us-ascii

On Tue, 17 Jan 2006 22:05:27 EST, Chuck Ebbert said:

> OK, how about this: remove the "0x" from the function size, i.e. print:
> 
>         kernel_symbol+0xd3/10e
> 
> instead of:
> 
>         kernel_symbol+0xd3/0x10e
> 
> This saves two characters per symbol and it should still be clear that
> the second number is hexadecimal.

Good.  Now repeat for a function that's 6 bytes shorter.

--==_Exmh_1137554707_3023P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDzbUTcC3lWbTT17ARAjz5AJ9htGvMzDaEvIZz9BkSfV8ABf8yJACeMZQ+
EWHoQfFXUDaFCcJUElz1HuM=
=A4w6
-----END PGP SIGNATURE-----

--==_Exmh_1137554707_3023P--
