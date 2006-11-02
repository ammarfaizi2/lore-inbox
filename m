Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752577AbWKBDXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577AbWKBDXe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 22:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752623AbWKBDXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 22:23:34 -0500
Received: from hqemgate01.nvidia.com ([216.228.112.170]:18968 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S1752577AbWKBDXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 22:23:32 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C6FE2E.3D9CE816"
Subject: [PATCH ] ahci: Add the support of nvidia AHCI controllers of MCP67 to ahci.c
Date: Thu, 2 Nov 2006 11:23:16 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B0C54FB86@hkemmail01.nvidia.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH ] ahci: Add the support of nvidia AHCI controllers of MCP67 to ahci.c
Thread-Index: Acb+LjzGSy4/Z+lTQ1W07jkIoQEqtQ==
From: "Peer Chen" <pchen@nvidia.com>
To: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <jgarzik@pobox.com>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>
X-OriginalArrivalTime: 02 Nov 2006 03:23:21.0524 (UTC) FILETIME=[3F93CF40:01C6FE2E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6FE2E.3D9CE816
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Add support for AHCI controllers of MCP67.
The patch will be applied to kernel 2.6.19-rc4-git1.
Please check attachment for the patch.

Signed-off-by: Peer Chen <pchen@nvidia.com>

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

------_=_NextPart_001_01C6FE2E.3D9CE816
Content-Type: application/octet-stream;
	name="patch.ahci"
Content-Transfer-Encoding: base64
Content-Description: patch.ahci
Content-Disposition: attachment;
	filename="patch.ahci"

LS0tIGxpbnV4LTIuNi4xOS1yYzQtZ2l0MS9kcml2ZXJzL2F0YS9haGNpLmMub3JpZwkyMDA2LTEw
LTMxIDIwOjQ0OjU4LjAwMDAwMDAwMCArMDgwMAorKysgbGludXgtMi42LjE5LXJjNC1naXQxL2Ry
aXZlcnMvYXRhL2FoY2kuYwkyMDA2LTEwLTMxIDIwOjM4OjEyLjAwMDAwMDAwMCArMDgwMApAQCAt
MzM0LDYgKzMzNCwxNCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgYWhjaV9w
CiAJeyBQQ0lfVkRFVklDRShOVklESUEsIDB4MDQ0ZCksIGJvYXJkX2FoY2kgfSwJCS8qIE1DUDY1
ICovCiAJeyBQQ0lfVkRFVklDRShOVklESUEsIDB4MDQ0ZSksIGJvYXJkX2FoY2kgfSwJCS8qIE1D
UDY1ICovCiAJeyBQQ0lfVkRFVklDRShOVklESUEsIDB4MDQ0ZiksIGJvYXJkX2FoY2kgfSwJCS8q
IE1DUDY1ICovCisJeyBQQ0lfVkRFVklDRShOVklESUEsIDB4MDU1NCksIGJvYXJkX2FoY2kgfSwJ
CS8qIE1DUDY3ICovCisJeyBQQ0lfVkRFVklDRShOVklESUEsIDB4MDU1NSksIGJvYXJkX2FoY2kg
fSwJCS8qIE1DUDY3ICovCisJeyBQQ0lfVkRFVklDRShOVklESUEsIDB4MDU1NiksIGJvYXJkX2Fo
Y2kgfSwJCS8qIE1DUDY3ICovCisJeyBQQ0lfVkRFVklDRShOVklESUEsIDB4MDU1NyksIGJvYXJk
X2FoY2kgfSwJCS8qIE1DUDY3ICovCisJeyBQQ0lfVkRFVklDRShOVklESUEsIDB4MDU1OCksIGJv
YXJkX2FoY2kgfSwJCS8qIE1DUDY3ICovCisJeyBQQ0lfVkRFVklDRShOVklESUEsIDB4MDU1OSks
IGJvYXJkX2FoY2kgfSwJCS8qIE1DUDY3ICovCisJeyBQQ0lfVkRFVklDRShOVklESUEsIDB4MDU1
YSksIGJvYXJkX2FoY2kgfSwJCS8qIE1DUDY3ICovCisJeyBQQ0lfVkRFVklDRShOVklESUEsIDB4
MDU1YiksIGJvYXJkX2FoY2kgfSwJCS8qIE1DUDY3ICovCiAKIAkvKiBTaVMgKi8KIAl7IFBDSV9W
REVWSUNFKFNJLCAweDExODQpLCBib2FyZF9haGNpIH0sIC8qIFNpUyA5NjYgKi8K

------_=_NextPart_001_01C6FE2E.3D9CE816--
