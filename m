Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263158AbTIFBl0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 21:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263402AbTIFBl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 21:41:26 -0400
Received: from h80ad25e2.async.vt.edu ([128.173.37.226]:24192 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263158AbTIFBlY (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 21:41:24 -0400
Message-Id: <200309060141.h861fLGw006390@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nasm over gas? 
In-Reply-To: Your message of "Fri, 05 Sep 2003 16:51:21 PDT."
             <20030905235121.GB2743@vitelus.com> 
From: Valdis.Kletnieks@vt.edu
References: <20030904104245.GA1823@leto2.endorphin.org> <3F5741BD.5000401@mbda.fr> <200309042257.12739.mhf@linuxmail.org>
            <20030905235121.GB2743@vitelus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1910645591P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 05 Sep 2003 21:41:21 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1910645591P
Content-Type: text/plain; charset=us-ascii

On Fri, 05 Sep 2003 16:51:21 PDT, Aaron Lehmann said:
> On Thu, Sep 04, 2003 at 10:57:12PM +0800, Michael Frank wrote:
> > As to using assembler, It is better to get rid of it but in special cases.
> > Todays compilers are the better coders in 98+% of applications

> isn't much room for improvement. This assembly is several times faster
> than what gcc would be able to generate.

You're making the rash leap of logic that "gcc" is anywhere representative of
what "todays compilers" are capable of.  For example, IBM recently released
a new version of their 'xlc' compiler with support for the PPC970 core:

http://www.spscicomp.org/ScicomP7/Presentations/Blainey-SciComp7_compiler_update.pdf

20 pages of marketing fluff, interesting graphs on the last 2 pages.  The upshot
is that for the SPECint2000 and SPECfp2000 benchmark suite, IBM's xlc was easily
able to generate code that ran almost twice as fast as gcc.  It was particularly
impressive on the eon, apsi, and sixtrack tests.

Not 10% faster code.  Not 20%.  *TWICE* as fast.

It usually isn't hard to hand-write code that's 20% faster than gcc's generated
code.  Anybody think they can consistently generate code by hand that's twice as fast?

/Valdis (who wonders if the kernel could be made xlc-compilable.. ;)

--==_Exmh_-1910645591P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/WTtBcC3lWbTT17ARAoecAKDLw0IUPGZjKDh+UiIEw68dW2XhrwCfYQvE
2G0TxMC1yQhELAO/ke+c72I=
=k1Wq
-----END PGP SIGNATURE-----

--==_Exmh_-1910645591P--
