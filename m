Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964910AbVKQWXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbVKQWXk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 17:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964911AbVKQWXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 17:23:40 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:59543 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S964910AbVKQWXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 17:23:39 -0500
Message-Id: <200511172223.jAHMNUEt014746@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc1-mm1 
In-Reply-To: Your message of "Thu, 17 Nov 2005 22:14:46 GMT."
             <8752.1132265686@warthog.cambridge.redhat.com> 
From: Valdis.Kletnieks@vt.edu
References: <200511172130.jAHLUCP0010033@turing-police.cc.vt.edu> <20051117111807.6d4b0535.akpm@osdl.org>
            <8752.1132265686@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1132266210_3677P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 17 Nov 2005 17:23:30 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1132266210_3677P
Content-Type: text/plain; charset=us-ascii

On Thu, 17 Nov 2005 22:14:46 GMT, David Howells said:
> 
> Valdis.Kletnieks@vt.edu wrote:
> 
> > Why does keyctl.c declare it as 'asmlinkage'?
> 
> Because it's wrong.

Am chasing another issue - once I got past that, it wouldn't boot at all.
Grub would act like it was loading, then 2 seconds or so later, grub would
start up again.  My first guess was CONFIG_DEBUG_RODATA=y, but I ruled that
out.  More detail once I've done some more binary searching and ruled out
self-inflicted idiocy....


--==_Exmh_1132266210_3677P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDfQLicC3lWbTT17ARAvitAJ4uIGQi9Jw7FWKzqfIu6p5ZMPW9GQCgoaUL
FsYAzJMgfwdk59J7YXzfaEM=
=aHsH
-----END PGP SIGNATURE-----

--==_Exmh_1132266210_3677P--
