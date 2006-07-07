Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbWGGXsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbWGGXsp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 19:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWGGXsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 19:48:45 -0400
Received: from mail.gmx.de ([213.165.64.21]:45956 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751027AbWGGXsp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 19:48:45 -0400
X-Authenticated: #2308221
Date: Sat, 8 Jul 2006 01:48:33 +0200
From: Christian Trefzer <ctrefzer@gmx.de>
To: Alon Bar-Lev <alon.barlev@gmail.com>
Cc: Hua Zhong <hzhong@gmail.com>, Jan Rychter <jan@rychter.com>,
       linux-kernel@vger.kernel.org, suspend2-devel@lists.suspend2.net
Subject: Re: swsusp / suspend2 reliability
Message-ID: <20060707234833.GA29710@hermes.uziel.local>
References: <m2k66qzgri.fsf@tnuctip.rychter.com> <018b01c6a1fb$59f74b80$493d010a@nuitysystems.com> <9e0cf0bf0607071410y4c460a1ayb0ce925bacbc1881@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <9e0cf0bf0607071410y4c460a1ayb0ce925bacbc1881@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

On Sat, Jul 08, 2006 at 12:10:38AM +0300, Alon Bar-Lev wrote:
> And if suspend-to-disk is more complex, it should be solved first,
> since suspend-to-ram can be a subset of the process (Although people
> in the past dismissed this claim... :( ).

IMHO this is a bit ironic. Generally, if there is a complex problem that
can be divided in smaller parts, which are possible to address one at a
time, this should be the preferred way! Divide and conquer, my friend : )

Applied to the suspend dilemma: once we get suspend2ram working
perfectly, the only thing we still have to care for is saving the memory
image someplace, right before telling the hardware to sleep or switch
off. You might get the benefit of chosing between power-off for ultimate
power savings vs. speedy suspend2ram, yet with a backup on disk in case
something weird happens to the power supply. Nice, huh?


> So I guess we will continue to use suspend2 for a long while... Since
> at least someone cares, and have a vision reacher than hay I can do
> this in userspace.

I've been a happy suspend2 user for quite some time now, and I have to
admit I don't much care how broken the design is - for now it works, the
only alternative is just as broken, and did not work as well last time I
checked. And heck, I just don't have time to check with every new kernel
I build. Talk about working setup vs. academic progress, which in turn
will lead to a clean working setup maybe some time soon, may be later,
but not now. I'll look into it as soon as any progress is visible and
time available), s2ram is nice even on a laptop without battery ; )


Kind regards, and welcome to suspend2 family!

Chris

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)

iQIVAwUBRK7yz6nY3eLOiwZcAQqv5w//baAu16s8EfvqUkNHzSceBHhOofOVkfAN
b8xWf/8A2Dhg/FWCFu/SThfuNAWa+t/nPNwP1y8l9A5zqj75XE8oQQEdjU0CAn+y
dzyKDIZn9sGOFMc2KHD317YlS2Af8I79jyOJ2pb6bo8rYtM8k3N8J71urEqI2TvN
h18mEjh4TK6f2wvVmxLuwqFCIM3YFshpOjag7ut5nIQQoZBEqnyvuh4EETVwAuCH
43nJx0+FwwrMPXZ43oIwDaKEKCcfNB7UqYmt/u0TWhA0GZg1N7rlRv+Si/nV3qvu
slJUP9yohojPyCeKpVURcwG1vIUjH/qMnAwU6zAgcV3MXUMKH04U/ukzTLIdlsmS
YFL1I/XQoihh4xxSPfkotqIqS9Z48I1ndkw5ZqE/lgQ2vNw1F8Uv5dD5tbM4wIeq
RcnLAlFExEtWQfhDneGrJZixyg5DaispTU5lJnHzZ7FkLODRKYAmcRQ+S+iogUeK
t4xrEtyoY/14XUWYo5UOSzwwz+rNq9kYeGJ3sU1OYDFIkFoqXgntErj9M3iPN4Ys
xTbJ1IYLvcsq+YCA72ZBistD57LFkU3uTaQDvR5Jy70ZdWokVBpRW5As8hVVZ5ML
NJi/trRQZizkGhnmC+xO/SCbA6TBsWBNGtBe4P38iqFqhXQNVXFT37AsGRhZ9O4W
kh4JeG/QFWs=
=v94n
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--

