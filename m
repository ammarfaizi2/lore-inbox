Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266611AbUGKOzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266611AbUGKOzw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 10:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266610AbUGKOzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 10:55:52 -0400
Received: from smtp1.wanadoo.fr ([193.252.22.30]:51477 "EHLO
	mwinf0107.wanadoo.fr") by vger.kernel.org with ESMTP
	id S266611AbUGKOzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 10:55:48 -0400
Date: Sun, 11 Jul 2004 16:55:46 +0200
From: Michelle Konzack <linux4michelle@freenet.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Ext3 File System "Too many files" with snort
Message-ID: <20040711145546.GF720@freenet.de>
References: <070820041751.25643.40ED899E0006C76E0000642B2200748184970A059D0A0306@comcast.net> <20040708182143.GD23346@schnapps.adilger.int>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kbCYTQG2MZjuOjyn"
Content-Disposition: inline
In-Reply-To: <20040708182143.GD23346@schnapps.adilger.int>
X-Message-Flag: Improper configuration of Outlook is a breeding ground for viruses. Please take care your Client is configured correctly. Greetings MIchelle.
X-Disclaimer-DE: Eine weitere Verwendung oder die Veroeffentlichung dieser Mail oder dieser Mailadresse ist nur mit der Einwilligung des Autors gestattet.
Organisation: Michelle's Selbstgebrautes
X-Operating-System: Linux michelle1 2.4.26-1-686
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kbCYTQG2MZjuOjyn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andreas,=20

Am 2004-07-08 12:21:43, schrieb Andreas Dilger:

>If you are actually running out of inodes, then you can use "-i" or "-N"
>to mke2fs to increase the number of inodes in a new filesystem.  Since
>this defaults to 1 inode per 8kB of space, it seems unlikely that you
>would run out of inodes before blocks unless you have lots of small files
>(maildir perhaps?  even then "modern" emails usually average > 8kB in size
>because of HTML crap, lots of headers, attachments, etc).

I have a courier-imap Server where I share all all mailinglists where=20
I am subscribed... Curently I have 5,2 Millionen Messages in the ext3.

I have already striped the messages with=20

:0 fh
| formail -f -I Received: -I Envelope-to: -I Delivered-To:  -I Return-path:=
 \
-I X-Spam-Checker-Version:   -I X-Spam-Status: -I X-Spam-Level:=20

I have a mailsize of around 2,5 kBytes...

So I habe used 'mkfs.ext3 -b 1024 -N 8000000 ... /dev/sda..'

My question is, how many Inodes can I create on a ext3 filesystem  ?

Curently I am running a 3Ware Raid-5 Controller 75xx with 3 x 80 GByte.

>Cheers, Andreas

Greetings
Michelle

--=20
Linux-User #280138 with the Linux Counter, http://counter.li.org/=20
Michelle Konzack   Apt. 917                  ICQ #328449886
                   50, rue de Soultz         MSM LinuxMichi
0033/3/88452356    67100 Strasbourg/France   IRC #Debian (irc.icq.com)

--kbCYTQG2MZjuOjyn
Content-Type: application/pgp-signature; name="signature.pgp"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA8VTyC0FPBMSS+BIRAjvaAKCJdAFdLoGsVWjPW3veavXjEr77EACfX1K3
cjbIsHN9gp3uw0yhKMF8fJk=
=bgV2
-----END PGP SIGNATURE-----

--kbCYTQG2MZjuOjyn--
