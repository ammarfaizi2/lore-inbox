Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWBKVmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWBKVmT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 16:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbWBKVmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 16:42:19 -0500
Received: from natblindhugh.rzone.de ([81.169.145.175]:46211 "EHLO
	natblindhugh.rzone.de") by vger.kernel.org with ESMTP
	id S1750721AbWBKVmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 16:42:18 -0500
Date: Sat, 11 Feb 2006 22:42:07 +0100
From: Nico Golde <nico@ngolde.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Getting cpu frequency
Message-ID: <20060211214207.GB19045@ngolde.de>
References: <20060211204733.GA7813@ngolde.de> <20060211213748.GD8337@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline
In-Reply-To: <20060211213748.GD8337@redhat.com>
X-Editor: VIM - Vi IMproved 6.4 (2005 Oct 15, compiled Jan 15 2006 19:02:40)
X-Mailer: Mutt-ng http://www.muttng.org
X-Operating-System: Debian GNU/Linux sid
X-My-Homepage: http://www.ngolde.de
User-Agent: mutt-ng/devel-r556 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hallo Dave,

* Dave Jones <davej@redhat.com> [2006-02-11 22:38]:
> On Sat, Feb 11, 2006 at 09:47:34PM +0100, Nico Golde wrote:
>  > Hi,
>  > at the moment I try to get the current cpu frequency via=20
>  > using the cpufreq_get() function defined in linux/cpufreq.h.
>  > Can someone point me to the headers I have to include to let=20
>  > this work because just doing #include <linux/cpufreq.h>=20
>  > results in a bunch of errors:
>  > [...]=20
>  > In file included from /usr/include/linux/cpu.h:22,
>  >                  from cpu.c:2:
>  > /usr/include/linux/sysdev.h:31: error: field 'drivers' has incomplete =
type
>  > /usr/include/linux/sysdev.h:35: error: syntax error before 'pm_message=
_t'
>  > /usr/include/linux/sysdev.h:37: error: field 'kset' has incomplete type
>  > /usr/include/linux/sysdev.h:50: error: field 'entry' has incomplete ty=
pe
>  > /usr/include/linux/sysdev.h:54: error: syntax error before 'pm_message=
_t'
>  > /usr/include/linux/sysdev.h:69: error: syntax error before 'u32'
>  > /usr/include/linux/sysdev.h:72: error: syntax error before '}' token
>  > /usr/include/linux/sysdev.h:79: error: field 'attr' has incomplete type
>  > /usr/include/linux/sysdev.h:80: error: syntax error before 'ssize_
>  > [...]=20
>  > Using 2.6.14.
>  > Regards Nico
>  > P.S. Please CC me, I am not subsribed, thanks
>=20
> Are you trying to do this from a userspace program ?
> If so, this isn't going to work.

Yes I am.
Regards Nico
--=20
Nico Golde - JAB: nion@jabber.ccc.de | GPG: 0x73647CFF
http://www.ngolde.de | http://www.muttng.org | http://grml.org
Forget about that mouse with 3/4/5 buttons -
gimme a keyboard with 103/104/105 keys!

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD7lovHYflSXNkfP8RAntIAJ47p501VVJsJiT2LuS/ZvxdO0vfkACeKvSI
DzAUT1SN+UcloyZBu/oPxSQ=
=ZPbQ
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
