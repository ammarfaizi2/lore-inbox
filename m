Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264550AbUFSRC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264550AbUFSRC4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 13:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264515AbUFSRCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 13:02:42 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:38327 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S264639AbUFSQ47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 12:56:59 -0400
Subject: Re: [sundance] Known problems?
From: Ian Kumlien <pomac@vapor.com>
To: Andre Tomt <andre@tomt.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40D46220.9030806@tomt.net>
References: <1087650302.2971.44.camel@big>  <40D43E26.7060207@tomt.net>
	 <1087651887.2971.47.camel@big>  <40D46220.9030806@tomt.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-TpBfNjnFHbcMKs/WImeS"
Message-Id: <1087664191.2971.66.camel@big>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 19 Jun 2004 18:56:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TpBfNjnFHbcMKs/WImeS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-06-19 at 17:56, Andre Tomt wrote:
> If you don't know what it is, you most likely aren't using it. I'm not=20
> avare of any distributions having it applied. It's used for combinding=20
> several network packet queues into one for example.

          RX packets:26633293 errors:0 dropped:672 overruns:0 frame:0
          TX packets:10031287 errors:132 dropped:3960 overruns:0
carrier:0

To my knowledge all those drops was yesterday during a 2 hour period..
This is a local switched lan with flowcontrol enabled.
Couldn't this be tx getting nuts due to delays that rx packets causes?

Thus:
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, TxStatus 00 TxFrameId 14, resetting...

Anyways, something is wrong... but i assume it could be pci related:
  5:   43355556          XT-PIC  eth0
 10:   19987656          XT-PIC  aic7xxx, eth3
---
LOC:  143364244
ERR:     406517
---

Any clues?

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-TpBfNjnFHbcMKs/WImeS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA1HA/7F3Euyc51N8RAvXMAJ9HdC/Qo7TjkPfZRbndsjSK0jhT5gCeMV+3
90T1e607JyhHc2IuOyV/aME=
=mmgW
-----END PGP SIGNATURE-----

--=-TpBfNjnFHbcMKs/WImeS--

