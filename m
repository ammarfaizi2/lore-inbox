Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265477AbUJLOfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265477AbUJLOfH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 10:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUJLOdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 10:33:10 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:37008 "EHLO vagabond.light.src")
	by vger.kernel.org with ESMTP id S264704AbUJLOcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 10:32:13 -0400
Date: Tue, 12 Oct 2004 16:31:54 +0200
From: Jan Hudec <bulb@ucw.cz>
To: jonathan@jonmasters.org
Cc: suthambhara nagaraj <suthambhara@gmail.com>,
       "Dhiman, Gaurav" <gaurav.dhiman@ca.com>,
       main kernel <linux-kernel@vger.kernel.org>,
       kernel <kernelnewbies@nl.linux.org>
Subject: Re: Kernel stack
Message-ID: <20041012143154.GV703@vagabond>
References: <577528CFDFEFA643B3324B88812B57FE3055B9@inhyms21.ca.com> <46561a790410112351942e735@mail.gmail.com> <20041012094104.GM703@vagabond> <35fb2e5904101207304a5b4c8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hFEw+uh9kF5V6COn"
Content-Disposition: inline
In-Reply-To: <35fb2e5904101207304a5b4c8d@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--hFEw+uh9kF5V6COn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 12, 2004 at 15:30:34 +0100, Jon Masters wrote:
> On Tue, 12 Oct 2004 11:41:04 +0200, Jan Hudec <bulb@ucw.cz> wrote:
>=20
> > The base of the stack does not have to be stored either, because it is
> > AT FIXED OFFSET from the task_struct! If you don't believe me, look at
> > definition of the current macro. It says just (%esp & ~8195) (it says it
> > in assembly, because you can't directly access registers from C, and it
> > uses some macros that mean "two pages" instead of 8195).
>=20
> The pedant in me wants to point out that 8K is 0-8191 and not 0-8195 :-)

OOPS, a braino ;-).

---------------------------------------------------------------------------=
----
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--hFEw+uh9kF5V6COn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBa+raRel1vVwhjGURAk0oAKC/TCneW6P9T1rpb2aldRktHD2XuACggywS
TCNVVV/xBTnGs128/z8W+UA=
=g80x
-----END PGP SIGNATURE-----

--hFEw+uh9kF5V6COn--
