Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbVHGHcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbVHGHcO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 03:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbVHGHcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 03:32:13 -0400
Received: from sls-ce5p321.hostitnow.com ([72.9.236.50]:52364 "EHLO
	sls-ce5p321.hostitnow.com") by vger.kernel.org with ESMTP
	id S1751195AbVHGHcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 03:32:13 -0400
Date: Sun, 7 Aug 2005 16:02:22 +0900
From: Chris White <chriswhite@gentoo.org>
To: linux-kernel@vger.kernel.org
Subject: Logitech Quickcam Express USB Address Aquisition Issues
Message-ID: <20050807160222.0c4ee412@localhost>
Organization: Gentoo
X-Mailer: Sylpheed-Claws 1.9.12 (GTK+ 2.6.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=Signature_Sun__7_Aug_2005_16_02_22_+0900_KOqszfKVJVPh3iEh;
 protocol="application/pgp-signature"; micalg=pgp-sha1
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - sls-ce5p321.hostitnow.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - gentoo.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature_Sun__7_Aug_2005_16_02_22_+0900_KOqszfKVJVPh3iEh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

[Pre Note: please CC me all responses, thanks]

Currently, I have a Logitech Quickcam Express webcamera.  Unfortunately, it=
 seems to have issues getting assigned an address.  I quote the following f=
rom dmesg:

usb 1-1.1: new full speed USB device using ehci_hcd and address 11
usb 1-1.1: device descriptor read/64, error -32
usb 1-1.1: device descriptor read/64, error -32
usb 1-1.1: new full speed USB device using ehci_hcd and address 12
usb 1-1.1: device descriptor read/64, error -32
usb 1-1.1: device descriptor read/64, error -32
usb 1-1.1: new full speed USB device using ehci_hcd and address 13
usb 1-1.1: device not accepting address 13, error -32
usb 1-1.1: new full speed USB device using ehci_hcd and address 14
usb 1-1.1: device not accepting address 14, error -32

As far as the host goes, I have the following USB hosts:

0000:00:11.0 USB Controller: NEC Corporation USB (rev 43)
0000:00:11.1 USB Controller: NEC Corporation USB (rev 43)
0000:00:11.2 USB Controller: NEC Corporation USB 2.0 (rev 04)

The first is my builtin Intel USB controller, the second is one belkin USB =
1.0 card, and another 2.0 card.  I've tried it in all three just to verify =
one of my hosts wasn't broken.  Considering my printer works with it, as we=
ll as my scanner, I'm sort of thinking that's not an issue.

I searched up google a bit and recieved some warnings about acpi causing pr=
oblems, so I disabled that, but was still unsucessful in getting that to wo=
rk.  Please let me know if any other information is required.  Thanks ahead=
 of time.

Chris White

--Signature_Sun__7_Aug_2005_16_02_22_+0900_KOqszfKVJVPh3iEh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFC9bICFdQwWVoAgN4RAjxBAJ9UuA8iKD/yvsETIKgmNpFHzpXeKACgrljX
jCExtqsUKQ5d7K1mbVsERI0=
=fON0
-----END PGP SIGNATURE-----

--Signature_Sun__7_Aug_2005_16_02_22_+0900_KOqszfKVJVPh3iEh--
