Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131191AbRDGTwb>; Sat, 7 Apr 2001 15:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131219AbRDGTwV>; Sat, 7 Apr 2001 15:52:21 -0400
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:48434 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S131191AbRDGTwM>; Sat, 7 Apr 2001 15:52:12 -0400
Date: Sat, 7 Apr 2001 20:52:04 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: =?iso-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>,
        Michael Reinelt <reinelt@eunet.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Multi-function PCI devices
Message-ID: <20010407205204.H3280@redhat.com>
In-Reply-To: <3ACECA8F.FEC9439@eunet.at> <Pine.LNX.4.10.10104071043360.1085-100000@linux.local> <20010407200053.B3280@redhat.com> <3ACF6D1D.63A2A2FE@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="2xzXx3ruJf7hsAzo"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3ACF6D1D.63A2A2FE@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sat, Apr 07, 2001 at 03:40:13PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2xzXx3ruJf7hsAzo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 07, 2001 at 03:40:13PM -0400, Jeff Garzik wrote:

> Who said you have to have a separate driver for every single multi-IO
> card?  A single driver could support all serial+parallel multi-IO cards,
> for example.

Okay, I misunderstood.	I'll take a look at doing this for 2.4.

First of all, parport_pc will need to export the equivalent of
register_serial (its equivalent is probably parport_pc_probe_port).
[It actually already does this (conditionally on parport_cs).]

drivers/parport/parport_serial.c sound okay, or is a different place
better?

Tim.
*/

--2xzXx3ruJf7hsAzo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6z2/kONXnILZ4yVIRAuMLAJ9aZUwumYWMW+4eErQRA2prXGq1+QCdFYtv
hv6wrBt0+JW/HvWPk92qhNk=
=XR3y
-----END PGP SIGNATURE-----

--2xzXx3ruJf7hsAzo--
