Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131354AbRADLUw>; Thu, 4 Jan 2001 06:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132799AbRADLUm>; Thu, 4 Jan 2001 06:20:42 -0500
Received: from firebox-ext.surrey.redhat.com ([194.201.25.236]:35579 "EHLO
	meme.surrey.redhat.com") by vger.kernel.org with ESMTP
	id <S131354AbRADLU3>; Thu, 4 Jan 2001 06:20:29 -0500
Date: Thu, 4 Jan 2001 11:20:27 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Printing to off-line printer in 2.4.0-prerelease
Message-ID: <20010104112027.G23469@redhat.com>
In-Reply-To: <m2k88czda4.fsf@ppro.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="5L6AZ1aJH5mDrqCQ"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m2k88czda4.fsf@ppro.localdomain>; from peter.osterlund@mailbox.swipnet.se on Wed, Jan 03, 2001 at 07:44:19PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5L6AZ1aJH5mDrqCQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 03, 2001 at 07:44:19PM +0100, Peter Osterlund wrote:

> When trying to print to an off-line printer with 2.4 kernels, the
> "write" system call to /dev/lp0 stalls for 10 seconds and then returns
> EIO.

I wonder where the EIO is coming from though.  Grep only shows up
ieee1284.c (in parport_read) and daisy.c (in cpp_mux, called at
parport init time).  Neither of those should be getting triggered.

Tim.
*/

--5L6AZ1aJH5mDrqCQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6VFx6ONXnILZ4yVIRAuu8AKCXi5vFu+0DlGIC0ZBXeOJ7YRnthQCgoyzT
OxzfV2JNJO38aCwgacRN6Qw=
=/WpH
-----END PGP SIGNATURE-----

--5L6AZ1aJH5mDrqCQ--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
