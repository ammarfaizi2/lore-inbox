Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbTFOLBo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 07:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbTFOLBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 07:01:44 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:48807 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262135AbTFOLBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 07:01:43 -0400
Message-Id: <5.1.0.14.2.20030615125117.00af6428@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 15 Jun 2003 13:12:03 +0200
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: Sensors patch 2.5.71
Cc: Greg KH <greg@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_10585521==_"
X-Seen: false
X-ID: XNY2jOZvQeEUnJdChYw6MmcqVuN5oCwAliXqzWPwLJqOplmhK72ngH@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=====================_10585521==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

Patch for adm1021
This corrects temp reporting and a major error whereby
"alarms" and "die_code" were being put though the "TEMP" macro.
Compiled but don't have the hardware to test.
Greg, can you push ?
The lm85 patch that I sent also, of course, applies to 2.5.71 and can be pushed
as is.

Margit
--=====================_10585521==_
Content-Type: application/octet-stream; name="sensorspatch2571"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="sensorspatch2571"

ZGlmZiAtTmF1ciBsaW51eC0yLjUuNzEvZHJpdmVycy9pMmMvY2hpcHMvYWRtMTAyMS5jIGxpbnV4
LTIuNS43MW13L2RyaXZlcnMvaTJjL2NoaXBzL2FkbTEwMjEuYwotLS0gbGludXgtMi41LjcxL2Ry
aXZlcnMvaTJjL2NoaXBzL2FkbTEwMjEuYwkyMDAzLTA2LTE0IDIxOjE3OjU2LjAwMDAwMDAwMCAr
MDIwMAorKysgbGludXgtMi41LjcxbXcvZHJpdmVycy9pMmMvY2hpcHMvYWRtMTAyMS5jCTIwMDMt
MDYtMTUgMTI6Mjg6MDIuMDAwMDAwMDAwICswMjAwCkBAIC04OCw4ICs4OCw4IEBACiAgICB0aGVz
ZSBtYWNyb3MgYXJlIGNhbGxlZDogYXJndW1lbnRzIG1heSBiZSBldmFsdWF0ZWQgbW9yZSB0aGFu
IG9uY2UuCiAgICBGaXhpbmcgdGhpcyBpcyBqdXN0IG5vdCB3b3J0aCBpdC4gKi8KIC8qIENvbnZl
cnNpb25zICBub3RlOiAxMDIxIHVzZXMgbm9ybWFsIGludGVnZXIgc2lnbmVkLWJ5dGUgZm9ybWF0
Ki8KLSNkZWZpbmUgVEVNUF9GUk9NX1JFRyh2YWwpCSh2YWwgPiAxMjcgPyB2YWwtMjU2IDogdmFs
KQotI2RlZmluZSBURU1QX1RPX1JFRyh2YWwpCShTRU5TT1JTX0xJTUlUKCh2YWwgPCAwID8gdmFs
KzI1NiA6IHZhbCksMCwyNTUpKQorI2RlZmluZSBURU1QX0ZST01fUkVHKHZhbCkJKHZhbCA+IDEy
NyA/ICh2YWwtMjU2KSoxMDAwIDogdmFsKjEwMDApCisjZGVmaW5lIFRFTVBfVE9fUkVHKHZhbCkJ
KFNFTlNPUlNfTElNSVQoKHZhbCA8IDAgPyAodmFsLzEwMDApKzI1NiA6IHZhbC8xMDAwKSwwLDI1
NSkpCiAKIC8qIEluaXRpYWwgdmFsdWVzICovCiAKQEAgLTE3Miw4ICsxNzIsMTggQEAKIHNob3co
cmVtb3RlX3RlbXBfbWF4KTsKIHNob3cocmVtb3RlX3RlbXBfaHlzdCk7CiBzaG93KHJlbW90ZV90
ZW1wX2lucHV0KTsKLXNob3coYWxhcm1zKTsKLXNob3coZGllX2NvZGUpOworCisjZGVmaW5lIHNo
b3cyKHZhbHVlKQlcCitzdGF0aWMgc3NpemVfdCBzaG93XyMjdmFsdWUoc3RydWN0IGRldmljZSAq
ZGV2LCBjaGFyICpidWYpCVwKK3sJCQkJCQkJCVwKKwlzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50
ID0gdG9faTJjX2NsaWVudChkZXYpOwkJXAorCXN0cnVjdCBhZG0xMDIxX2RhdGEgKmRhdGEgPSBp
MmNfZ2V0X2NsaWVudGRhdGEoY2xpZW50KTsJXAorCQkJCQkJCQlcCisJYWRtMTAyMV91cGRhdGVf
Y2xpZW50KGNsaWVudCk7CQkJCVwKKwlyZXR1cm4gc3ByaW50ZihidWYsICIlZFxuIiwgZGF0YS0+
dmFsdWUpOwkJXAorfQorc2hvdzIoYWxhcm1zKTsKK3Nob3cyKGRpZV9jb2RlKTsKIAogI2RlZmlu
ZSBzZXQodmFsdWUsIHJlZykJXAogc3RhdGljIHNzaXplX3Qgc2V0XyMjdmFsdWUoc3RydWN0IGRl
dmljZSAqZGV2LCBjb25zdCBjaGFyICpidWYsIHNpemVfdCBjb3VudCkJXAo=
--=====================_10585521==_--

