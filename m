Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751062AbVK0ODs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbVK0ODs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 09:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbVK0ODr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 09:03:47 -0500
Received: from mx01.qsc.de ([213.148.129.14]:46757 "EHLO mx01.qsc.de")
	by vger.kernel.org with ESMTP id S1751046AbVK0ODr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 09:03:47 -0500
From: =?iso-8859-1?q?Ren=E9_Rebe?= <rene@exactcode.de>
Organization: ExactCode
To: Andi Kleen <ak@suse.de>
Subject: Re: [discuss] Re: [PATCH] x86_64: Test patch for ATI/Nvidia timer problems
Date: Sun, 27 Nov 2005 15:02:13 +0100
User-Agent: KMail/1.8.3
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
References: <20051126142030.GA26449@wotan.suse.de> <200511271014.53217.rene@exactcode.de> <20051127135325.GG20775@brahms.suse.de>
In-Reply-To: <20051127135325.GG20775@brahms.suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1400078.ouVilVr8vj";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200511271502.18782.rene@exactcode.de>
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "grum.localhost", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, On Sunday 27 November 2005 14:53, Andi Kleen wrote:
	> On Sun, Nov 27, 2005 at 10:14:53AM +0100, Ren? Rebe wrote: > > Hi, > >
	> > On Saturday 26 November 2005 15:20, Andi Kleen wrote: > > >
	Everybody who saw timing problems with ATI IXP based boards with x86-64
	> > > or some Nvidia NForce4 boards please test this patch. Please send
	> > > success/failure to me. > > > > I try to give your patch a try on
	the ATI based MSI Megabook S270, today - > > however even with the
	workaround of "noapic" I had timer drift on resuem from > > ram if the
	cpu was scaled to a lower frequency when it was suspended. > > But it
	worked properly before suspend/resume without noapic? [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1400078.ouVilVr8vj
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sunday 27 November 2005 14:53, Andi Kleen wrote:
> On Sun, Nov 27, 2005 at 10:14:53AM +0100, Ren? Rebe wrote:
> > Hi,
> >=20
> > On Saturday 26 November 2005 15:20, Andi Kleen wrote:
> > > Everybody who saw timing problems with ATI IXP based boards with x86-=
64
> > > or some Nvidia NForce4 boards please test this patch. Please send
> > > success/failure to me.
> >=20
> > I try to give your patch a try on the ATI based MSI Megabook S270, toda=
y -=20
> > however even with the workaround of "noapic" I had timer drift on resue=
m from=20
> > ram if the cpu was scaled to a lower frequency when it was suspended.
>=20
> But it worked properly before suspend/resume without noapic?=20

Without noapic the timer has about the 2x speed compared to real-time. I
only used the machien with noapic since otherwise it is barely useful.

Did you want to know if suspend/resume does behave differently without noap=
ic?

Yours,

=2D-=20
Ren=E9 Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://www.exactcode.de | http://www.t2-project.org
            +49 (0)30  255 897 45

--nextPart1400078.ouVilVr8vj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDibxqQuICExGFvYIRAqDMAJ4l7LVCG0cUpa7qPocOWYjSUogqfQCaA6ws
OaYHw+DzKn1Gc/bvxUWhl3w=
=99s4
-----END PGP SIGNATURE-----

--nextPart1400078.ouVilVr8vj--
