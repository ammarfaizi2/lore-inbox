Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbTHUG5u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 02:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262466AbTHUG5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 02:57:49 -0400
Received: from h80ad249d.async.vt.edu ([128.173.36.157]:59267 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262468AbTHUG1A (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 02:27:00 -0400
Message-Id: <200308210626.h7L6Qruu007015@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: jw schultz <jw@pegasys.ws>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 48-bit Drives Incorrectly reporting 255 Heads? 
In-Reply-To: Your message of "Wed, 20 Aug 2003 22:38:24 PDT."
             <20030821053824.GA21451@pegasys.ws> 
From: Valdis.Kletnieks@vt.edu
References: <88A7BC80FA2797498AF6D865CAD3EA43180E95@iceman.altiris.com>
            <20030821053824.GA21451@pegasys.ws>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1439855290P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 21 Aug 2003 02:26:53 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1439855290P
Content-Type: text/plain; charset=us-ascii

On Wed, 20 Aug 2003 22:38:24 PDT, jw schultz <jw@pegasys.ws>  said:

> A 240 head drive would have to have multiple heads per
> surface or the stack of disks on the spindle would be about
> 5 feet tall.

That's an old Jedi mind trick, dating back at *least* as far as the IBM 3350
disk drive from 1976 (the 23xx drives from the S/360 and the 3330/3340 series
had single heads per surface) .  8 14" platters, 317.5M.  16 physical surfaces,
but it reported 30 heads, because each arm had an "inside" and "outside" head :

====\=====\   (arm)
        =================| (platter)
====/=====/   (arm)

The outside heads were tracks 0-15 and servo-1, the inside heads were 16-29
and servo-2.  It was also available with a second fixed-access arm that had enough
heads to read the first 5 cylinders without seeking at all - so that's another 150
heads.  So that gets us to 180... not *quite* 240, but....

And it wasn't 5 foot tall, by a long shot: http://www.columbia.edu/acis/history/mss.html
The last picture has guys standing around a string of 3350 disk drives (the
actual drive was contained in the white head, the blue bottom part was power
supplies and control logic and the like).


--==_Exmh_1439855290P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/RGYtcC3lWbTT17ARAnuOAJ9RWn7usXy8rQJFwOZ7bdkyIU3D6QCgxwju
gESMeQ6gdQsUhiPgQXVLrWk=
=TOa0
-----END PGP SIGNATURE-----

--==_Exmh_1439855290P--
