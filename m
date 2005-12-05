Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbVLEPQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbVLEPQW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 10:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbVLEPQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 10:16:22 -0500
Received: from mx01.qsc.de ([213.148.129.14]:14738 "EHLO mx01.qsc.de")
	by vger.kernel.org with ESMTP id S932439AbVLEPQV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 10:16:21 -0500
From: =?iso-8859-1?q?Ren=E9_Rebe?= <rene@exactcode.de>
Organization: ExactCode
To: Andi Kleen <ak@suse.de>
Subject: Re: [discuss] Re: [PATCH] x86_64: Test patch for ATI/Nvidia timer problems
Date: Mon, 5 Dec 2005 16:14:48 +0100
User-Agent: KMail/1.8.3
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
References: <20051126142030.GA26449@wotan.suse.de> <200511271502.18782.rene@exactcode.de> <20051127141155.GI20775@brahms.suse.de>
In-Reply-To: <20051127141155.GI20775@brahms.suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1232762.cV4Td8U7uQ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200512051614.52620.rene@exactcode.de>
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "grum.localhost", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, On Sunday 27 November 2005 15:11, Andi Kleen wrote:
	> > > But it worked properly before suspend/resume without noapic? > > >
	> Without noapic the timer has about the 2x speed compared to real-time.
	I > > only used the machien with noapic since otherwise it is barely
	useful. > > It has that still with the patch applied? The patch was
	supposed > to fix that at least part of that problem on ATI systems >
	(there seems to be also a timer miscalibration problem on some other >
	laptops) [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1232762.cV4Td8U7uQ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sunday 27 November 2005 15:11, Andi Kleen wrote:

> > > But it worked properly before suspend/resume without noapic?=20
> >=20
> > Without noapic the timer has about the 2x speed compared to real-time. I
> > only used the machien with noapic since otherwise it is barely useful.
>=20
> It has that still with the patch applied? The patch was supposed
> to fix that at least part of that problem on ATI systems
> (there seems to be also a timer miscalibration problem on some other
> laptops)=20

Sorry for the late reply, just too much to do ... It appears my MSI Megabook
S270 with Ati chipset and AMD Turion freezes on boot with your patch applied
to 2.6.14.2 after the io schedulers are registered. Without the patch it bo=
ots
up fine.

Yours,

=2D-=20
Ren=E9 Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://www.exactcode.de | http://www.t2-project.org
            +49 (0)30  255 897 45

--nextPart1232762.cV4Td8U7uQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDlFlsQuICExGFvYIRAse7AJ4+bY0aA8ENvrnJWR5JwWhS6eO9CACfXDW6
GFDUSos+SbnmWfO9JQrV3OI=
=G+Hh
-----END PGP SIGNATURE-----

--nextPart1232762.cV4Td8U7uQ--
