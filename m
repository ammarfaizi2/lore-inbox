Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267664AbUG3JLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267664AbUG3JLt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 05:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267661AbUG3JLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 05:11:49 -0400
Received: from webmail-benelux.tiscali.be ([62.235.14.106]:56284 "EHLO
	mail.tiscali.be") by vger.kernel.org with ESMTP id S267665AbUG3JLn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 05:11:43 -0400
Date: Fri, 30 Jul 2004 11:11:32 +0200
Message-ID: <40FB9ACA0000533F@ocpmta1.freegates.net>
In-Reply-To: <1090945884.30149.1.camel@dionysus>
From: "Joel Soete" <soete.joel@tiscali.be>
Subject: Re: Some cleanup patches for: '...lvalues is deprecated'
To: "Jon Oberheide" <jon@oberheide.org>
Cc: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>,
       "Daniel Jacobowitz" <dan@debian.org>,
       "Vojtech Pavlik" <vojtech@suse.cz>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="========/40FB9ACA0000533F/mail.tiscali.be"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--========/40FB9ACA0000533F/mail.tiscali.be
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello *,

> 
> FYI, lvalue casts are treated as errors in gcc 3.5.
> 
According to this kind remark, I think so that following attachement patc=
hes
would be interesting.
Thanks for all relevant remarks to help me to make stuff cleaner.

Joel

PS: I don't yet review the lib/crc32.c (sorry I need more effort to revie=
w)


-------------------------------------------------------------------------=
--
Tiscali ADSL LIGHT, 19,95 EUR/mois pendant 6 mois, c'est le moment de fai=
re
le pas!
http://reg.tiscali.be/default.asp?lg=3Dfr





--========/40FB9ACA0000533F/mail.tiscali.be
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="drivers-video-fbcon.diff"

LS0tIGxpbnV4LTIuNC4yNy1yYzMtcGE2bW0vZHJpdmVycy92aWRlby9mYmNvbi5jLk9yaWcJMjAw
NC0wNi0yOSAxMDo0NzozMS4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNC4yNy1yYzMtcGE2
bW0vZHJpdmVycy92aWRlby9mYmNvbi5jCTIwMDQtMDctMzAgMDk6MjE6NDMuMjk1ODI4NTIwICsw
MjAwCkBAIC0xODc3LDcgKzE4NzcsMTAgQEAKICAgICAgICBmb250IGxlbmd0aCBtdXN0IGJlIG11
bHRpcGxlIG9mIDI1NiwgYXQgbGVhc3QuIEFuZCAyNTYgaXMgbXVsdGlwbGUKICAgICAgICBvZiA0
ICovCiAgICAgayA9IDA7Ci0gICAgd2hpbGUgKHAgPiBuZXdfZGF0YSkgayArPSAqLS0odTMyICop
cDsKKyAgICB3aGlsZSAocCA+IG5ld19kYXRhKSB7CisJcCAtPSA0OworCWsgKz0gKih1MzIgKilw
OworICAgIH0KICAgICBGTlRTVU0obmV3X2RhdGEpID0gazsKICAgICAvKiBDaGVjayBpZiB0aGUg
c2FtZSBmb250IGlzIG9uIHNvbWUgb3RoZXIgY29uc29sZSBhbHJlYWR5ICovCiAgICAgZm9yIChp
ID0gMDsgaSA8IE1BWF9OUl9DT05TT0xFUzsgaSsrKSB7Cg==


--========/40FB9ACA0000533F/mail.tiscali.be
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="fs-readdir.diff"

LS0tIGxpbnV4LTIuNC4yNy1yYzMtcGE2bW0vZnMvcmVhZGRpci5jLk9yaWcJMjAwNC0wNi0yOSAx
MToxODo0Ni4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNC4yNy1yYzMtcGE2bW0vZnMvcmVh
ZGRpci5jCTIwMDQtMDctMjkgMTI6NTQ6NDUuMDAwMDAwMDAwICswMjAwCkBAIC0yNjQsNyArMjY0
LDcgQEAKIAlwdXRfdXNlcihyZWNsZW4sICZkaXJlbnQtPmRfcmVjbGVuKTsKIAljb3B5X3RvX3Vz
ZXIoZGlyZW50LT5kX25hbWUsIG5hbWUsIG5hbWxlbik7CiAJcHV0X3VzZXIoMCwgZGlyZW50LT5k
X25hbWUgKyBuYW1sZW4pOwotCSgoY2hhciAqKSBkaXJlbnQpICs9IHJlY2xlbjsKKwlkaXJlbnQg
PSAoc3RydWN0IGxpbnV4X2RpcmVudCAqKSgoY2hhciAqKWRpcmVudCArIHJlY2xlbik7CiAJYnVm
LT5jdXJyZW50X2RpciA9IGRpcmVudDsKIAlidWYtPmNvdW50IC09IHJlY2xlbjsKIAlyZXR1cm4g
MDsKQEAgLTM0Nyw3ICszNDcsNyBAQAogCWNvcHlfdG9fdXNlcihkaXJlbnQsICZkLCBOQU1FX09G
RlNFVCgmZCkpOwogCWNvcHlfdG9fdXNlcihkaXJlbnQtPmRfbmFtZSwgbmFtZSwgbmFtbGVuKTsK
IAlwdXRfdXNlcigwLCBkaXJlbnQtPmRfbmFtZSArIG5hbWxlbik7Ci0JKChjaGFyICopIGRpcmVu
dCkgKz0gcmVjbGVuOworCWRpcmVudCA9IChzdHJ1Y3QgbGludXhfZGlyZW50NjQgKikoKGNoYXIg
KilkaXJlbnQgKyByZWNsZW4pOwogCWJ1Zi0+Y3VycmVudF9kaXIgPSBkaXJlbnQ7CiAJYnVmLT5j
b3VudCAtPSByZWNsZW47CiAJcmV0dXJuIDA7Cg==


--========/40FB9ACA0000533F/mail.tiscali.be
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="kernel-sysctl.diff"

LS0tIGxpbnV4LTIuNC4yNy1yYzMtcGE2bW0va2VybmVsL3N5c2N0bC5jLk9yaWcJMjAwNC0wNi0y
OSAwOTowMzo0Mi4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNC4yNy1yYzMtcGE2bW0va2Vy
bmVsL3N5c2N0bC5jCTIwMDQtMDctMjkgMTE6NDE6MzAuMDIxMDk0ODI0ICswMjAwCkBAIC04ODMs
MTQgKzg4MywxNSBAQAogCQogCWZvciAoOyBsZWZ0ICYmIHZsZWZ0LS07IGkrKywgZmlyc3Q9MCkg
ewogCQlpZiAod3JpdGUpIHsKKwkJCXAgPSBidWZmZXI7CiAJCQl3aGlsZSAobGVmdCkgewogCQkJ
CWNoYXIgYzsKLQkJCQlpZiAoZ2V0X3VzZXIoYywgKGNoYXIgKikgYnVmZmVyKSkKKwkJCQlpZiAo
Z2V0X3VzZXIoYywgcCkpCiAJCQkJCXJldHVybiAtRUZBVUxUOwogCQkJCWlmICghaXNzcGFjZShj
KSkKIAkJCQkJYnJlYWs7CiAJCQkJbGVmdC0tOwotCQkJCSgoY2hhciAqKSBidWZmZXIpKys7CisJ
CQkJcCsrOwogCQkJfQogCQkJaWYgKCFsZWZ0KQogCQkJCWJyZWFrOwpAQCAtMTAzNiwxNCArMTAz
NywxNSBAQAogCQogCWZvciAoOyBsZWZ0ICYmIHZsZWZ0LS07IGkrKywgbWluKyssIG1heCsrLCBm
aXJzdD0wKSB7CiAJCWlmICh3cml0ZSkgeworCQkJcCA9IGJ1ZmZlcjsKIAkJCXdoaWxlIChsZWZ0
KSB7CiAJCQkJY2hhciBjOwotCQkJCWlmIChnZXRfdXNlcihjLCAoY2hhciAqKSBidWZmZXIpKQor
CQkJCWlmIChnZXRfdXNlcihjLCBwKSkKIAkJCQkJcmV0dXJuIC1FRkFVTFQ7CiAJCQkJaWYgKCFp
c3NwYWNlKGMpKQogCQkJCQlicmVhazsKIAkJCQlsZWZ0LS07Ci0JCQkJKChjaGFyICopIGJ1ZmZl
cikrKzsKKwkJCQlwKys7CiAJCQl9CiAJCQlpZiAoIWxlZnQpCiAJCQkJYnJlYWs7CkBAIC0xMTM3
LDE0ICsxMTM5LDE1IEBACiAJCiAJZm9yICg7IGxlZnQgJiYgdmxlZnQtLTsgaSsrLCBmaXJzdD0w
KSB7CiAJCWlmICh3cml0ZSkgeworCQkJcCA9IChjaGFyICopYnVmZmVyOwogCQkJd2hpbGUgKGxl
ZnQpIHsKIAkJCQljaGFyIGM7Ci0JCQkJaWYgKGdldF91c2VyKGMsIChjaGFyICopIGJ1ZmZlcikp
CisJCQkJaWYgKGdldF91c2VyKGMsIHApKQogCQkJCQlyZXR1cm4gLUVGQVVMVDsKIAkJCQlpZiAo
IWlzc3BhY2UoYykpCiAJCQkJCWJyZWFrOwogCQkJCWxlZnQtLTsKLQkJCQkoKGNoYXIgKikgYnVm
ZmVyKSsrOworCQkJCXArKzsKIAkJCX0KIAkJCWlmICghbGVmdCkKIAkJCQlicmVhazsK

--========/40FB9ACA0000533F/mail.tiscali.be--
