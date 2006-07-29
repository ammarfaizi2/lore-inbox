Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWG2SLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWG2SLX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 14:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWG2SLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 14:11:22 -0400
Received: from 63-162-81-179.lisco.net ([63.162.81.179]:49124 "EHLO
	grunt.slaphack.com") by vger.kernel.org with ESMTP id S932202AbWG2SLW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 14:11:22 -0400
Message-ID: <44CBA4BF.80301@slaphack.com>
Date: Sat, 29 Jul 2006 13:11:11 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060708)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Hans Reiser <reiser@namesys.com>, Linus Torvalds <torvalds@osdl.org>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       Theodore Tso <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: metadata plugins (was Re: the " 'official' point of view"	expressed
 by kernelnewbies.org regarding reiser4 inclusion)
References: <200607281402.k6SE245v004715@laptop13.inf.utfsm.cl>	 <44CA31D2.70203@slaphack.com>	 <Pine.LNX.4.64.0607280859380.4168@g5.osdl.org>	 <44C9FB93.9040201@namesys.com> <44CA6905.4050002@slaphack.com>	 <44CA126C.7050403@namesys.com> <44CA8771.1040708@slaphack.com>	 <44CABB87.3050509@namesys.com> <1154164364.2903.10.camel@laptopd505.fenrus.org>
In-Reply-To: <1154164364.2903.10.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="------------enig8221BD0B50F43671F10ACC78"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8221BD0B50F43671F10ACC78
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Arjan van de Ven wrote:
>> Most users not only cannot patch a kernel, they don't know what a patc=
h
>> is.  It most certainly does.=20
>=20
>=20
> obviously you can provide complete kernels, including precompiled ones.=

> Most distros have a yum or apt or similar tool to suck down packages,
> it's trivial for users to add a site to that, so you could provide
> packages if you want and make it easy for them.

What's more, many distros patch their kernels extensively.  They listen
to their users, too.  So if there are a lot of users wanting this to be
in the kernel, let them complain -- loudly -- to their distro to patch
for Reiser4.

It could be made even easier than that -- if Reiser4 is really so
self-contained, it could be a whole separate set of modules, distributed
on its own.  Most gamers have to be content with doing something similar
with the nvidia drivers -- for different reasons (licensing) but with
the same results.  I know Gentoo handles this automatically (emerge
nvidia-kernel).

Hmm, maybe it makes it a pain to have it as a root filesystem, so that
really needs distro support.  And yet, we have a whole system designed
specifically for being able to load modules and tweak settings before
the root FS is available.  It's called initrd, or more recently,
initramfs.  I use an old-style initrd on this box, because my root FS is
on an nvidia RAID, so I have to run a program called "dmraid" before I
mount my root FS -- it's really trivial for me to have Reiser4 as a
module, and I do, despite it being a root FS.

I suspect that, all technical, political, and "mine is bigger" arguments
aside, being available as a root FS of a distro, especially a default
FS, would go a long way towards inclusion in the kernel.  So all you
have to do is find a reasonably popular and friendly distro, with people
who are (for the moment) easier to deal with than kernel people.

Most people, if they even know what a filesystem or a kernel is, still
won't bother compiling their own kernel, you're right.  But that means
they are more likely to be using a distro-patched kernel than a stock,
vanilla one.

Is this enough to be "in the jukebox", Hans?

Of course, it's odd that I mention Gentoo, the Gentoo people (as a rule)
hate ReiserFS, but there are far more distros than there are popular
kernel forks.  I'm sure someone will be interested.

That's assuming that making further changes (putting stuff in the VFS)
is out of the question (for now).


--------------enig8221BD0B50F43671F10ACC78
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRMukv3gHNmZLgCUhAQrPnA//YLY9OzgTjKOTKJyRL+0LybpycvkTY7SD
SRPoLMqlBILU4LIn7U3ax3MWBA//KFAIVJ42X3tYVD2EaZGHAOVKYukZYt6Kf2UX
/mvX8+ovnY703Zb0MrHBGbbQ6SklFOp8sPZvwLO3eg9ko08ZsNV+xIUAk8ewe0yO
ccCJrDlswlOT4ARgg57K3Wfn1xoRrkc02VuFWwACs/wtilt1ScVP4lfkC+DWkIp8
DSVjtCrp4wNOx+6ZlIq9MetPRwRwGzPpX449x0nlfXal0zyyx9SLl3K6P0bM9FEK
J5EbytupN/jMH30gmMKqiZumjlnYm/dnnTHiza8NbGK27Qru2VtGfuM+7Ne/wPhf
7r0sqAtZBxjmygaVRa2wLDB8EX+GpA5zBQ8SjdGcahmHiwZQmupAWL20ciw11ONW
h0Hm766yZRH46OxHFgXQjqCcF7ykL8e2+HHWc23Fn78xFW+FigZvLYzVlYt9GNH3
pPrFYDmZJQtU+RX188uRJZZGsAqmOaC4Swi1VPG566S2cUs+k4HjAGo5kxdvss+n
LyNSbegZGJNnyhYuwjz4Nb3XtzADeG2twqp9GIkkF4kwc1H7mi8qiwfK97r+kgth
5EkZQKxonAu4DASi4c2GQN4j9vfJLAnMeJNnwxLNsiSGjd09MhUOZsF2Aj2ea3vX
uSNnOlCbLJM=
=X/Jt
-----END PGP SIGNATURE-----

--------------enig8221BD0B50F43671F10ACC78--
