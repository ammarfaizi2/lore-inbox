Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261295AbSLMEPZ>; Thu, 12 Dec 2002 23:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261310AbSLMEPZ>; Thu, 12 Dec 2002 23:15:25 -0500
Received: from h80ad2650.async.vt.edu ([128.173.38.80]:13440 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S261295AbSLMEPY>; Thu, 12 Dec 2002 23:15:24 -0500
Message-Id: <200212130422.gBD4Mswo002082@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Greg KH <greg@kroah.com>
Cc: Alessandro Suardi <alessandro.suardi@oracle.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.5[01]]: Xircom Cardbus broken (PCI resource collisions) 
In-Reply-To: Your message of "Thu, 12 Dec 2002 16:43:30 PST."
             <20021213004330.GG23509@kroah.com> 
From: Valdis.Kletnieks@vt.edu
References: <200212122247.gBCMlHgY011021@turing-police.cc.vt.edu>
            <20021213004330.GG23509@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_2108947304P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 12 Dec 2002 23:22:53 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_2108947304P
Content-Type: text/plain; charset=us-ascii

On Thu, 12 Dec 2002 16:43:30 PST, Greg KH said:
> On Thu, Dec 12, 2002 at 05:47:17PM -0500, Valdis.Kletnieks@vt.edu wrote:
> > > PCI: Device 02:00.0 not available because of resource collisions
> > > PCI: Device 02:00.1 not available because of resource collisions
> > 
> > Been there. Done that. Does the attached patch help? It did for me.
> 
> Fixes the problem for me :)

Glad to hear it.  I'm pretty sure I merely backed out a broken change, but
two decades have left me for a healthy respect for "Mel the Real Programmer"
stories ;)

/Valdis

--==_Exmh_2108947304P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE9+WCdcC3lWbTT17ARAhIOAJ90gACjLH9htrQ1LhbhyoM5BNOORwCgt5jh
kvwtl+JGsrrPNkhTN0UqbC4=
=P3YV
-----END PGP SIGNATURE-----

--==_Exmh_2108947304P--
