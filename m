Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318710AbSH1E0W>; Wed, 28 Aug 2002 00:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318713AbSH1E0V>; Wed, 28 Aug 2002 00:26:21 -0400
Received: from ppp-217-133-221-76.dialup.tiscali.it ([217.133.221.76]:8866
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S318710AbSH1EZs>; Wed, 28 Aug 2002 00:25:48 -0400
Subject: Re: Bug in kernel code?
From: Luca Barbieri <ldb@ldb.ods.org>
To: "David S. Miller" <davem@redhat.com>
Cc: s.biggs@softier.com, Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20020827.210748.10907440.davem@redhat.com>
References: <1030507070.1489.32.camel@ldb>
	<20020827.205830.72711261.davem@redhat.com> <1030507839.1547.36.camel@ldb> 
	<20020827.210748.10907440.davem@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-nGlGpXBkAVm32AMDa3DW"
X-Mailer: Ximian Evolution 1.0.5 
Date: 28 Aug 2002 06:29:59 +0200
Message-Id: <1030508999.1547.45.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nGlGpXBkAVm32AMDa3DW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2002-08-28 at 06:07, David S. Miller wrote:
>    From: Luca Barbieri <ldb@ldb.ods.org>
>    Date: 28 Aug 2002 06:10:39 +0200
> 
>    I'm not saying that it's serious bug, just that using __ffs is more
>    appropriate than reimplementing it incorrectly and inefficiently.
>    
> ffs won't find the smallest power of 2 >= some_arbitrary_value.
> That is what this code is doing.
Yes you are right, fls should be used there, not ffs.


--=-nGlGpXBkAVm32AMDa3DW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9bFHGdjkty3ft5+cRApWnAJ90gL7kXMunuES3NtxDYYm8+D1zrACdFY2W
o1K/Hk9X7YUnQt0EsUpPeNM=
=CWDn
-----END PGP SIGNATURE-----

--=-nGlGpXBkAVm32AMDa3DW--
