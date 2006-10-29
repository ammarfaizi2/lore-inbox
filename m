Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965295AbWJ2Q76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965295AbWJ2Q76 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 11:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965297AbWJ2Q76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 11:59:58 -0500
Received: from pool-72-66-199-112.ronkva.east.verizon.net ([72.66.199.112]:60869
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S965295AbWJ2Q76 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 11:59:58 -0500
Message-Id: <200610291659.k9TGxnwZ011825@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: why test for "__GNUC__"?
In-Reply-To: Your message of "Sun, 29 Oct 2006 10:48:43 EST."
             <Pine.LNX.4.64.0610291044230.9726@localhost.localdomain>
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.64.0610290610020.6502@localhost.localdomain> <Pine.LNX.4.61.0610291244310.15986@yvahk01.tjqt.qr> <Pine.LNX.4.64.0610290742310.7457@localhost.localdomain> <20061029120534.GA4906@martell.zuzino.mipt.ru>
            <Pine.LNX.4.64.0610291044230.9726@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1162141188_6875P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 29 Oct 2006 11:59:48 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1162141188_6875P
Content-Type: text/plain; charset=us-ascii

On Sun, 29 Oct 2006 10:48:43 EST, "Robert P. J. Day" said:
> On Sun, 29 Oct 2006, Alexey Dobriyan wrote:
> 
> > On Sun, Oct 29, 2006 at 07:44:18AM -0500, Robert P. J. Day wrote:
> > > p.s.  is there, in fact, any part of the kernel source tree that has a
> > > preprocessor directive to identify the use of ICC?  just curious.
> >
> > Please, do
> >
> > 	ls include/linux/compiler-*
> 
> but according to compiler.h:
> 
> /* Intel compiler defines __GNUC__. So we will overwrite implementations
>  * coming from above header files here
>  */
> 
> so even ICC will define __GNUC__, which means that testing for
> __GNUC__ is *still*, under the circumstances, redundant, isn't that
> right?

The Intel compiler started defining __GNUC__ fairly recently (within the
last 2-3 years).  Most likely the tests date from long ago and far away,
before it did so.

--==_Exmh_1162141188_6875P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFRN4EcC3lWbTT17ARAkuWAJ0VLzuYtxLlaH7616NndCkWW3rqFACfQYuY
RZLEEcz9HXxJ2Dc9YoWGKow=
=fA3l
-----END PGP SIGNATURE-----

--==_Exmh_1162141188_6875P--
