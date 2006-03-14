Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932519AbWCNAx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519AbWCNAx0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 19:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbWCNAxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 19:53:24 -0500
Received: from mail0.lsil.com ([147.145.40.20]:23724 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1751899AbWCNAxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 19:53:01 -0500
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C64701.98835826"
Subject: [PATCH ] drivers/base/bus.c - export reprobe 
Date: Mon, 13 Mar 2006 17:52:40 -0700
Message-ID: <F331B95B72AFFB4B87467BE1C8E9CF5F36D829@NAMAIL2.ad.lsil.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH ] drivers/base/bus.c - export reprobe 
Thread-Index: AcZHAZhHx+OADI8TSLCWZZlP7NutMw==
From: "Moore, Eric" <Eric.Moore@lsil.com>
To: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <James.Bottomley@SteelEye.com>, <hch@lst.de>, <gregkh@novell.com>
X-OriginalArrivalTime: 14 Mar 2006 00:52:40.0863 (UTC) FILETIME=[98ACAAF0:01C64701]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C64701.98835826
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Request for exporting device_reprobe -=20

Adding support for exposing hidden raid components=20
for sg interface. The sdev->no_uld_attach flag
will set set accordingly.

The sas module supports adding/removing raid
volumes using online storage management application
interface. =20

This patch was provided to me by Christoph Hellwig.

Signed-off-by: Eric Moore <Eric.Moore@lsil.com>

------_=_NextPart_001_01C64701.98835826
Content-Type: application/octet-stream;
	name="rescan_device"
Content-Transfer-Encoding: base64
Content-Description: rescan_device
Content-Disposition: attachment;
	filename="rescan_device"

SW5kZXg6IHNjc2ktbWlzYy0yLjYvZHJpdmVycy9iYXNlL2J1cy5jDQo9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQotLS0g
c2NzaS1taXNjLTIuNi5vcmlnL2RyaXZlcnMvYmFzZS9idXMuYwkyMDA2LTAzLTA0IDEzOjA3OjQw
LjAwMDAwMDAwMCArMDEwMA0KKysrIHNjc2ktbWlzYy0yLjYvZHJpdmVycy9iYXNlL2J1cy5jCTIw
MDYtMDMtMDcgMjE6MDY6NTkuMDAwMDAwMDAwICswMTAwDQpAQCAtNTM2LDYgKzUzNiwyOCBAQA0K
IAlidXNfZm9yX2VhY2hfZGV2KGJ1cywgTlVMTCwgTlVMTCwgYnVzX3Jlc2Nhbl9kZXZpY2VzX2hl
bHBlcik7DQogfQ0KIA0KKy8qKg0KKyAqIGRldmljZV9yZXByb2JlIC0gcmVtb3ZlIGRyaXZlciBm
b3IgYSBkZXZpY2UgYW5kIHByb2JlIGZvciBhIG5ldyBkcml2ZXINCisgKiBAZGV2OiB0aGUgZGV2
aWNlIHRvIHJlcHJvYmUNCisgKg0KKyAqIFRoaXMgZnVuY3Rpb24gZGV0YWNoZXMgdGhlIGF0dGFj
aGVkIGRyaXZlciAoaWYgYW55KSBmb3IgdGhlIGdpdmVuDQorICogZGV2aWNlIGFuZCByZXN0YXJ0
cyB0aGUgZHJpdmVyIHByb2JpbmcgcHJvY2Vzcy4gIEl0IGlzIGludGVuZGVkDQorICogdG8gdXNl
IGlmIHByb2JpbmcgY3JpdGVyaWEgY2hhbmdlZCBkdXJpbmcgYSBkZXZpY2VzIGxpZmV0aW1lIGFu
ZA0KKyAqIGRyaXZlciBhdHRhY2htZW50IHNob3VsZCBjaGFuZ2UgYWNjb3JkaW5nbHkuDQorICov
DQordm9pZCBkZXZpY2VfcmVwcm9iZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQorew0KKwlpZiAoZGV2
LT5kcml2ZXIpIHsNCisJCWlmIChkZXYtPnBhcmVudCkgICAgICAgIC8qIE5lZWRlZCBmb3IgVVNC
ICovDQorCQkJZG93bigmZGV2LT5wYXJlbnQtPnNlbSk7DQorCQlkZXZpY2VfcmVsZWFzZV9kcml2
ZXIoZGV2KTsNCisJCWlmIChkZXYtPnBhcmVudCkNCisJCQl1cCgmZGV2LT5wYXJlbnQtPnNlbSk7
DQorCX0NCisNCisJYnVzX3Jlc2Nhbl9kZXZpY2VzX2hlbHBlcihkZXYsIE5VTEwpOw0KK30NCitF
WFBPUlRfU1lNQk9MX0dQTChkZXZpY2VfcmVwcm9iZSk7DQogDQogc3RydWN0IGJ1c190eXBlICog
Z2V0X2J1cyhzdHJ1Y3QgYnVzX3R5cGUgKiBidXMpDQogew0KSW5kZXg6IHNjc2ktbWlzYy0yLjYv
aW5jbHVkZS9saW51eC9kZXZpY2UuaA0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KLS0tIHNjc2ktbWlzYy0yLjYub3Jp
Zy9pbmNsdWRlL2xpbnV4L2RldmljZS5oCTIwMDYtMDMtMDQgMTM6MDc6NDkuMDAwMDAwMDAwICsw
MTAwDQorKysgc2NzaS1taXNjLTIuNi9pbmNsdWRlL2xpbnV4L2RldmljZS5oCTIwMDYtMDMtMDcg
MjA6NTM6NDMuMDAwMDAwMDAwICswMTAwDQpAQCAtMzc4LDYgKzM3OCw3IEBADQogZXh0ZXJuIHZv
aWQgZGV2aWNlX3JlbGVhc2VfZHJpdmVyKHN0cnVjdCBkZXZpY2UgKiBkZXYpOw0KIGV4dGVybiBp
bnQgIGRldmljZV9hdHRhY2goc3RydWN0IGRldmljZSAqIGRldik7DQogZXh0ZXJuIHZvaWQgZHJp
dmVyX2F0dGFjaChzdHJ1Y3QgZGV2aWNlX2RyaXZlciAqIGRydik7DQorZXh0ZXJuIHZvaWQgZGV2
aWNlX3JlcHJvYmUoc3RydWN0IGRldmljZSAqZGV2KTsNCiANCiANCiAvKg0K

------_=_NextPart_001_01C64701.98835826--
