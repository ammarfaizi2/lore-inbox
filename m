Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbWG3MBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWG3MBW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 08:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWG3MBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 08:01:22 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:57219 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932291AbWG3MBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 08:01:21 -0400
Message-ID: <44CC9F7E.8040807@t-online.de>
Date: Sun, 30 Jul 2006 14:01:02 +0200
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Thunderbird 1.5.0.4 (X11/20060714)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.18-rc2, problem to wake up spinned down drive?
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3728720752D7289C582CBFDA"
X-ID: EY23TaZXgeVce5F0a2CDAhywF614HxWFaFjumjTSxjpdl1jAsn-6cC
X-TOI-MSGID: aba3ff80-83e6-416f-a052-9505a61a50a2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3728720752D7289C582CBFDA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi folks,

I tried to spin down my harddisk using hdparm, but when it is
supposed to spin up again, then it is blocked for quite some
time. dmesg says:

ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: (BMDMA stat 0x20)
ata1.00: tag 0 cmd 0xca Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: port is slow to respond, please be patient
ata1: port failed to respond (30 secs)
ata1: soft resetting port
ata1.00: configured for UDMA/133
ata1: EH complete
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back

The disk is a SAMSUNG SP1614C.


On another machine (with a SAMSUNG SP2504C inside) there is no
such problem: The disk is back after just a few seconds.


Is there some trick to wake up the disk a little bit faster?


Regards

Harri


--------------enig3728720752D7289C582CBFDA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEzJ9+UTlbRTxpHjcRApgQAJ9YRVqxRtnDTKzyIKA+27BWcMZTHgCeM0OB
kJrafcRuThAxM4pzrb5XK2A=
=c5LZ
-----END PGP SIGNATURE-----

--------------enig3728720752D7289C582CBFDA--
