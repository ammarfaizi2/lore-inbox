Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271225AbTHHGDI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 02:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271235AbTHHGDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 02:03:07 -0400
Received: from h80ad2653.async.vt.edu ([128.173.38.83]:28606 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S271225AbTHHGDF (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 02:03:05 -0400
Message-Id: <200308080602.h7862xGk013370@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Frank Cusack <fcusack@fcusack.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NPTL v userland v LT (RH9+custom kernel problem) 
In-Reply-To: Your message of "Thu, 07 Aug 2003 22:45:45 PDT."
             <20030807224545.A29285@google.com> 
From: Valdis.Kletnieks@vt.edu
References: <20030807013930.A26426@google.com> <1060267356.1604.10.camel@p3.coop.hom> <200308071506.04890.Mathias.Froehlich@web.de>
            <20030807224545.A29285@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-128561347P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 08 Aug 2003 02:02:59 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-128561347P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, 07 Aug 2003 22:45:45 PDT, Frank Cusack said:

> Interesting.  Something these have in common is that they all use
> Berkeley db4 (up2date by virtue of using rpm).  I don't understand why
> nss_ldap or pam_ldap would, but it's one of the sources in the srpm.

ISTR that db4 was buggy in its handling of O_DIRECT - the changed 2.6
semantics gave it indigestion - from the RedHat RPM's changelog:

* Tue Jun 24 2003 Jeff Johnson <jbj@redhat.com> 4.1.25-4

- hack out O_DIRECT support in db4 for now.


--==_Exmh_-128561347P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/Mz0TcC3lWbTT17ARAmfvAJ9Dnlkf+QJMCSKSD4H8D/nZ6pSNyQCg4aq3
cN3im+KM9ELZ6bDnsDXNVSg=
=3hj/
-----END PGP SIGNATURE-----

--==_Exmh_-128561347P--
