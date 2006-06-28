Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751757AbWF1XGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbWF1XGl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 19:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751759AbWF1XGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 19:06:41 -0400
Received: from smeltpunt.science.ru.nl ([131.174.16.145]:28875 "EHLO
	smeltpunt.science.ru.nl") by vger.kernel.org with ESMTP
	id S1751757AbWF1XGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 19:06:40 -0400
From: Sebastian =?iso-8859-1?q?K=FCgler?= <sebas@kde.org>
Organization: K Desktop Environment
To: Pavel Machek <pavel@suse.cz>
Subject: Re: swsusp / suspend2 reliability (was Re: [Suspend2-devel] Re: Suspend2 - Request for review & inclusion =?iso-8859-1?q?in=09-mm?=)
Date: Thu, 29 Jun 2006 01:06:12 +0200
User-Agent: KMail/1.9.3
Cc: suspend2-devel@lists.suspend2.net,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
References: <200606270147.16501.ncunningham@linuxmail.org> <200606290038.01733.sebas@kde.org> <20060628224625.GD27526@elf.ucw.cz>
In-Reply-To: <20060628224625.GD27526@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart9372121.26p4P2i9LO";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606290106.13828.sebas@kde.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart9372121.26p4P2i9LO
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 29 June 2006 00:46, Pavel Machek wrote:
> On Thu 2006-06-29 00:37:57, Sebastian K=FCgler wrote:
> > On Thursday 29 June 2006 00:24, Pavel Machek wrote:
> > > > > Okay, can I get some details? Like how much memory does system
> > > > > have, what stress test causes the failure?
> > > >
> > > > The machine has 1GB of RAM, filling it up beyond 500MB, maybe 600MB
> > > > usually made swsusp a problem. I'd need to close apps then to be ab=
le
> > > > to suspend.
> > >
> > > I'm pretty sure I do suspending with most of RAM full. You have
> > > big-enough swap partition, right?
> >
> > 1 GB, it might not be completely empty though. I probably only hit swsu=
sp
> > limit much earlier than suspend2's (which after 34 suspend/resume cycles
> > and heavy use in between I did not hit yet).

I'll try to see what I can do, it might take some time though. Quite busy a=
t=20
the moment and preparing for vacation, lucky me. :-)

And to be honest, since suspend2 works perfectly well here, it's not extrem=
ely=20
high on my list of priorities (talking about scratching an itch), swsusp ju=
st=20
misses too much stuff I heavily rely upon, and I'm used to for years. Sad=20
enough I have to go through this again, after having helped out with testin=
g=20
suspend2 for more than three years.

> Okay, can we get bugzilla.kernel.org report? (assigned-to me)
>
> This really should not happen, and I did not see swsusp fail like that
> for quite a long time. I _could_ make it fail with make -j on kernel,
> and similar crazy loads, but on nothing reasonable.
>
> dmesg from failed run would be nice, too.
=2D-=20
sebas

 http://www.kde.org | http://vizZzion.org |  GPG Key ID: 9119 0EF9=20
=2D - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -=
 -
Nothing ever becomes real until it is experienced. - John Keats


--nextPart9372121.26p4P2i9LO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQEVAwUARKMLZWdNh9WRGQ75AQLovggAwXYmkP1bA0VJ/+e/NG4uMBwkpkhLCu00
cX0r2PzACmqaSBXmMu4LRhjB3vaAP/etjd+41bpYzlEbrj1KCthLpOlgxOzdOuvw
7kx+ZUnnENmSNzttnmSYRe3uiUqIqUq8fjHm3PhhL1kl8KV7qtOAuxeRcSTBwCyu
PU44BHu9NODmIgftJq3zwNeJMJQMu5ql/XylK7RN/1MHOQ19Yc+JQ14JT7A52IOE
NPsHMcIwWcIFTSyMIEu0E+4hCTfRqCFiYFE2/jfViRnFngKCr5dUnhLsLfNHPfz+
K3v1oURku0OvrYj3G6ciTconp+SbJznQvZ3HBM6UGiNRxBxTd6ZJtA==
=ixYB
-----END PGP SIGNATURE-----

--nextPart9372121.26p4P2i9LO--
