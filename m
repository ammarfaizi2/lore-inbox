Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132639AbRAJV3L>; Wed, 10 Jan 2001 16:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129903AbRAJV2v>; Wed, 10 Jan 2001 16:28:51 -0500
Received: from tellus.thn.htu.se ([193.10.192.40]:14859 "EHLO thn.htu.se")
	by vger.kernel.org with ESMTP id <S129610AbRAJV2u>;
	Wed, 10 Jan 2001 16:28:50 -0500
Date: Wed, 10 Jan 2001 22:26:32 +0100 (CET)
From: Richard Torkar <ds98rito@thn.htu.se>
To: <linux-kernel@vger.kernel.org>
Subject: Re: bugreporting script - second try
In-Reply-To: <Pine.LNX.4.30.0101102205250.1391-100000@studpc91.thndorm.htu.se>
Message-ID: <Pine.LNX.4.30.0101102225170.1391-100000@studpc91.thndorm.htu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Richard Torkar wrote:

> Matthias Juchem wrote:
>
> > Hi there.
> >
> > I rewrote my previous bugreport.pl in bash. I would appreciate it if you
> > had a look on this one. Run it once and give me feedback if you like.
> >
>
> Well it certantly works here. Almost everything is extracted correctly. I
> could not btw test the ksymoops "feature" unfortunately.
>
> What I did notice was the following.
> This was checking "b) software" in the output file.
>
>  GNU C                  2.96
>  Modutils               2.4.1
>  GNU make               3.79.1,
>  Binutils               2.10.90
>  Linux libc5 C Library  not found
>  Linux libc6 C Library  2.2,
>  Linux C++ library      2.7.2.8
>  Dynamic linker         2.2
>  Procps                 2.0.7
>  Procinfo
>  Psmisc                 19
>  Net-tools              1.56
>  PPP                    command
>  Kdb
>  Sh-utils               2.0
>  Util-linux             2.10m
>  E2fsprogs              1.19,
>  Bash                   2.04.11(1)-release
>
>
> I do not have any PPP, and no kdb installed on that machine, neither do I
> have procinfo. Shouldn't it say N/A or not found instead of the above? The
> ppp part is not true ;-).
>


Oohh btw when doing a pppd --version on my system I get.
[xxxx@~]$ pppd --version
bash: pppd: command not found



/Richard
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD4DBQE6XNOKUSLExYo23RsRApaPAJdFPBwbJ3cjbPEeSe9sF4bv95P1AJsElLpE
sCnH3COXAqy2B4XzcML+FQ==
=U2Yp
-----END PGP SIGNATURE-----


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
