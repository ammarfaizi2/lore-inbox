Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318652AbSH1EG2>; Wed, 28 Aug 2002 00:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318661AbSH1EG2>; Wed, 28 Aug 2002 00:06:28 -0400
Received: from ppp-217-133-221-76.dialup.tiscali.it ([217.133.221.76]:42160
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S318652AbSH1EG1>; Wed, 28 Aug 2002 00:06:27 -0400
Subject: Re: Bug in kernel code?
From: Luca Barbieri <ldb@ldb.ods.org>
To: "David S. Miller" <davem@redhat.com>
Cc: s.biggs@softier.com, Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20020827.205830.72711261.davem@redhat.com>
References: <3D6BD62C.581.ACEBAD@localhost>
	<20020827.203946.102043898.davem@redhat.com> <1030507070.1489.32.camel@ldb>
	 <20020827.205830.72711261.davem@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-y3wO670QWBskQY8MiHon"
X-Mailer: Ximian Evolution 1.0.5 
Date: 28 Aug 2002 06:10:39 +0200
Message-Id: <1030507839.1547.36.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-y3wO670QWBskQY8MiHon
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2002-08-28 at 05:58, David S. Miller wrote:
>    From: Luca Barbieri <ldb@ldb.ods.org>
>    Date: 28 Aug 2002 05:57:50 +0200
> 
>    On Wed, 2002-08-28 at 05:39, David S. Miller wrote:
>    > Realistically possible with any known configuration?
> 
>    How about replacing the loop with ffs/__ffs that would be more
>    elegant, shorter and avoid any problem or doubt?
>    
> This is getting rediculious.  You can pursue this further
> if you want, but I think we've wasted enough time with
> this non-bug.
> 
> Who is getting bootup failures due to this problem?
> Answer: nobody
I'm not saying that it's serious bug, just that using __ffs is more
appropriate than reimplementing it incorrectly and inefficiently.


--=-y3wO670QWBskQY8MiHon
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9bE0+djkty3ft5+cRAgxWAKDA4r8BVs7M6hzbQ3SrSHxrT3LVjgCeO4Ui
xenagLl7LNYYnZtgzA/wEEY=
=faZR
-----END PGP SIGNATURE-----

--=-y3wO670QWBskQY8MiHon--
