Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277804AbRJaIaF>; Wed, 31 Oct 2001 03:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278269AbRJaI34>; Wed, 31 Oct 2001 03:29:56 -0500
Received: from client34029.atl.mediaone.net ([24.88.34.29]:38382 "HELO
	babylon.d2dc.net") by vger.kernel.org with SMTP id <S277804AbRJaI3p>;
	Wed, 31 Oct 2001 03:29:45 -0500
Date: Wed, 31 Oct 2001 03:30:18 -0500
From: "Zephaniah E\. Hull" <warp@mercury.d2dc.net>
To: Justin Mierta <Crazed_Cowboy@stones.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, hahn@physics.mcmaster.ca,
        lung@theuw.net, linux-kernel@vger.kernel.org
Subject: Re: ECS k7s5a motherboard doesnt work
Message-ID: <20011031033018.A1917@babylon.d2dc.net>
Mail-Followup-To: "Zephaniah E. Hull" <warp@babylon.d2dc.net>,
	Justin Mierta <Crazed_Cowboy@stones.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, hahn@physics.mcmaster.ca,
	lung@theuw.net, linux-kernel@vger.kernel.org
In-Reply-To: <E15y9q4-0002ER-00@the-village.bc.nu> <3BDD7164.8080401@stones.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <3BDD7164.8080401@stones.com>
User-Agent: Mutt/1.3.23i
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 29, 2001 at 10:10:28AM -0500, Justin Mierta wrote:
> well, i dont have a floppy drive, so that test is a little difficult to=
=20
> do, but i threw some ram in there that i have used in linux before, and=
=20
> i still had the slew of ide error messages.  and this harddrive has=20
> worked in linux before.  i'm getting more and more convinced its an ide=
=20
> controller +linux issue.
>=20
> plus, i just discovered this:
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0109.1/0198.html
>=20
> which really points to ide controller and linux not fighting nicely=20
> together, altho the thread doesnt really point towards a solution.

I'm using a K7S5A with recent 2.4.x kernels, and have no major
problems[0].

I don't remember why I have CONFIG_IDEDISK_MULTI_MODE on, but I do.

I also have CONFIG_IDEDMA_NEW_DRIVE_LISTINGS on, and obviously have
CONFIG_BLK_DEV_SIS5513 on.

Oh, and I have CONFIG_IDEDMA_IVB as well.

The only problems I have seen with this board are that I can't find
drivers for the sound (no big loss), lmsensors does not seem to be able
to properly read the sensors (annoying), repeated 'VFS: Disk change
detected on device ide1(22,0)' messages (my cdrom drive, getting a
little annoying), and, thats about it.

I have not seen any data corruption.

My obvious question is what kernels are you running, and are you
enabling CONFIG_BLK_DEV_SIS5513 or not?

Zephaniah E. Hull.
>=20
> justin

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

   "<green>From</yellow>"
   "Wow. The green word From is no longer yellow. That's deep, man."
 -- Marcus Meissner & Lars Balker Rasmussen in the Scary Devil Monastery

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE737aaRFMAi+ZaeAERAqwvAJ9EglDFvaWl18JNk8I+VE2i7cRcjwCeL4Cz
E9QltqJ98twkzlqrIS+5KG0=
=JqiZ
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
