Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131794AbRAJVW3>; Wed, 10 Jan 2001 16:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbRAJVWU>; Wed, 10 Jan 2001 16:22:20 -0500
Received: from tellus.thn.htu.se ([193.10.192.40]:9739 "EHLO thn.htu.se")
	by vger.kernel.org with ESMTP id <S129406AbRAJVWB>;
	Wed, 10 Jan 2001 16:22:01 -0500
Date: Wed, 10 Jan 2001 22:18:52 +0100 (CET)
From: Richard Torkar <ds98rito@thn.htu.se>
To: Matthias Juchem <juchem@uni-mannheim.de>
cc: <linux-kernel@vger.kernel.org>, Keith Owens <kaos@ocs.com.au>,
        Ulrich Drepper <drepper@redhat.com>
Subject: Re: bugreporting script - second try
In-Reply-To: <Pine.LNX.4.30.0101102128500.12979-101000@gandalf.math.uni-mannheim.de>
Message-ID: <Pine.LNX.4.30.0101102205250.1391-100000@studpc91.thndorm.htu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Matthias Juchem wrote:

> Hi there.
>
> I rewrote my previous bugreport.pl in bash. I would appreciate it if you
> had a look on this one. Run it once and give me feedback if you like.
>

Well it certantly works here. Almost everything is extracted correctly. I
could not btw test the ksymoops "feature" unfortunately.

What I did notice was the following.
This was checking "b) software" in the output file.

 GNU C                  2.96
 Modutils               2.4.1
 GNU make               3.79.1,
 Binutils               2.10.90
 Linux libc5 C Library  not found
 Linux libc6 C Library  2.2,
 Linux C++ library      2.7.2.8
 Dynamic linker         2.2
 Procps                 2.0.7
 Procinfo
 Psmisc                 19
 Net-tools              1.56
 PPP                    command
 Kdb
 Sh-utils               2.0
 Util-linux             2.10m
 E2fsprogs              1.19,
 Bash                   2.04.11(1)-release


I do not have any PPP, and no kdb installed on that machine, neither do I
have procinfo. Shouldn't it say N/A or not found instead of the above? The
ppp part is not true ;-).

Other thing I thought about was the Ctrl-D thingy when entering text.
What if ppl don't have any text to enter? Shouldn't is say on each line
that if you don't have anything to write then just write N/A and press
Ctrl-D? Because pressing Ctrl-D directly doesn't do any good.

Sorry to just be a pain in the ass, and *very* sorry for not having the
time to make a patch for you :)

But you did a good job. I think this is really good for new kernel ppl.
This could be very appreciated!


/Richard
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6XNHAUSLExYo23RsRAlMtAJ9Mo8B0LmaelPoG3zNU0NJccysZ/gCgiQDe
uaL2e9JaBbU3XCX5dLANsnQ=
=GKCp
-----END PGP SIGNATURE-----


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
