Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129801AbQLLVPj>; Tue, 12 Dec 2000 16:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129761AbQLLVPa>; Tue, 12 Dec 2000 16:15:30 -0500
Received: from [195.44.156.246] ([195.44.156.246]:1540 "EHLO Consulate.UFP.CX")
	by vger.kernel.org with ESMTP id <S129824AbQLLVPV>;
	Tue, 12 Dec 2000 16:15:21 -0500
Posted-Date: Tue, 12 Dec 2000 14:28:01 GMT
Date: Tue, 12 Dec 2000 14:28:01 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.CX>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.2.18: Patch to SysRq code
Message-ID: <Pine.LNX.4.21.0012121410110.5152-200000@MemAlpha.CX>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463746820-1276165308-976631281=:5152"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463746820-1276165308-976631281=:5152
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi Alan.

The enclosed patch deals with two problems relating to the Magic SysRq
function, as follows:

 1. One of my pet peeves with SysRq as implemented is the apparently
    random order theoptions as listed in the SysRq help list. This
    patch sorts that list into case-insensitive alphabetical order.

 2. According to the above-mentioned help list, the log level can be
    set in the range 0 to 8. The code additionally allows log level
    9 to be set, so this was added to the list.

Best wishes from Riley.

---1463746820-1276165308-976631281=:5152
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="sysrq-1.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0012121428010.5152@Consulate.UFP.CX>
Content-Description: Patch to sysrq.c
Content-Disposition: attachment; filename="sysrq-1.diff"

ZGlmZiAtdXJOIGxpbnV4LTIuMi4xOC5vbGQvZHJpdmVycy9jaGFyL3N5c3Jx
LmMgbGludXgtMi4yLjE4L2RyaXZlcnMvY2hhci9zeXNycS5jDQotLS0gbGlu
dXgtMi4yLjE4Lm9sZC9kcml2ZXJzL2NoYXIvc3lzcnEuYwlUaHUgTWF5ICA0
IDAxOjE2OjM5IDIwMDANCisrKyBsaW51eC0yLjIuMTgvZHJpdmVycy9jaGFy
L3N5c3JxLmMJVHVlIERlYyAxMiAxMzoyMzoyMyAyMDAwDQpAQCAtMTM0LDE2
ICsxMzQsMTggQEANCiAJCW9yaWdfbG9nX2xldmVsID0gODsNCiAJCWJyZWFr
Ow0KIAlkZWZhdWx0OgkJCQkJICAgIC8qIFVua25vd246IGhlbHAgKi8NCi0J
CWlmIChrYmQpDQotCQkJcHJpbnRrKCJ1blJhdyAiKTsNCisJCXByaW50aygi
Qm9vdCBrSWxsIGtpbGxhbEwgbG9nbGV2ZWwwLTkgIik7DQorCQlpZiAoc3lz
cnFfcG93ZXJfb2ZmKQ0KKwkJCXByaW50aygiT2ZmICIpOw0KICNpZmRlZiBD
T05GSUdfVlQNCiAJCWlmICh0dHkpDQogCQkJcHJpbnRrKCJzYUsgIik7DQog
I2VuZGlmDQotCQlwcmludGsoIkJvb3QgIik7DQotCQlpZiAoc3lzcnFfcG93
ZXJfb2ZmKQ0KLQkJCXByaW50aygiT2ZmICIpOw0KLQkJcHJpbnRrKCJTeW5j
IFVubW91bnQgc2hvd1BjIHNob3dUYXNrcyBzaG93TWVtIGxvZ2xldmVsMC04
IHRFcm0ga0lsbCBraWxsYWxMXG4iKTsNCisJCXByaW50aygic2hvd01lbSBz
aG93UGMgc2hvd1Rhc2tzIFN5bmMgdEVybSBVbm1vdW50ICIpOw0KKwkJaWYg
KGtiZCkNCisJCQlwcmludGsoInVuUmF3ICIpOw0KKwkJcHJpbnRrKCJcbiIp
Ow0KKw0KIAkJLyogRG9uJ3QgdXNlICdBJyBhcyBpdCdzIGhhbmRsZWQgc3Bl
Y2lhbGx5IG9uIHRoZSBTcGFyYyAqLw0KIAl9DQogDQo=
---1463746820-1276165308-976631281=:5152--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
