Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267727AbTATA15>; Sun, 19 Jan 2003 19:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267728AbTATA14>; Sun, 19 Jan 2003 19:27:56 -0500
Received: from h80ad248b.async.vt.edu ([128.173.36.139]:33921 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267727AbTATA1z>; Sun, 19 Jan 2003 19:27:55 -0500
Message-Id: <200301200036.h0K0aCIJ012273@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: David Schwartz <davids@webmaster.com>
Cc: adilger@clusterfs.com, Roman Zippel <zippel@linux-m68k.org>,
       Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Is the BitKeeper network protocol documented? 
In-Reply-To: Your message of "Sun, 19 Jan 2003 15:57:40 PST."
             <20030119235742.AAA13049%shell.webmaster.com@whenever> 
From: Valdis.Kletnieks@vt.edu
References: <20030119235742.AAA13049%shell.webmaster.com@whenever>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-54765488P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 19 Jan 2003 19:36:12 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-54765488P
Content-Type: text/plain; charset=us-ascii

On Sun, 19 Jan 2003 15:57:40 PST, David Schwartz said:

> 	I think you're ignoring the way the GPL defines the "source code". 
> The GPL defines the "source code" as the preferred form for modifying 
> the program. If the preferred form of a work for purposes of 
> modifying it is live access to a BK repository, then that's the 
> "source code" for GPL purposes.

Dammit, *MY* preferred form might be CVS, I want a CVS tree instead!!

I can't use BitKeeper based on my reading of the license and Larry's
comments, because one of my current projects is a system-config versioning
and tracking system. (Hey Larry et al - thanks for a good tool and getting Linus
to use it.. ;)

Just because Linus happens to be using BK currently does *NOT* automagically
make it the industry-standard preferred format.

Not everybody has BitKeeper - as such, a .tar.gz of the source tree can
reasonably be considered the "preferred" form if your intent is to make
the tree available to as many people as possible - if it's a .tar.gz, the
only thing you need is a GNU-compatible tar command to extract it.  Certainly
preferable to BK if you want somebody to be able to get going with as little
as possible.

And let's go look at another clause there:

> 1. You may copy and distribute verbatim copies of the Program's
> source code as you receive it, 

Does this mean that Linus can't distribute a tree with patches integrated, but
has to include copies of things as they were posted to LKML?

Actually, you *want* Linus to be editing, so he has copyright on the
collection as a whole (very important, as another poster commented).

Moral: Let's not get silly here...

> making modifications to it.  For an executable work, complete source
> code means all the source code for all modules it contains, plus any
> associated interface definition files, plus the scripts used to
> control compilation and installation of the executable.

Hmm.. and what is Linus failing to ship here?  The .c files are in there,
the .h files are in there, the Kconfig/Makefiles are there....

Note that this clause doesn't even apply unless you distribute *binaries*.
Linus doesn't do that, RedHat does that - and THEIR preferred format for
distributing is a .RPM.  Ever tried to figure out what RedHat did to something
when you're on a machine without RPM?   Yep, you get to track down rpm2cpio or
similar...

I'll make the only-slightly facetious comment that the *preferred* format
for a kernel tree would include a neuron dump of the people who were doing
the coding, so we would be able to determine whether a given change was
truly enlightened and correct, or if they were just on crack at the time....
-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_-54765488P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+K0R8cC3lWbTT17ARAjWOAJ9HgPFnWrwzBd2z4RsBiSTN2Juo6ACguiYv
S3uOjjev3z59fwBp0L8Cby4=
=BPAL
-----END PGP SIGNATURE-----

--==_Exmh_-54765488P--
