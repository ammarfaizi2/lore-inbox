Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261238AbSKVJ4A>; Fri, 22 Nov 2002 04:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261337AbSKVJ4A>; Fri, 22 Nov 2002 04:56:00 -0500
Received: from point41.gts.donpac.ru ([213.59.116.41]:18185 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S261238AbSKVJz6>;
	Fri, 22 Nov 2002 04:55:58 -0500
Date: Fri, 22 Nov 2002 13:02:15 +0300
From: Andrey Panin <pazke@orbita1.ru>
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Q] is framebuffer console code in 2.5.4x functional ?
Message-ID: <20021122100215.GA4998@pazke.ipt>
Mail-Followup-To: James Simmons <jsimmons@infradead.org>,
	linux-kernel@vger.kernel.org
References: <20021120094654.GA319@pazke.ipt> <Pine.LNX.4.33.0211210753100.9540-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0211210753100.9540-100000@maxwell.earthlink.net>
User-Agent: Mutt/1.4i
X-Uname: Linux pazke 2.2.17 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2002 at 05:24:44PM +0000, James Simmons wrote:
>=20
>=20
> > > > console doesn't show a single pixel.
> > >=20
> > > :-( Can you post your .config file.=20
> >=20
> > Attached.
>=20
> Hm. Strange. It should work. Can you get serial console working?=20

Forgot to mention, I've seen message:
	fbcon_setup: No support for fontwidth 8
in /var/log/dmesg.=20

I found this printk() in fbcon_setup(), but i can't even imagine=20
why it happens.

Sorry for not providing full info, but when i wrote first letter=20
my head was full of gory thoughts about visws legacy irq handling :(
I can post complete log tomorrow.
  =20
> > I did some changes to sgivwfb.c to make it compilable, patch attached.
> > Can you take a look at it ?
>=20
> Applied your patch to the BK tree.=20
Good.
 =20
> > > I will be posting a new fbdev patch today against 2.5.48 today. Giev =
it a=20
> > > try.
> >=20
> > Didn't see proposed fbdev patch yet :(
>=20
>     Sorry about that. You are not the only one that has asked me. Also I=
=20
> keep getting lots of error reports about drivers being broken. The proble=
m=20
> is having enough time. For example I haven't found the time to create thi=
s=20
> patch. This brings up a serious point which I have been wrestling with. T=
he=20
> framebuffer layer has been broken for a long time durning the 2.5.X cycle=
=20
> The problem is both maintainers of this subsystem, Geert and I, both have=
=20
> very little time to work on it. For both of us we don't work on the=20
> framebuffer code for a living. I work with wireless networking cards. I=
=20
> work 8 hours a day on networking code and travel 3 hours total every day=
=20
> to work. Including eating a sleeping and I have at most 1 to 2 hours a da=
y=20
> to work on the framebuffer stuff. Weekends I have to do other survial=20
> things like buy food. So the framebuffer developement has gone at a=20
> snail pace and will continue to do so unless things change. I estimate=20
> about 20+ more versions before the framebuffer layer properly works.=20
>     It pains me that this is happening. I really enjoy working on the=20
> framebuffer and console layer. So I have been thinking about what to=20
> do ? One which is the most likely is to step down from maintaintership=20
> and hope someone else who can devote there full time and energy to it=20
> can take over. Will someone else take over? I seriously doubt it. We all=
=20
> have to make a living and that means working on things the linux industry=
=20
> cares about which is only server stuff. So I except the framebuffer layer=
=20
> will go into serious code decay. So the best situtation which I except to=
=20
> happen is that I finish as much as I can for the fbdev layer and then=20
> step down.=20
>     I have tried to look for work locallly (can't really affored to move=
=20
> cross country very few years) relating to the framebuffer layer. In my=20
> search I only found one company that seemed interested in this developeme=
nt,=20
> strangeberry (http://www.strangeberry.com). I sent them my resume but=20
> never heard from them. As for funding I serious doubt that would happen=
=20
> since it isn't server related. The reality is for proper maintiance of an=
y=20
> subsystem you need people hired to solely work to keep it going.=20
> Unfortunely the framebuffer layer is one of those few ones that doesn't=
=20
> have that.

I understand this situation perfectly, looks like it's almost common for
developers working in "not so importatnt for servers" subsystems :(

--=20
Andrey Panin            | Embedded systems software developer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE93gCnBm4rlNOo3YgRAlz2AJ9rWQCPfuWCfFHgUsOMTFWvHmhaQwCfb9Ky
w7WB1qiY1lrFog5/rbJtmtk=
=FEJj
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
