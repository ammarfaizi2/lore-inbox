Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266728AbSLWPmn>; Mon, 23 Dec 2002 10:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266730AbSLWPmn>; Mon, 23 Dec 2002 10:42:43 -0500
Received: from c-24-99-36-145.atl.client2.attbi.com ([24.99.36.145]:5899 "HELO
	babylon.d2dc.net") by vger.kernel.org with SMTP id <S266728AbSLWPmm>;
	Mon, 23 Dec 2002 10:42:42 -0500
Date: Mon, 23 Dec 2002 10:50:48 -0500
From: "Zephaniah E\. Hull" <warp@babylon.d2dc.net>
To: Rudmer van Dijk <rudmer@legolas.dynup.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.x console keyboard problem.
Message-ID: <20021223155048.GA19266@babylon.d2dc.net>
Mail-Followup-To: Rudmer van Dijk <rudmer@legolas.dynup.net>,
	Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 23, 2002 at 04:38:37PM +0100, Rudmer van Dijk wrote:
> Hi,
>=20
> I have also been seeing this kind of behavior, but more with deadlocks th=
an=20
> messed up in/output. Only I have not had the time to see where the proble=
m=20
> lies...=20
>=20
> my problems are appearing when I switch away from X:
> 1) black screen, completely dead (not responding to keyboard or network)
> 2) normal console but after some time, dead (as in 1)
> 3) mostly black screen with some colored vertical lines and a mouse point=
er,=20
> not responsive to keyboard but system can be reached over the network
>=20
> and the funny thing is that it does not always happen, sometimes I am abl=
e to=20
> switch between X and console for 10 times or more...

To cheat, just tap the Fn key twice when switching to X, to cheat better
change your keymap to not have binds for ctrl-alt-Fn.

It seems very likely that while some cards can survive being poked at by
the vgacon driver while the X driver is also talking to them, other
cards have more, significant problems.
>=20
> I have been seeing this since 2.5.50.=20

But it did not at 2.5.49? That should definitely help him isolate it..

Zephaniah E. Hull.
(All I want for Christmas is a /job/.)
>=20
> 	Rudmer

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

}>No.  I just point out to troublemakers that I have an English degree,
}>which means that I am allowed to make changes to the English language.
}>(What _else_ could it possibly be for?)
}Wow; in that case, my physics degree is *WAY* more useful than I
}had thought.
This just proves how useless a computer science degree is:  there is hardly
any useful science involved at all.  I want my computer black magic degree!
	-- Victoria Swann, Jonathan Dursi, and D. Joseph Creighton on ASR

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+BzDYRFMAi+ZaeAERAt3ZAJ9lpNOodJcb8TRAeFyrM1eN3tdJSgCgtMxV
99g7dsusFgoNRjCCMLGlys4=
=6l9u
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
