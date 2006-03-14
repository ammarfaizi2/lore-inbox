Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964772AbWCNWB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbWCNWB0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 17:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbWCNWBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 17:01:25 -0500
Received: from mail0.lsil.com ([147.145.40.20]:16328 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S964772AbWCNWBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 17:01:24 -0500
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C647B2.CA8974BF"
Subject: RE: [PATCH ] drivers/base/bus.c - export reprobe
Date: Tue, 14 Mar 2006 15:01:05 -0700
Message-ID: <F331B95B72AFFB4B87467BE1C8E9CF5F36DC3B@NAMAIL2.ad.lsil.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH ] drivers/base/bus.c - export reprobe
Thread-Index: AcZHkNFH+qc4WJNiTi+3jwREy8AsQwAIbINQ
From: "Moore, Eric" <Eric.Moore@lsil.com>
To: "Greg KH" <gregkh@suse.de>,
       "James Bottomley" <James.Bottomley@SteelEye.com>
Cc: "Christoph Hellwig" <hch@infradead.org>, <linux-scsi@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <hch@lst.de>
X-OriginalArrivalTime: 14 Mar 2006 22:01:05.0524 (UTC) FILETIME=[CA965B40:01C647B2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C647B2.CA8974BF
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

On Tuesday, March 14, 2006 10:58 AM,  Greg KH wrote:

>=20
> Sure, that makes a lot of sense:
>=20
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
>=20
> Oh, and please make that scsi wrapper function either
> EXPORT_SYMBOL_GPL() or an inline function or macro.
>=20
> thanks,
>=20


Here we go again (hopefully no managled this time).

I'll repost the other patch with EXPORT_SYMBOL_GPL.

Eric Moore


------_=_NextPart_001_01C647B2.CA8974BF
Content-Type: application/octet-stream;
	name="rescan_device"
Content-Transfer-Encoding: base64
Content-Description: rescan_device
Content-Disposition: attachment;
	filename="rescan_device"

SW5kZXg6IHNjc2ktbWlzYy0yLjYvZHJpdmVycy9iYXNlL2J1cy5jCj09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIHNj
c2ktbWlzYy0yLjYub3JpZy9kcml2ZXJzL2Jhc2UvYnVzLmMJMjAwNi0wMy0wNCAxMzowNzo0MC4w
MDAwMDAwMDAgKzAxMDAKKysrIHNjc2ktbWlzYy0yLjYvZHJpdmVycy9iYXNlL2J1cy5jCTIwMDYt
MDMtMDcgMjE6MDY6NTkuMDAwMDAwMDAwICswMTAwCkBAIC01MzYsNiArNTM2LDI4IEBACiAJYnVz
X2Zvcl9lYWNoX2RldihidXMsIE5VTEwsIE5VTEwsIGJ1c19yZXNjYW5fZGV2aWNlc19oZWxwZXIp
OwogfQogCisvKioKKyAqIGRldmljZV9yZXByb2JlIC0gcmVtb3ZlIGRyaXZlciBmb3IgYSBkZXZp
Y2UgYW5kIHByb2JlIGZvciBhIG5ldyBkcml2ZXIKKyAqIEBkZXY6IHRoZSBkZXZpY2UgdG8gcmVw
cm9iZQorICoKKyAqIFRoaXMgZnVuY3Rpb24gZGV0YWNoZXMgdGhlIGF0dGFjaGVkIGRyaXZlciAo
aWYgYW55KSBmb3IgdGhlIGdpdmVuCisgKiBkZXZpY2UgYW5kIHJlc3RhcnRzIHRoZSBkcml2ZXIg
cHJvYmluZyBwcm9jZXNzLiAgSXQgaXMgaW50ZW5kZWQKKyAqIHRvIHVzZSBpZiBwcm9iaW5nIGNy
aXRlcmlhIGNoYW5nZWQgZHVyaW5nIGEgZGV2aWNlcyBsaWZldGltZSBhbmQKKyAqIGRyaXZlciBh
dHRhY2htZW50IHNob3VsZCBjaGFuZ2UgYWNjb3JkaW5nbHkuCisgKi8KK3ZvaWQgZGV2aWNlX3Jl
cHJvYmUoc3RydWN0IGRldmljZSAqZGV2KQoreworCWlmIChkZXYtPmRyaXZlcikgeworCQlpZiAo
ZGV2LT5wYXJlbnQpICAgICAgICAvKiBOZWVkZWQgZm9yIFVTQiAqLworCQkJZG93bigmZGV2LT5w
YXJlbnQtPnNlbSk7CisJCWRldmljZV9yZWxlYXNlX2RyaXZlcihkZXYpOworCQlpZiAoZGV2LT5w
YXJlbnQpCisJCQl1cCgmZGV2LT5wYXJlbnQtPnNlbSk7CisJfQorCisJYnVzX3Jlc2Nhbl9kZXZp
Y2VzX2hlbHBlcihkZXYsIE5VTEwpOworfQorRVhQT1JUX1NZTUJPTF9HUEwoZGV2aWNlX3JlcHJv
YmUpOwogCiBzdHJ1Y3QgYnVzX3R5cGUgKiBnZXRfYnVzKHN0cnVjdCBidXNfdHlwZSAqIGJ1cykK
IHsKSW5kZXg6IHNjc2ktbWlzYy0yLjYvaW5jbHVkZS9saW51eC9kZXZpY2UuaAo9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
Ci0tLSBzY3NpLW1pc2MtMi42Lm9yaWcvaW5jbHVkZS9saW51eC9kZXZpY2UuaAkyMDA2LTAzLTA0
IDEzOjA3OjQ5LjAwMDAwMDAwMCArMDEwMAorKysgc2NzaS1taXNjLTIuNi9pbmNsdWRlL2xpbnV4
L2RldmljZS5oCTIwMDYtMDMtMDcgMjA6NTM6NDMuMDAwMDAwMDAwICswMTAwCkBAIC0zNzgsNiAr
Mzc4LDcgQEAKIGV4dGVybiB2b2lkIGRldmljZV9yZWxlYXNlX2RyaXZlcihzdHJ1Y3QgZGV2aWNl
ICogZGV2KTsKIGV4dGVybiBpbnQgIGRldmljZV9hdHRhY2goc3RydWN0IGRldmljZSAqIGRldik7
CiBleHRlcm4gdm9pZCBkcml2ZXJfYXR0YWNoKHN0cnVjdCBkZXZpY2VfZHJpdmVyICogZHJ2KTsK
K2V4dGVybiB2b2lkIGRldmljZV9yZXByb2JlKHN0cnVjdCBkZXZpY2UgKmRldik7CiAKIAogLyoK

------_=_NextPart_001_01C647B2.CA8974BF--
