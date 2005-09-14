Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964991AbVINC41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbVINC41 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 22:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932574AbVINC41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 22:56:27 -0400
Received: from wdscexfe02.sc.wdc.com ([129.253.170.52]:26645 "EHLO
	wdscexfe02.sc.wdc.com") by vger.kernel.org with ESMTP
	id S932570AbVINC41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 22:56:27 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C5B8D7.E73115DD"
Subject: [RESEND][PATCH 2.6.14-rc1] scsi: sd, sr, st, and scsi_lib all fail to copy cmd_len to new cmd
Date: Tue, 13 Sep 2005 19:56:28 -0700
Message-ID: <CA45571DE57E1C45BF3552118BA92C9D69BDE9@WDSCEXBECL03.sc.wdc.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.14-rc1] scsi: sd, sr, st, and scsi_lib all fail to copy cmd_len to new cmd
Thread-Index: AcW4v7oRdreQAaYMTVCvuZCzLZPHIwAF8Z3A
From: "Timothy Thelin" <Timothy.Thelin@wdc.com>
To: "James Bottomley" <James.Bottomley@SteelEye.com>,
       "Mike Christie" <michaelc@cs.wisc.edu>,
       "SCSI Mailing List" <linux-scsi@vger.kernel.org>
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 14 Sep 2005 02:56:22.0867 (UTC) FILETIME=[E3C3DA30:01C5B8D7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5B8D7.E73115DD
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Sorry it wrapped.  It's now an attachment.

This fixes an issue in scsi command initialization from a request
where sd, sr, st, and scsi_lib all fail to copy the request's
cmd_len to the scsi command's cmd_len field.

Signed-off-by: Timothy Thelin <timothy.thelin@wdc.com>

------_=_NextPart_001_01C5B8D7.E73115DD
Content-Type: application/octet-stream;
	name="scsi-sd-sr-st-and-scsi_lib-all-fail-to-copy-cmd_len-to-new-cmd.patch"
Content-Transfer-Encoding: base64
Content-Description: scsi-sd-sr-st-and-scsi_lib-all-fail-to-copy-cmd_len-to-new-cmd.patch
Content-Disposition: attachment;
	filename="scsi-sd-sr-st-and-scsi_lib-all-fail-to-copy-cmd_len-to-new-cmd.patch"

ZGlmZiAtcHUgbGludXgtMi42LjE0LXJjMS5vcmlnL2RyaXZlcnMvc2NzaS9zY3NpX2xpYi5jIGxp
bnV4LTIuNi4xNC1yYzEvZHJpdmVycy9zY3NpL3Njc2lfbGliLmMKLS0tIGxpbnV4LTIuNi4xNC1y
YzEub3JpZy9kcml2ZXJzL3Njc2kvc2NzaV9saWIuYwkyMDA1LTA5LTEyIDIwOjEyOjA5LjAwMDAw
MDAwMCAtMDcwMAorKysgbGludXgtMi42LjE0LXJjMS9kcml2ZXJzL3Njc2kvc2NzaV9saWIuYwky
MDA1LTA5LTEzIDE2OjI4OjU4LjAwMDAwMDAwMCAtMDcwMApAQCAtMTI2OCw2ICsxMjY4LDcgQEAg
c3RhdGljIGludCBzY3NpX3ByZXBfZm4oc3RydWN0IHJlcXVlc3RfcQogCQkJfQogCQl9IGVsc2Ug
ewogCQkJbWVtY3B5KGNtZC0+Y21uZCwgcmVxLT5jbWQsIHNpemVvZihjbWQtPmNtbmQpKTsKKwkJ
CWNtZC0+Y21kX2xlbiA9IHJlcS0+Y21kX2xlbjsKIAkJCWlmIChycV9kYXRhX2RpcihyZXEpID09
IFdSSVRFKQogCQkJCWNtZC0+c2NfZGF0YV9kaXJlY3Rpb24gPSBETUFfVE9fREVWSUNFOwogCQkJ
ZWxzZSBpZiAocmVxLT5kYXRhX2xlbikKZGlmZiAtcHUgbGludXgtMi42LjE0LXJjMS5vcmlnL2Ry
aXZlcnMvc2NzaS9zZC5jIGxpbnV4LTIuNi4xNC1yYzEvZHJpdmVycy9zY3NpL3NkLmMKLS0tIGxp
bnV4LTIuNi4xNC1yYzEub3JpZy9kcml2ZXJzL3Njc2kvc2QuYwkyMDA1LTA5LTEyIDIwOjEyOjA5
LjAwMDAwMDAwMCAtMDcwMAorKysgbGludXgtMi42LjE0LXJjMS9kcml2ZXJzL3Njc2kvc2QuYwky
MDA1LTA5LTEzIDE2OjAzOjIwLjAwMDAwMDAwMCAtMDcwMApAQCAtMjM1LDYgKzIzNSw3IEBAIHN0
YXRpYyBpbnQgc2RfaW5pdF9jb21tYW5kKHN0cnVjdCBzY3NpX2MKIAkJCXJldHVybiAwOwogCiAJ
CW1lbWNweShTQ3BudC0+Y21uZCwgcnEtPmNtZCwgc2l6ZW9mKFNDcG50LT5jbW5kKSk7CisJCVND
cG50LT5jbWRfbGVuID0gcnEtPmNtZF9sZW47CiAJCWlmIChycV9kYXRhX2RpcihycSkgPT0gV1JJ
VEUpCiAJCQlTQ3BudC0+c2NfZGF0YV9kaXJlY3Rpb24gPSBETUFfVE9fREVWSUNFOwogCQllbHNl
IGlmIChycS0+ZGF0YV9sZW4pCmRpZmYgLXB1IGxpbnV4LTIuNi4xNC1yYzEub3JpZy9kcml2ZXJz
L3Njc2kvc3IuYyBsaW51eC0yLjYuMTQtcmMxL2RyaXZlcnMvc2NzaS9zci5jCi0tLSBsaW51eC0y
LjYuMTQtcmMxLm9yaWcvZHJpdmVycy9zY3NpL3NyLmMJMjAwNS0wOS0xMiAyMDoxMjowOS4wMDAw
MDAwMDAgLTA3MDAKKysrIGxpbnV4LTIuNi4xNC1yYzEvZHJpdmVycy9zY3NpL3NyLmMJMjAwNS0w
OS0xMyAxNjowNTo0Ny4wMDAwMDAwMDAgLTA3MDAKQEAgLTMyNiw2ICszMjYsNyBAQCBzdGF0aWMg
aW50IHNyX2luaXRfY29tbWFuZChzdHJ1Y3Qgc2NzaV9jCiAJCQlyZXR1cm4gMDsKIAogCQltZW1j
cHkoU0NwbnQtPmNtbmQsIHJxLT5jbWQsIHNpemVvZihTQ3BudC0+Y21uZCkpOworCQlTQ3BudC0+
Y21kX2xlbiA9IHJxLT5jbWRfbGVuOwogCQlpZiAoIXJxLT5kYXRhX2xlbikKIAkJCVNDcG50LT5z
Y19kYXRhX2RpcmVjdGlvbiA9IERNQV9OT05FOwogCQllbHNlIGlmIChycV9kYXRhX2RpcihycSkg
PT0gV1JJVEUpCmRpZmYgLXB1IGxpbnV4LTIuNi4xNC1yYzEub3JpZy9kcml2ZXJzL3Njc2kvc3Qu
YyBsaW51eC0yLjYuMTQtcmMxL2RyaXZlcnMvc2NzaS9zdC5jCi0tLSBsaW51eC0yLjYuMTQtcmMx
Lm9yaWcvZHJpdmVycy9zY3NpL3N0LmMJMjAwNS0wOS0xMiAyMDoxMjowOS4wMDAwMDAwMDAgLTA3
MDAKKysrIGxpbnV4LTIuNi4xNC1yYzEvZHJpdmVycy9zY3NpL3N0LmMJMjAwNS0wOS0xMyAxNjow
NDoxMC4wMDAwMDAwMDAgLTA3MDAKQEAgLTQyMDYsNiArNDIwNiw3IEBAIHN0YXRpYyBpbnQgc3Rf
aW5pdF9jb21tYW5kKHN0cnVjdCBzY3NpX2MKIAkJcmV0dXJuIDA7CiAKIAltZW1jcHkoU0NwbnQt
PmNtbmQsIHJxLT5jbWQsIHNpemVvZihTQ3BudC0+Y21uZCkpOworCVNDcG50LT5jbWRfbGVuID0g
cnEtPmNtZF9sZW47CiAKIAlpZiAocnFfZGF0YV9kaXIocnEpID09IFdSSVRFKQogCQlTQ3BudC0+
c2NfZGF0YV9kaXJlY3Rpb24gPSBETUFfVE9fREVWSUNFOwo=

------_=_NextPart_001_01C5B8D7.E73115DD--
