Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbWCNWC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbWCNWC3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 17:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbWCNWC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 17:02:29 -0500
Received: from mail0.lsil.com ([147.145.40.20]:24776 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S964792AbWCNWC1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 17:02:27 -0500
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C647B2.F9217612"
Subject: RE: [PATCH ] drivers/scsi/scsi.c - export reprobe 
Date: Tue, 14 Mar 2006 15:02:23 -0700
Message-ID: <F331B95B72AFFB4B87467BE1C8E9CF5F36DC41@NAMAIL2.ad.lsil.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH ] drivers/scsi/scsi.c - export reprobe 
Thread-Index: AcZHAZpp/wvGNY9KRWmb/AwqfyYfIwAsTywA
From: "Moore, Eric" <Eric.Moore@lsil.com>
To: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <James.Bottomley@SteelEye.com>, <hch@lst.de>, <gregkh@novell.com>
X-OriginalArrivalTime: 14 Mar 2006 22:02:23.0617 (UTC) FILETIME=[F9226710:01C647B2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C647B2.F9217612
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

On Monday, March 13, 2006 5:53 PM, I wrote:=20
>=20
> Request for exporting device_reprobe -=20
> This is scsi wrapper portion.
>=20
> ---------------------------------------------------
> Adding support for exposing hidden raid components=20
> for sg interface. The sdev->no_uld_attach flag
> will set set accordingly.
>=20
> The sas module supports adding/removing raid
> volumes using online storage management application
> interface. =20
>=20
> This patch was provided to me by Christoph Hellwig.
>=20
> Signed-off-by: Eric Moore <Eric.Moore@lsil.com>
>

repost ( hopefully not mangled).

Eric Moore=20

------_=_NextPart_001_01C647B2.F9217612
Content-Type: application/octet-stream;
	name="scsi_device_reprobe"
Content-Transfer-Encoding: base64
Content-Description: scsi_device_reprobe
Content-Disposition: attachment;
	filename="scsi_device_reprobe"

SW5kZXg6IHNjc2ktbWlzYy0yLjYvZHJpdmVycy9zY3NpL3Njc2kuYwo9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBz
Y3NpLW1pc2MtMi42Lm9yaWcvZHJpdmVycy9zY3NpL3Njc2kuYwkyMDA2LTAzLTA0IDEzOjA3OjQ0
LjAwMDAwMDAwMCArMDEwMAorKysgc2NzaS1taXNjLTIuNi9kcml2ZXJzL3Njc2kvc2NzaS5jCTIw
MDYtMDMtMDcgMjE6NTc6MjEuMDAwMDAwMDAwICswMTAwCkBAIC0xMjE0LDYgKzEyMTQsMTMgQEAK
IH0KIEVYUE9SVF9TWU1CT0woc2NzaV9kZXZpY2VfY2FuY2VsKTsKIAordm9pZCBzY3NpX2Rldmlj
ZV9yZXByb2JlKHN0cnVjdCBzY3NpX2RldmljZSAqc2RldikKK3sKKwlkZXZpY2VfcmVwcm9iZSgm
c2Rldi0+c2Rldl9nZW5kZXYpOworfQorCitFWFBPUlRfU1lNQk9MX0dQTChzY3NpX2RldmljZV9y
ZXByb2JlKTsKKwogTU9EVUxFX0RFU0NSSVBUSU9OKCJTQ1NJIGNvcmUiKTsKIE1PRFVMRV9MSUNF
TlNFKCJHUEwiKTsKIApJbmRleDogc2NzaS1taXNjLTIuNi9pbmNsdWRlL3Njc2kvc2NzaV9kZXZp
Y2UuaAo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09Ci0tLSBzY3NpLW1pc2MtMi42Lm9yaWcvaW5jbHVkZS9zY3NpL3Njc2lf
ZGV2aWNlLmgJMjAwNi0wMy0wNCAxMzowNzo0OS4wMDAwMDAwMDAgKzAxMDAKKysrIHNjc2ktbWlz
Yy0yLjYvaW5jbHVkZS9zY3NpL3Njc2lfZGV2aWNlLmgJMjAwNi0wMy0wNyAyMTo1Nzo0NS4wMDAw
MDAwMDAgKzAxMDAKQEAgLTIwNCw2ICsyMDQsNyBAQAogCQkJICAgdWludCB0YXJnZXQsIHVpbnQg
bHVuKTsKIGV4dGVybiB2b2lkIHNjc2lfcmVtb3ZlX2RldmljZShzdHJ1Y3Qgc2NzaV9kZXZpY2Ug
Kik7CiBleHRlcm4gaW50IHNjc2lfZGV2aWNlX2NhbmNlbChzdHJ1Y3Qgc2NzaV9kZXZpY2UgKiwg
aW50KTsKK2V4dGVybiB2b2lkIHNjc2lfZGV2aWNlX3JlcHJvYmUoc3RydWN0IHNjc2lfZGV2aWNl
ICopOwogCiBleHRlcm4gaW50IHNjc2lfZGV2aWNlX2dldChzdHJ1Y3Qgc2NzaV9kZXZpY2UgKik7
CiBleHRlcm4gdm9pZCBzY3NpX2RldmljZV9wdXQoc3RydWN0IHNjc2lfZGV2aWNlICopOwo=

------_=_NextPart_001_01C647B2.F9217612--
