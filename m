Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262210AbSLTLL2>; Fri, 20 Dec 2002 06:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262258AbSLTLL2>; Fri, 20 Dec 2002 06:11:28 -0500
Received: from relay2.clb.oleane.net ([213.56.31.22]:55687 "EHLO
	relay2.clb.oleane.net") by vger.kernel.org with ESMTP
	id <S262210AbSLTLKt>; Fri, 20 Dec 2002 06:10:49 -0500
Subject: Re: Dedicated kernel bug database
From: Nicolas Mailhot <Nicolas.Mailhot@one2team.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+9asdhiDhjEIrvP97MSu"
Organization: One2team
Message-Id: <1040383130.13953.43.camel@ulysse.olympe.o2t>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-1) 
Date: 20 Dec 2002 12:18:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+9asdhiDhjEIrvP97MSu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

|John Bradford wrote:
|
|> [snip]
|>
|>Interesting - so the first stage in reporting a bug would be to select
|>the latest 2.4 and 2.5 kernels that you've noticed it in, and get a
|>list of known bugs fixed in those versions.  Also, if you'd selected
|>the maintainer, (from an automatically generated list from the
|>MAINTAINERS file), it could just search *their* changes in the changelog.
|>
|It's often difficult to pick a maintainer for a bug - it may not be the=20
|fault of a single subsystem.  As an example, I recently had a problem=20
|getting USB and network to function (on kernels 2.5.5x).  I noticed that=20
|toggling Local APIC would also toggle which of the two devices worked.=20
| Disabling ACPI allows both deviecs to function regardless of local APIC.
|
|So, where is the problem?
|1) Network driver?  It doesn't work with ACPI and both Local APIC and=20
|IO-APIC.
|2) USB driver?  It doesn't work with ACPI and no UP APIC.
|3) APIC?  Causes weird problems with various drivers when ACPI is turned o=
n.
|4) ACPI?  Causes weird problems with various drivers when APIC is toggled.
|
|(this exact bug was in Bugzilla, though I hadn't checked there before=20
|mailing lkml ;)


I assume you're talking about :
http://bugzilla.kernel.org/show_bug.cgi?id=3D10

As the reporter, I'll tell you plainly bugzilla rocks for this.

This bug was first reported in linux-kernel, then was picked in the 2.5 pro=
blem=20
reports, then (when bugzilla.kernel.org) was announced reported again in=20
bugzilla.

Bugzilla enabled the report to be ping-ponged among maintainers until someo=
ne=20
accepted it. And it can be found by other people now (note you missed the l=
inux=20
kernel  report when you posted this). No one was interested before the bugz=
illa
report.

Bugzilla can be a pain sometimes, it's not intuitive, it's suffering yet fr=
om its
hackish bastard origin, but it works, lots of projects are using it (both b=
ecause
its so easy to deploy and people are familiar with it - try rt
I-need-30+-perl-packages-to-work-only-I-use hell for example) and it's impr=
oving.

2.17.1 (seen both at http://bugzilla.mozilla.org/ and http://bugzilla.redha=
t.com/)
is a *huge* improvement, I can't wait for it to be released for everyone (r=
ight now
the bugzilla team has a hard time integrating all the features everyone and=
 his dog
have been contributing back to the project lately).

All bugzilla's I've seen so far would benefit from better version tracking.
All bugzilla's I've seen so far would benefit from better UI.

The problems raised in this thread are pretty generic. They should be tackl=
ed a generic
way in the original project.

However I wouldn't even touch any other bug reporting system. Others (like =
rt) boast a
better original design ; the truth is they have their own warts but not a c=
ommunity
the size of bugzilla to find/fix them (and I'm not even talking about secur=
ity audits).

Once you've grokked bugzilla (which I freely admit is long and painful) you=
'll find it's
actually rather powerful and you'll be trained to interact with :
- mozilla bugzilla
- kernel bugzilla
- apache bugzilla
- gnome bugzilla
- kde bugzilla
- abiword bugzilla
- red hat bugzilla

and so on (and all of these deployments have useful tweaks that trickle bac=
k in the=20
original bugzilla)

Not having to learn a new UI to report a bug in another project is quite ni=
ce. I know I'd=20
have thought twice about the feedback I've given to various organizations o=
therwise.

Regards,

--=20
Nicolas Mailhot
Not linux-kernel subscribed, sometimes reading the archives, sometimes not

--=-+9asdhiDhjEIrvP97MSu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+AvyZmsj7VFSyrYsRAg/0AJ98Ax0UWylnGPt1tbDrBi2xyjTdswCfWBDP
nJYqlRR4gSLxcx3kWEE3ecQ=
=ZBzr
-----END PGP SIGNATURE-----

--=-+9asdhiDhjEIrvP97MSu--

