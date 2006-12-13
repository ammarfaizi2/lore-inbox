Return-Path: <linux-kernel-owner+w=401wt.eu-S1751621AbWLMWYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbWLMWYJ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 17:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751627AbWLMWYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 17:24:09 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:58287 "EHLO
	mailout11.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751621AbWLMWYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 17:24:07 -0500
X-Greylist: delayed 8417 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 17:24:07 EST
Message-ID: <45805C96.5090709@t-online.de>
Date: Wed, 13 Dec 2006 21:03:34 +0100
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Icedove 1.5.0.8 (X11/20061129)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.18.3, sata dvd writer: can't watch dvd
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig556A252956594587563FD898"
X-ID: TJ5sOyZGgefPLeDkPlSx9KO+92C4-lE8CrRXRSEotM1SSFq32+4mg2
X-TOI-MSGID: 0a6b04b4-eefe-4a19-be30-da0644458bbc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig556A252956594587563FD898
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi folks,

I've got a shiny new sata dvd writer: A Samsung SH-183A,
most recent firmware SB01. Writing data DVDs is _lightning_
fast, but I cannot watch my css-encrypted movie DVDs, even
with libdvdcss installed. If I try, then it becomes
unresponsive. dmesg says:

ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (BMDMA stat 0x1)
ata2.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata2.00: failed to IDENTIFY (device reports illegal type, err_mask=3D0x0)=

ata2.00: revalidation failed (errno=3D-22)
ata2.00: disabled
ata2: EH complete
Buffer I/O error on device sr0, logical block 0
Buffer I/O error on device sr0, logical block 1
Buffer I/O error on device sr0, logical block 2
Buffer I/O error on device sr0, logical block 3
Buffer I/O error on device sr0, logical block 4
Buffer I/O error on device sr0, logical block 5
Buffer I/O error on device sr0, logical block 6
Buffer I/O error on device sr0, logical block 7
Buffer I/O error on device sr0, logical block 0
Buffer I/O error on device sr0, logical block 1

After that the DVD drive is dead, waiting for a reset.
I tried this with 4 DVDs by now.

Watching my own DVD-Rs (created in a Philips HD recorder),
or commercial DVDs without CSS (e.g. "True Lies") is no
problem. The region code is set (2), of course.


Any idea? Unfortunately I cannot verify the drive in a
proprietary runtime environment.


Many thanx in advance.


Regards

Harri


--------------enig556A252956594587563FD898
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFgFydUTlbRTxpHjcRApK9AJ965a4dSmSH8wNebFxh7lTwfT7yEQCdG7jz
+qNN87z7xOFUFtcXoGbBRBA=
=EZ0H
-----END PGP SIGNATURE-----

--------------enig556A252956594587563FD898--
