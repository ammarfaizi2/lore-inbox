Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130918AbQLLSDp>; Tue, 12 Dec 2000 13:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130036AbQLLSDf>; Tue, 12 Dec 2000 13:03:35 -0500
Received: from h201.s254.netsol.com ([216.168.254.201]:12161 "EHLO
	tesla.admin.cto.netsol.com") by vger.kernel.org with ESMTP
	id <S130918AbQLLSDV>; Tue, 12 Dec 2000 13:03:21 -0500
Date: Tue, 12 Dec 2000 12:33:17 -0500
From: Pete Toscano <pete@research.netsol.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test12 not liking high disk i/o
Message-ID: <20001212123317.D1139@tesla.admin.cto.netsol.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <F78B9AA62E2@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <F78B9AA62E2@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Tue, Dec 12, 2000 at 06:06:51PM +0000
X-Uptime: 12:28pm  up  1:09,  4 users,  load average: 0.49, 0.34, 0.18
X-Married: 394 days, 16 hours, 43 minutes, and 2 seconds
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

well, i hate to be piling on here, but i just encountered this (i think
it's this) this morning.  i was printing a 145+m file (to /dev/lp0) from
an ide drive and it locked up.  just before the lockup, i noticed it was
very sluggish, as if it were under very heavy load (which is really
wasn't).  this is on an smp-enabled machine (noapic at lilo prompt
because of the usb/pirq(?) problem).  i'm using 2.4.0-test12 on a tyan
tiger 133 (via apollo 133a chipset) mobo.  the machine has 512m memory
and another 512m in swap (didn't notice much swap activity, but i could
have missed it).  there were no messages in the logs.

if there's any info i can provide or tests i can run, just let me know.

pete

On Tue, 12 Dec 2000, Petr Vandrovec wrote:

> On 12 Dec 00 at 17:43, Niels Kristian Bech Jensen wrote:
> > On Tue, 12 Dec 2000, Mohammad A. Haque wrote:
> >=20
> > > Any one else experiencing problems when they do lots of disk activity
> > > in test12?
> > >
> > Yes, I've had some complete freezes (nothing working at all) in
> > test12-pre8 and test12. They can be triggered by e.g. Netscape.
> > test12-pre7 seems to be stable.

--=20
Pete Toscano    p:sigsegv@psinet.com     w:pete@research.netsol.com
GPG fingerprint: D8F5 A087 9A4C 56BB 8F78  B29C 1FF0 1BA7 9008 2736

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6NmFdH/Abp5AIJzYRArSqAJoCKzmw6OQjoPqW52G8PFqQsNKbHwCcC/IY
xGexV2iWscVJtHdLK0ss3yk=
=2Q7m
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
