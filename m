Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWEEFD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWEEFD3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 01:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWEEFD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 01:03:29 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:718 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932467AbWEEFD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 01:03:28 -0400
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: Linux 2.6.16.14
Date: Fri, 5 May 2006 15:02:47 +1000
User-Agent: KMail/1.9.1
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       stable@kernel.org, torvalds@osdl.org
References: <20060505003526.GW24291@moss.sous-sol.org> <200605051303.37130.ncunningham@cyclades.com> <20060505045003.GD11191@w.ods.org>
In-Reply-To: <20060505045003.GD11191@w.ods.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1926177.GbuW3aInak";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200605051502.53481.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1926177.GbuW3aInak
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Willy.

On Friday 05 May 2006 14:50, Willy Tarreau wrote:
> Hi Nigel,
>
> On Fri, May 05, 2006 at 01:03:31PM +1000, Nigel Cunningham wrote:
> > Hi.
> >
> > On Friday 05 May 2006 12:33, Chris Wright wrote:
> > > * Nigel Cunningham (ncunningham@cyclades.com) wrote:
> > > > Is this supposed to be some sort of subtle pressure on Linus to open
> > > > 2.7?
> > >
> > > He does every couple months and leaves it open for a few weeks.
> > > Then, just to keep us guessing, he releases it with a 2.6 name ;-)
> > >
> > > Actually, I think the system is working quite well.  We've got a quick
> > > route for getting bug fixes and security fixes to users, and a shorter
> > > devel cycle helping distro folks get more regular drops from upstream.
> > > This particular patch applies all the way back to the beginning of git
> > > time (over a year ago), and I'm sure earlier.  So it's hard to conclu=
de
> > > it's a byproduct of the release cycles.
> > >
> > :) Tongue was firmly in cheek. I guess I should have said more initiall=
y.
> > : It
> >
> > wasn't so much the patch, as the speed with which they're coming. It
> > makes me (at least) feel like the stable series is unstable. Couldn't y=
ou
> > store them up for a day or two at a time (unless of course they really
> > are that important that they require a quicker cycle).
>
> I don't agree with your analysis at all. Quite the opposite in fact. I'm
> amazed that Chris & Greg manage to update so often. Right now, you can be
> confident that there's always an *official* kernel version which fixes a
> few days-old vulnerability. I'd like to be that fast to provide 2.4
> hotfixes (I still have one fix pending).
>
> The enormous advantage of releasing lots of small updates is that people
> just have to choose when they want to update. If you're not affected by
> the SMB vulnerability, don't upgrade. That's that simple. It makes it
> much easier to class bug reports (eg: the last one on speedstep which
> "appeared" in 2.6.16.13 and not 2.6.16.12 while no such code has changed).
> Sometimes, a config option will have changed on the user side, or a gcc
> update will have been performed which might explain a new bug which we
> can be certain does not come from the source.
>
> What might be interesting with this release cycle would be to work on
> hot-patching. There has already been such things in the past with modules
> which patched some functions. It would avoid a full compile and a reboot
> in some circumstances.
>
> That said, kudos to Chris and Greg for their excellent work ! Please
> don't change.
>
> > Regards,
> >
> > Nigel
>
> Regards,
> Willy

Thanks for your email. I can certainly see the validity of the points you=20
make - I guess it just goes to prove that there is often more than one way =
of=20
looking at things :)

I didn't mention it previously - I guess because it was subconscious - but =
I'm=20
looking at things from the point of view of someone maintaining an=20
out-of-tree patch. With almost all of these revisions, my patch continues t=
o=20
apply cleanly, but I still get people asking "Is the patch for 2.6.16.9" sa=
fe=20
to apply against "2.6.16.9+x"? I simply don't have the time to continually=
=20
test and check, but I end up feeling like there's a new 2.6.x release=20
everyday that I just have to keep up with, because that's what the stable=20
users want. Maybe it just proves that I should hurry up and get the git tre=
e=20
finished so I get try to get Suspend2 merged :)

Regards,

Nigel

--nextPart1926177.GbuW3aInak
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEWtx9N0y+n1M3mo0RAoBlAJ9BIqoFKqvT8tZm9+/Cb+Sd5hRfhgCcCnoG
of8WnocK3AyZoNUK1FVJPOg=
=uCwc
-----END PGP SIGNATURE-----

--nextPart1926177.GbuW3aInak--
