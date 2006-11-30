Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933397AbWK3Jkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933397AbWK3Jkr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 04:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933542AbWK3Jkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 04:40:46 -0500
Received: from hqemgate02.nvidia.com ([216.228.112.143]:42535 "EHLO
	HQEMGATE02.nvidia.com") by vger.kernel.org with ESMTP
	id S933394AbWK3Jko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 04:40:44 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C71463.919F6443"
Subject: [PATCH 2/2] sata_nv & ahci: Move some IDs from sata_nv.c to ahci.c
Date: Thu, 30 Nov 2006 17:40:27 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B0D588DC1@hkemmail01.nvidia.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2/2] sata_nv & ahci: Move some IDs from sata_nv.c to ahci.c
Thread-Index: AccUY5EboO1z/YNaQ5aiOFOc6SGJXA==
From: "Peer Chen" <pchen@nvidia.com>
To: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: "Jeff Garzik" <jgarzik@pobox.com>, "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 30 Nov 2006 09:40:30.0661 (UTC) FILETIME=[93291750:01C71463]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C71463.919F6443
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Move the device IDs of MCP65/MCP67 from sata_nv.c to ahci.c.
The patch will be applied to kernel 2.6.19.
Please check attachment for the patch.

Signed-off-by: Peer Chen <pchen@nvidia.com>


BRs
Peer Chen


-------------------------------------------------------------------------=
----------
This email message is for the sole use of the intended recipient(s) and m=
ay contain
confidential information.  Any unauthorized review, use, disclosure or di=
stribution
is prohibited.  If you are not the intended recipient, please contact the=
=20sender by
reply email and destroy all copies of the original message.
-------------------------------------------------------------------------=
----------

------_=_NextPart_001_01C71463.919F6443
Content-Type: application/octet-stream;
	name="patch.ahci"
Content-Transfer-Encoding: base64
Content-Description: patch.ahci
Content-Disposition: attachment;
	filename="patch.ahci"

LS0tIGxpbnV4LTIuNi4xOS9kcml2ZXJzL2F0YS9haGNpLmMub3JpZwkyMDA2LTExLTMwIDE0OjIw
OjU2LjAwMDAwMDAwMCArMDgwMAorKysgbGludXgtMi42LjE5L2RyaXZlcnMvYXRhL2FoY2kuYwky
MDA2LTExLTMwIDE0OjIzOjIxLjAwMDAwMDAwMCArMDgwMApAQCAtMzQ1LDYgKzM0NSwxNCBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgYWhjaV9wCiAJeyBQQ0lfVkRFVklDRShO
VklESUEsIDB4MDQ0ZCksIGJvYXJkX2FoY2kgfSwJCS8qIE1DUDY1ICovCiAJeyBQQ0lfVkRFVklD
RShOVklESUEsIDB4MDQ0ZSksIGJvYXJkX2FoY2kgfSwJCS8qIE1DUDY1ICovCiAJeyBQQ0lfVkRF
VklDRShOVklESUEsIDB4MDQ0ZiksIGJvYXJkX2FoY2kgfSwJCS8qIE1DUDY1ICovCisJeyBQQ0lf
VkRFVklDRShOVklESUEsIDB4MDQ1YyksIGJvYXJkX2FoY2kgfSwJCS8qIE1DUDY1ICovCisJeyBQ
Q0lfVkRFVklDRShOVklESUEsIDB4MDQ1ZCksIGJvYXJkX2FoY2kgfSwJCS8qIE1DUDY1ICovCisJ
eyBQQ0lfVkRFVklDRShOVklESUEsIDB4MDQ1ZSksIGJvYXJkX2FoY2kgfSwJCS8qIE1DUDY1ICov
CisJeyBQQ0lfVkRFVklDRShOVklESUEsIDB4MDQ1ZiksIGJvYXJkX2FoY2kgfSwJCS8qIE1DUDY1
ICovCisJeyBQQ0lfVkRFVklDRShOVklESUEsIDB4MDU1MCksIGJvYXJkX2FoY2kgfSwJCS8qIE1D
UDY3ICovCisJeyBQQ0lfVkRFVklDRShOVklESUEsIDB4MDU1MSksIGJvYXJkX2FoY2kgfSwJCS8q
IE1DUDY3ICovCisJeyBQQ0lfVkRFVklDRShOVklESUEsIDB4MDU1MiksIGJvYXJkX2FoY2kgfSwJ
CS8qIE1DUDY3ICovCisJeyBQQ0lfVkRFVklDRShOVklESUEsIDB4MDU1MyksIGJvYXJkX2FoY2kg
fSwJCS8qIE1DUDY3ICovCiAJeyBQQ0lfVkRFVklDRShOVklESUEsIDB4MDU1NCksIGJvYXJkX2Fo
Y2kgfSwJCS8qIE1DUDY3ICovCiAJeyBQQ0lfVkRFVklDRShOVklESUEsIDB4MDU1NSksIGJvYXJk
X2FoY2kgfSwJCS8qIE1DUDY3ICovCiAJeyBQQ0lfVkRFVklDRShOVklESUEsIDB4MDU1NiksIGJv
YXJkX2FoY2kgfSwJCS8qIE1DUDY3ICovCg==

------_=_NextPart_001_01C71463.919F6443--
