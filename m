Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272280AbTG3Vzk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 17:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272286AbTG3Vzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 17:55:40 -0400
Received: from mail-1.ricochet.nethere.net ([66.63.158.19]:51716 "EHLO
	mail-1.ricochet.nethere.net") by vger.kernel.org with ESMTP
	id S272280AbTG3Vzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 17:55:33 -0400
Message-ID: <3F283E3A.7060200@earthlink.net>
Date: Wed, 30 Jul 2003 15:52:58 -0600
From: "Ian S. Nelson" <nelsonis@earthlink.net>
Reply-To: nelsonis@earthlink.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Dell 2650 Dual Xeon freezing up frequently
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2D45FB6D6ACA686181965B97"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2D45FB6D6ACA686181965B97
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I'm running a RedHat 2.4.20 kernel on some 2650's   all dual xeon 
(pentium 4 jacksonized  so it looks like 4 procsessors)  2 have 1GB of 
RAM and 1 has 2GB of RAM.   THey all wedge, some times after a few 
minutes,  sometimes after hours.

I hooked up a serial consol to capture a kernel panic or something else 
that would be fun to debug,  no such luck..  It just locks up.  No nothing.


I'm looking at the 2.4.21 change logs and I'm not seeing aynthing that 
sounds like it would fix this, a couple possible SMP issues but nothing 
that identifies Pentium 4 Xeon problems.
I've added one networking module but the problem happens without it 
being loaded,    so my crap doesn't smell bad, yet ;-)

I'm spinning stuff on it in uniprocessor mode at the moment, seeing if 
that fixes anything.

any free clues?


thanks,
Ian


--------------enig2D45FB6D6ACA686181965B97
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/KD5QV28blwDT2YMRAibcAJ9cgjDmrZp2SSFLE9xd5unNrsf9ZACfVd3u
4LSe3PFQ+ljbDmjGAN3J6Cc=
=tCp9
-----END PGP SIGNATURE-----

--------------enig2D45FB6D6ACA686181965B97--

