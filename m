Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbVAMWZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbVAMWZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 17:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbVAMWYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 17:24:20 -0500
Received: from grendel.firewall.com ([66.28.58.176]:2466 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id S261790AbVAMWWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 17:22:01 -0500
Date: Thu, 13 Jan 2005 23:21:55 +0100
From: Marek Habersack <grendel@caudium.net>
To: Dave Jones <davej@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Wright <chrisw@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
       akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
Message-ID: <20050113222155.GB9481@beowulf.thanes.org>
Reply-To: grendel@caudium.net
References: <20050112174203.GA691@logos.cnet> <1105627541.4624.24.camel@localhost.localdomain> <20050113194246.GC24970@beowulf.thanes.org> <20050113115004.Z24171@build.pdx.osdl.net> <20050113202905.GD24970@beowulf.thanes.org> <1105645267.4644.112.camel@localhost.localdomain> <20050113210229.GG24970@beowulf.thanes.org> <20050113213002.GI3555@redhat.com> <20050113214814.GA9481@beowulf.thanes.org> <20050113220652.GJ3555@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Content-Disposition: inline
In-Reply-To: <20050113220652.GJ3555@redhat.com>
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 13, 2005 at 05:06:52PM -0500, Dave Jones scribbled:
> On Thu, Jan 13, 2005 at 10:48:14PM +0100, Marek Habersack wrote:
> =20
>  > > If admins don't install updates in a timely manner, there's
>  > > not a lot we can do about it.  For those that _do_ however,
>  > > we can make their lives a lot more stress free.
>  > Indeed, but what does have it to do with a closed disclosure list?=20
>=20
> For the N'th time, it gives vendors a chance to have packages
> ready at the time of disclosure.
I've heard that N times, too. I'm just failing to see that this justifies
the existence of that list and that's why I'm asking for other arguments.

>  > With open
>  > disclosure list you provide a set of fixes right away, the admins take=
 them
>  > and apply. With closed list you do the same, but with a delay (which g=
ives
>  > an opportunity for a "race condition" with the bad guys, one could arg=
ue).
>  > So, what's the advantage of the delayed disclosure?
>=20
> Not having to panic and rush out releases on day of disclosure.
Releasing it a month later doesn't remove the rush and panic of the _users_
who are paniced and rush to install the freshly released kernels.

> Not having users vulnerable whilst packages build/get QA/get pushed to mi=
rrors.
They are vulnerable all the time since the "internal" disclosure to the
public one. What makes you think that keeping things secret on the list
won't allow the bad guys to discover the vulnerability? As Linus said, they
are probably _more_ motivated than the good guys.

> Users of kernel.org kernels get to build and boot in under an hour.
> Vendor kernels take a lot longer to build.
Come on, it's just a matter of throwing in more hardware to that process.

> 1- More architectures.
>    (And trust me, there's nothing I'd like more than to be able
> 	to increase the speed of kernel builds on some of the architectures
> 	we support).
I realize that. In Debian we support a few very slow architectures. But,
let's not fool ourselves, the slow architectures aren't nearly as popular as
x86 or x86_64, ppc.

> 2- More generic, ie more modules to build.
If speed is an issue, I guess a vendor can afford getting 5 ARM/m68k/8086
(:) machines and distribute the build across them.

> In the case of public disclosure of issues that we weren't aware of,
> it's a miracle that we get update kernels out on day of disclosure
> in some cases. (In others, we don't, and the same applies to other vendor=
s too)
Looking from the vendor point of view, you are perfectly right. Looking from
the user point of view, the user is as exposed with the closed list and new
vendor kernels released as with the open list and immediate disclosures. In
both cases it's a sort of a miracle for a user not to be hacked. Remember
the recent php problem? Before we knew, many, many, many sites were hacked -
even though the release with fixes was out. I don't know whether those
vulnerabilities were known to vendor-sec before that but if they were, the
delay didn't do a thing to make the situation better. Simply, no difference
- as far as I am concerned, the only argument so far for the existence of
the totally closed list is that "vendors must have time to build
kernels/software", as you wrote above. Not nearly enough of a reason, IMHO.

regards,

marek

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB5vSDq3909GIf5uoRAltjAJ4n9t+jFKFtNAlZGhg+Qq0u+VUEZQCdFhul
QQkpsoBYEm8UBEKm6638rW8=
=L83d
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
