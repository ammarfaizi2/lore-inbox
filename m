Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268467AbRG3KLv>; Mon, 30 Jul 2001 06:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268451AbRG3KLa>; Mon, 30 Jul 2001 06:11:30 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:44080 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S268454AbRG3KL2>; Mon, 30 Jul 2001 06:11:28 -0400
Date: Mon, 30 Jul 2001 11:11:33 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Thierry Laronde <thierry@cri74.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PCI] building PCI IDs/drivers DB from Linux kernel sources
Message-ID: <20010730111133.M8197@redhat.com>
In-Reply-To: <20010730113319.A24939@pc04.cri.cur-archamps.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="m7GK0ytKUM7VScCy"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010730113319.A24939@pc04.cri.cur-archamps.fr>; from thierry@cri74.org on Mon, Jul 30, 2001 at 11:33:19AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--m7GK0ytKUM7VScCy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 30, 2001 at 11:33:19AM +0200, Thierry Laronde wrote:

> I have decided to write a script (you will find all the stuff attached)
> parsing the Linux kernel sources in order to do that.

For the MODULE_DEVICE_TABLE case, isn't it less fragile to parse the
binary modules?

If there were a program to spit out the MODULE_DEVICE_TABLE in a
format easily parseable by scripts, it would be great; is there such a
program already?

> Driver names:
>=20
> I try to match the filename processed (minus the suffix) against entries =
in
> the Makefile, and even try a substring against the Makefile in order to
> guess the correct driver name. When everything fails, the log file indica=
tes
> the problem, and I have built a "drivers_aliases" giving the correct name
> for these files.

Again for the MODULE_DEVICE_TABLE case, there is nothing to guess.

> May I suggest some possible tracks?
>=20
> * Use of macro definitions for magic numbers
[...]
> * Define the driver name in the file
[...]
> * Define the class name in the file too
[...]

None of this is needed if people just use the MODULE_DEVICE_TABLE
mechanism that is already provided.

Tim.
*/

--m7GK0ytKUM7VScCy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7ZTLVONXnILZ4yVIRAns5AJ9TcKq/iVT7lYPgWC35iAG5p7jr3ACgoHvF
lp13NT2f2t2sDsLLnxvTR2o=
=rpLc
-----END PGP SIGNATURE-----

--m7GK0ytKUM7VScCy--
