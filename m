Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbTLWXTq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 18:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263189AbTLWXTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 18:19:46 -0500
Received: from mx1.mail.ru ([194.67.23.21]:40210 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S263185AbTLWXTo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 18:19:44 -0500
Message-ID: <3FE8CD8D.6090303@mail.ru>
Date: Tue, 23 Dec 2003 18:19:41 -0500
From: Yaroslav Klyukin <skintwin@mail.ru>
User-Agent: Mozilla/5.0 (ICQ: 1045670, AIM: infiniteparticle)
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: aacraid issues
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4BAA6B66BCFC82D51C78A802"
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4BAA6B66BCFC82D51C78A802
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I have very strange aacraid behavior:
First of all, I know, that aacraid support is experimental, but maybe 
the issue is related to something else in the kernel.

I have AMD Opteron system with 10 scsi disks, connected to Adaptec 2200S 
controller, constituting about 1.2TB in total.

I can boot with 2.4.22 kernel, compiled for Xeon, into RedHat 9
(32 bit mode). aacraid version 1.1.2. The raid works great.

Then I boot into SuSE Linux 9 for the Opterons, with 2.4.23 kernel.
aacraid version 1.1-3.

Seems to work, but when I try to access blocks close to the end of the 
RAID, I am getting I/O errors.

Any ideas?
Where can I get the latest patches for the aacraid driver?

Just tried 2.6.0 kernel with patches for Opteron, but as soon as it 
starts working with Adaptec controller, it crashes miserably... :-(






--------------enig4BAA6B66BCFC82D51C78A802
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/6M2NXtaNP/qDgm8RAoVoAJ9psZg23P5DoOKJ6ntuaXG0jXledwCePA1H
FRocFVYEscjVXgS4JFIt5SU=
=N/7+
-----END PGP SIGNATURE-----

--------------enig4BAA6B66BCFC82D51C78A802--

