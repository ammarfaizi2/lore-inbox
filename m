Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbWHGSn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWHGSn3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 14:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbWHGSn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 14:43:29 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:14736 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932304AbWHGSn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 14:43:29 -0400
Message-ID: <44D789BA.4010206@t-online.de>
Date: Mon, 07 Aug 2006 20:43:06 +0200
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Thunderbird 1.5.0.4 (X11/20060714)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       davidsen@tmr.com
Subject: Re: 2.6.18-rc2, problem to wake up spinned down drive?
References: <44CC9F7E.8040807@t-online.de> <44CF7E5A.2010903@gmail.com> <20060805212346.GE5417@ucw.cz> <44D6AE59.6070709@gmail.com>
In-Reply-To: <44D6AE59.6070709@gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6D9B6E6155FAFF90F1D40624"
X-ID: SOl41ZZ-ZeNAnX0EJ1eMumGjB5BGP0AhCd+os6549DPYvA4Q8+pLc8
X-TOI-MSGID: 7e560e63-2fe2-49f1-a258-9e49ba6e3b7c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6D9B6E6155FAFF90F1D40624
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Tejun Heo wrote:
> Pavel Machek wrote:
>>> echo 1 > /sys/bus/scsi/devices/1:0:0:0/power/state
>>
>> Really? I thought power/state takes 0/3 (for D0 and D3)
>=20
> Yes, of course.  My mistake.  Sorry about the confusion.  The correct
> command is 'echo -n 3 > /sys/bus/scsi/devices/x:y:z:w/power/state'.
>=20

(Sure?  :-)

Now this did not work at all. The '-n 3' was probably
correct, but when I tried to access the disk, then it
did not spin up again (I waited for 5 minutes). There
was no message on the console, either.

But I could not reproduce this problem.

How do I monitor that the disk spins down and up?


Regards

Harri



--------------enig6D9B6E6155FAFF90F1D40624
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE14m6UTlbRTxpHjcRAqQCAJ0eIjv23eUfUIGXjVeDKna8DrDrqACfQujX
xMZ6bpN4amkkf5uMaOTWVzw=
=HohH
-----END PGP SIGNATURE-----

--------------enig6D9B6E6155FAFF90F1D40624--
