Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262607AbRFHS3e>; Fri, 8 Jun 2001 14:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262389AbRFHS3Y>; Fri, 8 Jun 2001 14:29:24 -0400
Received: from odin.sinectis.com.ar ([216.244.192.158]:35847 "EHLO
	mail.sinectis.com.ar") by vger.kernel.org with ESMTP
	id <S262622AbRFHS3O>; Fri, 8 Jun 2001 14:29:14 -0400
Date: Fri, 8 Jun 2001 15:28:59 -0300
From: John R Lenton <john@grulic.org.ar>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [driver] New life for Serial mice
Message-ID: <20010608152859.B20894@grulic.org.ar>
Mail-Followup-To: Vojtech Pavlik <vojtech@suse.cz>,
	Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <20010606125556.A1766@suse.cz> <20010606232133.E38@toy.ucw.cz> <20010608181521.A1998@suse.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
Content-Disposition: inline
In-Reply-To: <20010608181521.A1998@suse.cz>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


sorry I'm late, could you tell me where this driver/patch is?

also, my problem with USB mice on slow machines is that it takes
up too much CPU, and you get a jumpy mouse if your box is doing a
lot of work (like a heavy nfs server, say). Would this driver do
the same to that box?


On Fri, Jun 08, 2001 at 06:15:21PM +0200, Vojtech Pavlik wrote:
> On Wed, Jun 06, 2001 at 11:21:34PM +0000, Pavel Machek wrote:
>=20
> > > If you still have your 3-button MouseSystems (or any other serial) mo=
use
> > > somewhere in your driver, forgotten becase of the incredibly slow upd=
ate
> > > rate causing so much jumping of the pointer on the screen that it is
> > > unusable, you may want to pull it out and give it a try.
> > >=20
> > > Or if you're still using it with some old 486 computer, this driver is
> > > for you.=20
> > >=20
> > > What it does is that it enhances the update rate from 24 (with current
> > > GPM and X drivers) to 96. This is almost what the best USB mice do.
> >=20
> > What's the "prediction" stuff? Does it mean you are guessing some values
> > by interpolation?
>=20
> Extrapolation, yes.
>=20
> > [If so, what kind of update rate would it do on USB?]
>=20
> It wouldn't make any difference - on USB you always get whole packets,
> while over serial port the data is processed byte by byte and thus we
> know a little of the information before the whole packet arrives.
>=20
> --=20
> Vojtech Pavlik
> SuSE Labs
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

--=20
John Lenton (john@grulic.org.ar) -- Random fortune:
Hear about...
	the nymphomaniac teenager popularly known as Little Often Annie?

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7IRlrgPqu395ykGsRAuGuAJ9JnVBdqKEM3i1pq9i+XTfok8eT+ACeI8uP
4cNSvtEJFoRvv4pXykUfjDc=
=Tbhu
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--
