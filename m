Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318168AbSIEVjy>; Thu, 5 Sep 2002 17:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318191AbSIEVjy>; Thu, 5 Sep 2002 17:39:54 -0400
Received: from tank.panorama.sth.ac.at ([193.170.53.11]:17328 "EHLO
	tank.panorama.sth.ac.at") by vger.kernel.org with ESMTP
	id <S318168AbSIEVjx>; Thu, 5 Sep 2002 17:39:53 -0400
Date: Thu, 5 Sep 2002 23:44:28 +0200
From: Peter Surda <shurdeek@panorama.sth.ac.at>
To: linux-kernel@vger.kernel.org
Subject: Re: Uptime timer-wrap
Message-ID: <20020905214428.GC2853@noir.cb.ac.at>
References: <20020905180253.GC2567@noir.cb.ac.at> <Pine.LNX.3.95.1020905160808.141A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1020905160808.141A-100000@chaos.analogic.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux noir 2.4.9-31
X-Editor: VIM - Vi IMproved 6.0 (2001 Sep 26, compiled Jan 28 2002 06:08:06)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2002 at 04:16:52PM -0400, Richard B. Johnson wrote:
> I tried to simulate your observation by making a driver that
> set the 'jiffies' count upon an 'open'. The idea was to get
> the jiffies count to something close to wrap so I didn't have to
> wait a long time.
>=20
> Anyway, I found that setting the jiffies count to more than a
> few hundred counts into the future, causes the machine to halt
> with no interrupts (no Capslock, no NumLock, no network ping, etc).
I noticed I perhaps didn't describe the symptoms precisely. It didn't stop
working permanently, the network was going up and down unpredictably, in
intervals of about 5 to 20 minutes. Perhaps there was a pattern, but I hope
you'll excuse me for mot measuring the exact times as the main point was to
get it running, not to write a scientific report about it :-).

If it wasn't fixed by a reboot I'd say it was an odd hardware problem.

Bye,

Peter Surda (Shurdeek) <shurdeek@panorama.sth.ac.at>, ICQ 10236103, +436505=
122023

--
                Where do you think you're going today?

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9d9A8zogxsPZwLzcRAnbQAJ46kULHSOC8tdGfTYtxGmH+je2ouwCfVsRk
VaLrrsqyrhobFZP/dJkK95M=
=TpRX
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--
