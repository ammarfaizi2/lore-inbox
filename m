Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263973AbUDQORl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 10:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263735AbUDQORl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 10:17:41 -0400
Received: from dialin-212-144-166-090.arcor-ip.net ([212.144.166.90]:45512
	"EHLO karin.de.interearth.com") by vger.kernel.org with ESMTP
	id S263990AbUDQORi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 10:17:38 -0400
Subject: Re: NFS and kernel 2.6.x
From: Daniel Egger <degger@fhm.edu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1082179464.3012.2.camel@lade.trondhjem.org>
References: <20040416011401.GD18329@widomaker.com>
	 <1082079061.7141.85.camel@lade.trondhjem.org>
	 <20040415185355.1674115b.akpm@osdl.org>
	 <1082084048.7141.142.camel@lade.trondhjem.org>
	 <20040416045924.GA4870@linuxace.com>
	 <1082093346.7141.159.camel@lade.trondhjem.org>
	 <20040416144433.GE2253@logos.cnet>  <408001E6.7020001@treblig.org>
	 <1082132015.2581.30.camel@lade.trondhjem.org>
	 <5FF89D68-8FD9-11D8-988A-000A958E35DC@fhm.edu>
	 <1082179464.3012.2.camel@lade.trondhjem.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-UZhwYHiPEInvEd3gq1qQ"
Message-Id: <1082211307.4274.29.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 17 Apr 2004 16:15:07 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UZhwYHiPEInvEd3gq1qQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-04-17 at 07:24, Trond Myklebust wrote:

> > Great you want to help here. So I've a system which is NFS root using a
> > 3c940 gigabit onboard NIC on kernel 2.6.5 and which is dead fish in the
> > water somewhere in between 10 seconds and 5 minutes after boot using
> > NFS over UDP. The last thing I see are 3 or 4 messages of the type:

> ...and if you use TCP?

My bad, I got confused; with TCP I get the hangs, with UDP the data
corruption. Unfortunately it doesn't want to hang for me me right now.
:( ...

> > server 192.168.11.2 not responding, still trying

> The other thing I'd need is a tcpdump. Something like "tcpdump -s 9000
> -w dump.out"...

but I have two different tasty cases of data corruption using NFS over
UDP traced for you which I'll send you in private. The first one
corrupts init so that it segfaults, the second one probably crashes the
rc starter to that I'm left with an unusable getty login on console.

I'll try to get the TCP problems traced as well but right now I don't
have the time to wait....

--=20
Servus,
       Daniel

--=-UZhwYHiPEInvEd3gq1qQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQEVAwUAQIE76jBkNMiD99JrAQJpCggAn8KafG6gptPVjwl88v3gFzbk69m+wrd/
k5MObKzX1195CU9K18OeLpe+Jrwh5qH6UNPJz6cViM88BzvPvJlYtXz5EjVgQzaT
ZRYWpoYbcXkhyhE0tsNZKcednxH1KmlBR5t/L3bqMaMsnknq2rY+2bdxDZ1BbaK5
eqjWdr+I8OODzLgxS2kexlsRTbYlFfw1eQ4O5Hu+T1LlXxkLHMQS4Bc2OUxwaagN
f8uXnlcrYVuny9zTX17BJuwxMl6SpvB5RlrWkxXDhPp/R5NKVwpEYXL6u5xZYWWD
5rpWJOmJ6RXTWMcE0FTb73FJgwnvEdpwRWVSK0bOo1m6lcDAODSaeQ==
=XePI
-----END PGP SIGNATURE-----

--=-UZhwYHiPEInvEd3gq1qQ--

