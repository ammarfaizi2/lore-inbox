Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130374AbRADLRd>; Thu, 4 Jan 2001 06:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131354AbRADLRX>; Thu, 4 Jan 2001 06:17:23 -0500
Received: from firebox-ext.surrey.redhat.com ([194.201.25.236]:33275 "EHLO
	meme.surrey.redhat.com") by vger.kernel.org with ESMTP
	id <S130374AbRADLRN>; Thu, 4 Jan 2001 06:17:13 -0500
Date: Thu, 4 Jan 2001 11:17:08 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>,
        linux-kernel@vger.kernel.org, linux-parport@torque.net
Subject: Re: Printing to off-line printer in 2.4.0-prerelease
Message-ID: <20010104111708.F23469@redhat.com>
In-Reply-To: <20010104014115.C6256@athlon.random> <Pine.LNX.4.30.0101040158310.3983-100000@ppro.localdomain> <20010104023921.A9503@athlon.random>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="5CUMAwwhRxlRszMD"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010104023921.A9503@athlon.random>; from andrea@suse.de on Thu, Jan 04, 2001 at 02:39:21AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5CUMAwwhRxlRszMD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 04, 2001 at 02:39:21AM +0100, Andrea Arcangeli wrote:

> On Thu, Jan 04, 2001 at 02:09:56AM +0100, Peter Osterlund wrote:
> > should say that it is obsolete. I think obsolete means "you should never
> > ever have to use this stuff".
>=20
> Agreed.

I think that LP_CAREFUL is still needed.  There are printers that
think that nFault overrides the other error lines and there are
printers that drag nFault to 'okay to print' when off.  To keep
everyone happy (those that want to print to error-line-wreckless
printers, and those that want jobs being sent to a printer that's off
to wait until the printer comes online) I think we need LP_CAREFUL to
remain.

Tim.
*/

--5CUMAwwhRxlRszMD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6VFuzONXnILZ4yVIRAl8UAJ9Z3pS9202y5VFuNt49uFUdKqLOvwCghjhr
SbSbaHmb/uepl1ILVLCfMoI=
=Fpb4
-----END PGP SIGNATURE-----

--5CUMAwwhRxlRszMD--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
