Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267389AbTALSik>; Sun, 12 Jan 2003 13:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267394AbTALSik>; Sun, 12 Jan 2003 13:38:40 -0500
Received: from 60.54.252.64.snet.net ([64.252.54.60]:53297 "EHLO
	mail.blue-labs.org") by vger.kernel.org with ESMTP
	id <S267389AbTALSih>; Sun, 12 Jan 2003 13:38:37 -0500
Message-ID: <3E21B839.4060902@blue-labs.org>
Date: Sun, 12 Jan 2003 13:47:21 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030110
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.56 panics PostgreSQL
X-Enigmail-Version: 0.71.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0A0CD434A15915E8CA0ABEE2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0A0CD434A15915E8CA0ABEE2
Content-Type: multipart/mixed;
 boundary="------------080206020407000209000906"

This is a multi-part message in MIME format.
--------------080206020407000209000906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Yesterday I put 2.5.56 on my SQL server and PostgreSQL started panicking 
repeatedly and frequently complaining about missing commit logs.  2.5.56 
also issued a single NMI .. dazed and confused but continuing warning 
shortly after startup.

Rebooting back into 2.4 and the world was well again.  Attached is my 
.config in bz2 form.

David

-- 
I may have the information you need and I may choose only HTML.  It's up to you. Disclaimer: I am not responsible for any email that you send me nor am I bound to any obligation to deal with any received email in any given fashion.  If you send me spam or a virus, I may in whole or part send you 50,000 return copies of it. I may also publically announce any and all emails and post them to message boards, news sites, and even parody sites.  I may also mark them up, cut and paste, print, and staple them to telephone poles for the enjoyment of people without internet access.  This is not a confidential medium and your assumption that your email can or will be handled confidentially is akin to baring your backside, burying your head in the ground, and thinking nobody can see you butt nekkid and in plain view for miles away.  Don't be a cluebert, buy one from K-mart today.

When it absolutely, positively, has to be destroyed overnight.
                           AIR FORCE


--------------080206020407000209000906
Content-Type: application/octet-stream;
 name="config.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="config.bz2"

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
--------------080206020407000209000906--

--------------enig0A0CD434A15915E8CA0ABEE2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+Ibg874cGT/9uvgsRArYGAJ4wcW8nTG8krvOequ3JorlDpjOKkwCgjwq+
dU0+IllN/+mbvu7SBWbj1cM=
=buKm
-----END PGP SIGNATURE-----

--------------enig0A0CD434A15915E8CA0ABEE2--

