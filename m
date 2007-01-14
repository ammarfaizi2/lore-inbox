Return-Path: <linux-kernel-owner+w=401wt.eu-S1751039AbXANCV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbXANCV1 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 21:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbXANCV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 21:21:27 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:36431 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbXANCV0 (ORCPT
	<RFC822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 21:21:26 -0500
Message-Id: <200701140221.l0E2LOYS010969@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Cc: Sunil Naidu <akula2.shark@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Choosing a HyperThreading/SMP/MultiCore kernel ?
In-Reply-To: Your message of "Sat, 13 Jan 2007 12:54:43 EST."
             <20070113175443.GX17267@csclub.uwaterloo.ca>
From: Valdis.Kletnieks@vt.edu
References: <8355959a0701120525m5d1a7904i56b8a8f7316883d6@mail.gmail.com> <20070112150349.GI17269@csclub.uwaterloo.ca> <200701130338.l0D3chOs026407@turing-police.cc.vt.edu>
            <20070113175443.GX17267@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1168741284_8374P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 13 Jan 2007 21:21:24 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1168741284_8374P
Content-Type: text/plain; charset=us-ascii

On Sat, 13 Jan 2007 12:54:43 EST, Lennart Sorensen said:
> On Fri, Jan 12, 2007 at 10:38:43PM -0500, Valdis.Kletnieks@vt.edu wrote:
> > CONFIG_MCORE2=y
> 
> Oh good.  Makes life much simpler for users.

After writing that, I actually went back and *checked* the fine print.
It turns out that unless you have installed a not-yet-escaped release of
gcc, -mtune=core2 doesn't work, so it punts to -mtune=generic.  Wandering
over to http://gcc.gnu.org and searching the mailing lists, it seems that
on most of the benchmarks, -mtune=core2 was only a 0.5% or so win on most
stuff in its current form.

--==_Exmh_1168741284_8374P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD4DBQFFqZOkcC3lWbTT17ARAn8hAJUaHKBYoX1k/FOWU/+XyRKrPiYnAJ9fLYBV
jH2Aq6/+6FDJI6BK0bXjZg==
=RUkM
-----END PGP SIGNATURE-----

--==_Exmh_1168741284_8374P--
