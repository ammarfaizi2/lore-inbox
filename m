Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752592AbWKBDh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592AbWKBDh0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 22:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752604AbWKBDhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 22:37:19 -0500
Received: from hqemgate02.nvidia.com ([216.228.112.143]:64267 "EHLO
	HQEMGATE02.nvidia.com") by vger.kernel.org with ESMTP
	id S1752592AbWKBDhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 22:37:15 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C6FE2F.490ACD34"
Subject: [PATCH 1/2] IDE: Add the support of nvidia PATA controllers of MCP67 to amd74xx.c & pata_amd.c
Date: Thu, 2 Nov 2006 11:30:45 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B0C54FBA7@hkemmail01.nvidia.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/2] IDE: Add the support of nvidia PATA controllers of MCP67 to amd74xx.c & pata_amd.c
Thread-Index: Acb+LjzGSy4/Z+lTQ1W07jkIoQEqtQAABSsA
From: "Peer Chen" <pchen@nvidia.com>
To: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <jgarzik@pobox.com>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>
X-OriginalArrivalTime: 02 Nov 2006 03:30:50.0395 (UTC) FILETIME=[4B2016B0:01C6FE2F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6FE2F.490ACD34
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Add support for PATA controllers of MCP67 to amd74xx.c.
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

------_=_NextPart_001_01C6FE2F.490ACD34
Content-Type: application/octet-stream;
	name="patch.amd74xx"
Content-Transfer-Encoding: base64
Content-Description: patch.amd74xx
Content-Disposition: attachment;
	filename="patch.amd74xx"

LS0tIGxpbnV4LTIuNi4xOS1yYzQtZ2l0MS9kcml2ZXJzL2lkZS9wY2kvYW1kNzR4eC5jLm9yaWcJ
MjAwNi0xMC0zMSAyMDo0NDoyNS4wMDAwMDAwMDAgKzA4MDAKKysrIGxpbnV4LTIuNi4xOS1yYzQt
Z2l0MS9kcml2ZXJzL2lkZS9wY2kvYW1kNzR4eC5jCTIwMDYtMTAtMzEgMjA6MjM6MDAuMDAwMDAw
MDAwICswODAwCkBAIC03NSw2ICs3NSw3IEBAIHN0YXRpYyBzdHJ1Y3QgYW1kX2lkZV9jaGlwIHsK
IAl7IFBDSV9ERVZJQ0VfSURfTlZJRElBX05GT1JDRV9NQ1A1NV9JREUsCTB4NTAsIEFNRF9VRE1B
XzEzMyB9LAogCXsgUENJX0RFVklDRV9JRF9OVklESUFfTkZPUkNFX01DUDYxX0lERSwJMHg1MCwg
QU1EX1VETUFfMTMzIH0sCiAJeyBQQ0lfREVWSUNFX0lEX05WSURJQV9ORk9SQ0VfTUNQNjVfSURF
LAkweDUwLCBBTURfVURNQV8xMzMgfSwKKwl7IFBDSV9ERVZJQ0VfSURfTlZJRElBX05GT1JDRV9N
Q1A2N19JREUsCTB4NTAsIEFNRF9VRE1BXzEzMyB9LAogCXsgUENJX0RFVklDRV9JRF9BTURfQ1M1
NTM2X0lERSwJCQkweDQwLCBBTURfVURNQV8xMDAgfSwKIAl7IDAgfQogfTsKQEAgLTQ5MSw3ICs0
OTIsOCBAQCBzdGF0aWMgaWRlX3BjaV9kZXZpY2VfdCBhbWQ3NHh4X2NoaXBzZXRzCiAJLyogMTYg
Ki8gREVDTEFSRV9OVl9ERVYoIk5GT1JDRS1NQ1A1NSIpLAogCS8qIDE3ICovIERFQ0xBUkVfTlZf
REVWKCJORk9SQ0UtTUNQNjEiKSwKIAkvKiAxOCAqLyBERUNMQVJFX05WX0RFVigiTkZPUkNFLU1D
UDY1IiksCi0JLyogMTkgKi8gREVDTEFSRV9BTURfREVWKCJBTUQ1NTM2IiksCisJLyogMTkgKi8g
REVDTEFSRV9OVl9ERVYoIk5GT1JDRS1NQ1A2NyIpLAorCS8qIDIwICovIERFQ0xBUkVfQU1EX0RF
VigiQU1ENTUzNiIpLAogfTsKIAogc3RhdGljIGludCBfX2RldmluaXQgYW1kNzR4eF9wcm9iZShz
dHJ1Y3QgcGNpX2RldiAqZGV2LCBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCAqaWQpCkBAIC01
MzAsNyArNTMyLDggQEAgc3RhdGljIHN0cnVjdCBwY2lfZGV2aWNlX2lkIGFtZDc0eHhfcGNpXwog
CXsgUENJX1ZFTkRPUl9JRF9OVklESUEsIFBDSV9ERVZJQ0VfSURfTlZJRElBX05GT1JDRV9NQ1A1
NV9JREUsCVBDSV9BTllfSUQsIFBDSV9BTllfSUQsIDAsIDAsIDE2IH0sCiAJeyBQQ0lfVkVORE9S
X0lEX05WSURJQSwgUENJX0RFVklDRV9JRF9OVklESUFfTkZPUkNFX01DUDYxX0lERSwJUENJX0FO
WV9JRCwgUENJX0FOWV9JRCwgMCwgMCwgMTcgfSwKIAl7IFBDSV9WRU5ET1JfSURfTlZJRElBLCBQ
Q0lfREVWSUNFX0lEX05WSURJQV9ORk9SQ0VfTUNQNjVfSURFLCAgUENJX0FOWV9JRCwgUENJX0FO
WV9JRCwgMCwgMCwgMTggfSwKLQl7IFBDSV9WRU5ET1JfSURfQU1ELAlQQ0lfREVWSUNFX0lEX0FN
RF9DUzU1MzZfSURFLAkJUENJX0FOWV9JRCwgUENJX0FOWV9JRCwgMCwgMCwgMTkgfSwKKwl7IFBD
SV9WRU5ET1JfSURfTlZJRElBLCBQQ0lfREVWSUNFX0lEX05WSURJQV9ORk9SQ0VfTUNQNjdfSURF
LCAgUENJX0FOWV9JRCwgUENJX0FOWV9JRCwgMCwgMCwgMTkgfSwKKwl7IFBDSV9WRU5ET1JfSURf
QU1ELAlQQ0lfREVWSUNFX0lEX0FNRF9DUzU1MzZfSURFLAkJUENJX0FOWV9JRCwgUENJX0FOWV9J
RCwgMCwgMCwgMjAgfSwKIAl7IDAsIH0sCiB9OwogTU9EVUxFX0RFVklDRV9UQUJMRShwY2ksIGFt
ZDc0eHhfcGNpX3RibCk7Cg==

------_=_NextPart_001_01C6FE2F.490ACD34--
