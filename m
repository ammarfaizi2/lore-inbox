Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbVHaK3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbVHaK3I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 06:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbVHaK3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 06:29:08 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:31384 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932305AbVHaK3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 06:29:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:reply-to:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to;
        b=PLaL9Kd4rc4H3BBo9x/6ST2+hHaDf7JlQcjiaM1eKQkuFfFulq5N4EY1Z0zzA+VhAW9YYuYbkn4ckZ6vb4opxmFJ7NX56wvKpSI8vriwhwPAAUKIqvl+MtAv0tEDfj0oW9UA1BaIUBnpJTXd0MjnmA/G8mgC/woKQm9bU8J0BiY=
Date: Wed, 31 Aug 2005 12:34:09 +0200
From: Mateusz Berezecki <mateuszb@gmail.com>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Florian Weimer <fw@deneb.enyo.de>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Atheros and rt2x00 driver
Message-ID: <20050831103409.GC28280@oepkgtn.mshome.net>
Reply-To: Mateusz Berezecki <mateuszb@gmail.com>
Mail-Followup-To: Denis Vlasenko <vda@ilport.com.ua>,
	Florian Weimer <fw@deneb.enyo.de>, Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <6278d22205081711115b404a9b@mail.gmail.com> <87ll2ibkuk.fsf@mid.deneb.enyo.de> <20050831081636.GA28280@oepkgtn.mshome.net> <200508311223.35304.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hYooF8G/hrfVAmum"
Content-Disposition: inline
In-Reply-To: <200508311223.35304.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--hYooF8G/hrfVAmum
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Denis Vlasenko <vda@ilport.com.ua> wrote:
-> What it can do? In particular, can it:
-> * send packets with arbitrary contents? In particular, packets
->   shorter than 3-address 802.11 header? packets with WEP bit set?
->   Does it allow to do WEP encoding by host instead of hal?
->   Any weird limitations?
-> * receive packets?
-> * tune to the given channel (or freq)?
->=20
 =20
   I don't really know to which version you are referring to. If you
   wrote about OpenBSD then I can't give an authoritative answer.=20
  =20
-> If it can do that, everything else IIRC can be done in software.
-> Really, what prevents us from, say, beacons every 1/10s?

   Yes, that is a very nature of atheros radio chips. It is simplier to
   tell what you can't do in software with these chipsets. This
   complicates writing a driver a bit too ;-)
  =20
->=20
-> Nice to see you are in "release early" crowd.
->=20
-> http://mateusz.agrest.org/atheros/:
-> may I suggest using atheros-20050805 instead of atheros-08052005
-> (will maintain correct sorting order in 2006,2007...)

  Hummm... these are old patches :) the new site is located at

        http://www.ath-driver.org=20
=20
  As I'm going to put separate patch snapshots out there too, I will
  change the naming order.


  Mateusz
--=20
  @..@   Mateusz Berezecki=20
 (----)  mateuszb@gmail.com http://mateusz.agrest.org
( >__< ) PGP: 5F1C 86DF 89DB BFE9 899E 8CBE EB60 B7A7 43F9 5808=20
^^ ~~ ^^

--hYooF8G/hrfVAmum
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDFYehKu1H8AtEdBoRAub4AJ9m/JQtRzQT7dWQfmOsWpmqJK8VZACeNSAM
ewbWR8pMK2pQdaN20bpqvAs=
=6Ssu
-----END PGP SIGNATURE-----

--hYooF8G/hrfVAmum--

