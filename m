Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265894AbSLXWBo>; Tue, 24 Dec 2002 17:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265898AbSLXWBn>; Tue, 24 Dec 2002 17:01:43 -0500
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:55546 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S265894AbSLXWBm>; Tue, 24 Dec 2002 17:01:42 -0500
Date: Tue, 24 Dec 2002 14:09:37 -0800
From: Joshua Kwan <joshk@mspencer.net>
To: "Randy S." <hey_randy@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nForce2 chipset and agpgart: unsupported bridge?
Message-Id: <20021224140937.75f1fffd.joshk@mspencer.net>
In-Reply-To: <F178vHerWJncooYw6zX00012563@hotmail.com>
References: <F178vHerWJncooYw6zX00012563@hotmail.com>
X-Mailer: Sylpheed version 0.8.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.KlKDfXD8.FrMR1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.KlKDfXD8.FrMR1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The way I know it you must first of all build the nvagp modules
downloadable from nVidia's web site and use those instead of agpgart.
However, the snafu is that you must have an nVidia video card to go
along with it (or use the on-chipset crap video card.) So you're SOL i
think, at least until nvidia gets a bit less selfish.

-Josh

Rabid cheeseburgers forced "Randy S." <hey_randy@hotmail.com> to write
this on Tue, 24 Dec 2002 16:21:37 -0500:	

> Hi folks,
> 
>   I recently acquired a motherboard with an NVidia nForce 2 chipset
>   (more 
> specifically, its a Chaintech CT-7NJS). I have a Radeon 9700PRO video
> card that I'm running in this machine.  I've got integrated
> networking, sound, XFree86, etc. working, but am having trouble
> getting 3D acceleration to work.
> 
>    My kernel is 2.4.19.  Agpgart does not appear to be able to detect
>    the 
> nForce 2 chipset's bridge. There is no vendor entry for nvidia at all,
> actually -- otherwise I might have gotten by with
> agp_try_unsupported=1.
> 
>    Has anyone written nForce2 support for agp? Is so, where can I find
>    the 
> source?   I found drivers for the nvidia IGP (which I don't have), but
> not for agpgart itself at the nvidia site.  If I find the source, I
> believe I'll have to merge it manually since the 3D driver for Radeon
> 9700 (fglrx) includes a modified agpgart_be.c.
> 
>     If this is not a new question, my apologies -- I couldn't find an
>     answer 
> anywhere in the archives.
> 
>    Please CC me directly on any reply, as I'm not currently
>    subscribed.
> 
> Thanks!
>    Randy Sharo
>    hey_randy@hotmail.com
> 
> 
> _________________________________________________________________
> MSN 8: advanced junk mail protection and 3 months FREE*. 
> http://join.msn.com/?page=features/junkmail&xAPID=42&PS=47575&PI=7324&DI=7474&SU=
> http://www.hotmail.msn.com/cgi-bin/getmsg&HL=1216hotmailtaglines_advancedjmf_3mf
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Joshua Kwan
joshk@mspencer.net
pgp public key at http://joshk.mspencer.net/pubkey_gpg.asc
 
(13:59:00) Ted: my english teacher isn't all that smart when it comes to
telling the fruit of labor from that of the rectum

"oh that's right! I'm not deleting a bob anymore, i'm deleting a duck!" 
-vivek

--=.KlKDfXD8.FrMR1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+CNsj6TRUxq22Mx4RAl+OAJ9FY2IZGspp/9kVOAbKnlt0pGYH4gCfbSNA
56gv6HrumZQBr5K0UzQzMAQ=
=2gSv
-----END PGP SIGNATURE-----

--=.KlKDfXD8.FrMR1--
