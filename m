Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbWGXWZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWGXWZo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 18:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbWGXWZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 18:25:44 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:10930 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S932288AbWGXWZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 18:25:44 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.18-rc1-git] rtc-acpi, with wakeup support
Date: Tue, 25 Jul 2006 08:25:38 +1000
User-Agent: KMail/1.9.3
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Alessandro Zummo <alessandro.zummo@towertech.it>, len.brown@intel.com
References: <200607151240.51192.david-b@pacbell.net> <200607241244.36574.david-b@pacbell.net>
In-Reply-To: <200607241244.36574.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1570006.PExKOsAZMk";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607250825.42928.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1570006.PExKOsAZMk
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi David.

On Tuesday 25 July 2006 05:44, David Brownell wrote:
> Hmm, so -- any comments?  This applies just fine to RC2 of course
> (it came out minutes before RC2 "shipped").  Seems to me this would
> be appropriate for the next MM release.

Didn't notice it before now. I'll forward your message to suspend2-devel (w=
e=20
have people there who might be interested), and try it myself.

> Also, given some mechanism to tell whether this alarm woke the system,
> this would seem to be the kind of infrastructure needed to make the
> "deepening suspend" work correctly.  That is, idle system enters the
> light weight "standby" powersave mode, then if it stays idle for long
> enough for the timer to wake it could enter suspend-to-RAM (or that
> new "suspend-to-both" mode).  There's certainly enough idle time on
> most laptops for such mechanisms to help save significant amounts of
> battery power, and it's best if such things don't explicitly depend
> on features like ACPI.

Yes. I'll look at it with a view to seeing if we can use it in Suspend2. I =
get=20
requests for it from time to time, and it would be good to finally be able =
to=20
do it.

Regards,

Nigel

=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart1570006.PExKOsAZMk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBExUjmN0y+n1M3mo0RAt9cAKCtS5VAtntakv5r5LhDN5m4iZWgIwCfcLsn
D5xP52mAuTIeFKkeNeT6vbI=
=flRa
-----END PGP SIGNATURE-----

--nextPart1570006.PExKOsAZMk--
