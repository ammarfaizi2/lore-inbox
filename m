Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262593AbREOBCo>; Mon, 14 May 2001 21:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262594AbREOBCe>; Mon, 14 May 2001 21:02:34 -0400
Received: from odin.sinectis.com.ar ([216.244.192.158]:30993 "EHLO
	mail.sinectis.com.ar") by vger.kernel.org with ESMTP
	id <S262593AbREOBC0>; Mon, 14 May 2001 21:02:26 -0400
Date: Mon, 14 May 2001 14:07:53 -0300
From: John R Lenton <john@grulic.org.ar>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arjanv@redhat.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Axel Thimm <Axel.Thimm@physik.fu-berlin.de>,
        "Manuel A. McLure" <mmt@unify.com>,
        Rasmus =?iso-8859-1?B?Qvhn?= Hansen <moffe@amagerkollegiet.dk>,
        ARND BERGMANN <std7652@et.fh-osnabrueck.de>,
        "Dunlap, Randy" <randy.dunlap@intel.com>,
        Martin Diehl <mdiehlcs@compuserve.de>,
        Adrian Cox <adrian@humboldt.co.uk>, Capricelli Thomas <orzel@kde.org>,
        Ian Bicking <ianb@colorstudy.com>
Subject: Re: PATCH 2.4.5.1: Fix Via interrupt routing issues
Message-ID: <20010514140752.B19662@grulic.org.ar>
Mail-Followup-To: Jeff Garzik <jgarzik@mandrakesoft.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	arjanv@redhat.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Axel Thimm <Axel.Thimm@physik.fu-berlin.de>,
	"Manuel A. McLure" <mmt@unify.com>,
	 Rasmus =?iso-8859-1?B?Qvhn?= Hansen <moffe@amagerkollegiet.dk>,
	ARND BERGMANN <std7652@et.FH-Osnabrueck.DE>,
	"Dunlap, Randy" <randy.dunlap@intel.com>,
	Martin Diehl <mdiehlcs@compuserve.de>,
	Adrian Cox <adrian@humboldt.co.uk>,
	Capricelli Thomas <orzel@kde.org>,
	Ian Bicking <ianb@colorstudy.com>
In-Reply-To: <3AFEC426.50B00B78@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eHhjakXzOLJAF9wJ"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <3AFEC426.50B00B78@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sun, May 13, 2001 at 01:28:06PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 13, 2001 at 01:28:06PM -0400, Jeff Garzik wrote:
> For those of you with Via interrupting routing issues (or
> interrupt-not-being-delivered issues, etc), please try out this patch
> and let me know if it fixes things.  It originates from a tip from
> Adrian Cox... thanks Adrian!

Just to add a little noise: My box (msi 694d pro AI motherboard,
revI, i.e. vt82c686a) been a *lot* stabler since I removed the
Live! and dropped back to the onboard soundcard.

The only time it has frozen has been when checking to see if this
also fixed the X-freezes-on-reentry thing (which I know was
silly, since CVS X has had that fixed for some time and the fix
is on the slow path to 4.1).

I used to get a freeze (that is a lock-up where I have to reset
the box, unable to even alt-sysrq my way out) between one and
five times per day, nearly always in X, nearly always with sound,
nearly always using up a lot of (memtested) memory.

'nearly always' means 'at least once not' -- scientific as hell.


If I could put in words the difference between the Live! and the
via, I would. Alas, I can't, so you're stuck with this inane
rant:

    please please please fix it.

--=20
John Lenton (john@grulic.org.ar) -- Random fortune:
Las palabras, cera; las obras acero.
        -- Luis de Argote y G=F3ngora. (1561-1627) Poeta espa=F1ol.=20

--eHhjakXzOLJAF9wJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7ABDogPqu395ykGsRAuKYAKC39RM2K0f+n6qjL2Tr1cCcVcoKZQCeMGPe
y5sWiTP2UODfP4bbTMX4gqI=
=dZBZ
-----END PGP SIGNATURE-----

--eHhjakXzOLJAF9wJ--
