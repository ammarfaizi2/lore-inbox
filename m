Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265053AbTLMW2l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 17:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265279AbTLMW2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 17:28:41 -0500
Received: from c-130372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.19]:8609
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S265053AbTLMW2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 17:28:37 -0500
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
From: Ian Kumlien <pomac@vapor.com>
To: ross@datscreative.com.au
Cc: Jesse Allen <the3dfxdude@hotmail.com>, linux-kernel@vger.kernel.org,
       AMartin@nvidia.com
In-Reply-To: <200312140407.28580.ross@datscreative.com.au>
References: <200312140407.28580.ross@datscreative.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-qa/Jv4ZXdpVkAhkfCGbW"
Message-Id: <1071354516.2634.3.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 13 Dec 2003 23:28:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qa/Jv4ZXdpVkAhkfCGbW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-12-13 at 19:07, Ross Dickson wrote:
> ..APIC TIMER ack delay, reload:16701, safe:16691

calibrating APIC timer ...
..... CPU clock speed is 2079.0146 MHz.
..... host bus clock speed is 332.0663 MHz.
NET: Registered protocol family 16
..APIC TIMER ack delay, reload:20791, safe:20779
..APIC TIMER ack delay, predelay count: 20769
..APIC TIMER ack delay, predelay count: 20786
..APIC TIMER ack delay, predelay count: 20716
..APIC TIMER ack delay, predelay count: 20731
..APIC TIMER ack delay, predelay count: 20747
..APIC TIMER ack delay, predelay count: 20762
..APIC TIMER ack delay, predelay count: 20780
..APIC TIMER ack delay, predelay count: 20729
..APIC TIMER ack delay, predelay count: 20740
..APIC TIMER ack delay, predelay count: 20757
---

Survived my greptest which no non patched kernel has ever done on this
machine.

Has anyone got that extended ringbuffer to work? I haven't been able to
get a complete "boot" dmesg in ages because of all the output all the
drivers make... Does it need a updated dmesg?
(I mean, is this like the non updated gnome-terminal in mdk 9.1 that
deadlocks on 2.6 if you run some ncurces apps in a "larger than usual"
window?)

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-qa/Jv4ZXdpVkAhkfCGbW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/25KU7F3Euyc51N8RAl4uAJ9vHT3ZMYTTPgoAui7qHXOHfl7eRwCgtC+G
U9d+IfDIRnMvCJ6/YR56yE8=
=KRFF
-----END PGP SIGNATURE-----

--=-qa/Jv4ZXdpVkAhkfCGbW--

