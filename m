Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262458AbUJ0Pv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbUJ0Pv6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 11:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbUJ0Pv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 11:51:57 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:22739 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S262458AbUJ0Pvt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 11:51:49 -0400
Date: Wed, 27 Oct 2004 17:48:28 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Erik Andersen <andersen@codepoet.org>, uclibc@uclibc.org
Subject: Re: The naming wars continue...
Message-ID: <20041027154828.GA21160@thundrix.ch>
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org> <20041026203137.GB10119@thundrix.ch> <417F2251.7010404@zytor.com> <200410271133.25701.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <200410271133.25701.vda@port.imtp.ilyichevsk.odessa.ua>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Salut,

On Wed, Oct 27, 2004 at 11:33:25AM +0300, Denis Vlasenko wrote:
> Why there is any distinction between, say, gcc and X?
> KDE and Midnight Commander? etc... Why some of them go
> to /opt while others are spread across dozen of dirs?

Well.

FHS specifies that everything needed  to boot the system should got to
/bin  and /sbin. The  base system  (build system,  etc.) should  go to
/usr. The rest should be /opt/itspackagename.

I'm not quite a FHS fan. I use libexec dirs, but I still have my build
system under /usr (and my home  under /usr/home), and the rest (X, KDE
et al) lives under /opt.

			    Tonnerre


--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBf8NM/4bL7ovhw40RAsOgAJ0WOGRZvGQnd0TEgJdgIF8KWuTL4ACfcSse
oeL0eeXQ9c7hHcK3ZrLM3jk=
=n1oq
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
