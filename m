Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266635AbTGFIVT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 04:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266641AbTGFIVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 04:21:19 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:6540 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id S266635AbTGFIVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 04:21:17 -0400
Message-Id: <5.1.0.14.2.20030706094227.00af09f8@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 06 Jul 2003 10:36:20 +0200
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: Re: Linux 2.4.22-pre3
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_8477319==_"
X-Seen: false
X-ID: TDoLBgZcQe750wnfg3nCKnZcuKHn9qvmpa-NcMbscto7UvhpxSSXk7@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=====================_8477319==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

Erros/unresolved as below.
Attached patch fixes sdla_chdlc, sbni and mark_page_accessed.
The sonyapi I don't know. Seems like we should export acpi_disabled in
kernel/setup.c.
The comx is an ongoing fight :-)

Margit


sdla_chdlc.c:594:43: missing terminating " character
sdla_chdlc.c: In function `wpc_init':
sdla_chdlc.c:595: error: parse error before "Failed"
sdla_chdlc.c:595: error: stray '\' in program
sdla_chdlc.c:595:68: missing terminating " character
make[3]: *** [sdla_chdlc.o] Error 1

sbni.c: In function `calc_crc32':
sbni.c:1558: error: asm-specifier for variable `_crc' conflicts with asm 
clobber list
make[3]: *** [sbni.o] Error 1

depmod: *** Unresolved symbols in 
/lib/modules/2.4.22-pre3/kernel/drivers/char/sonypi.o
depmod:         acpi_disabled
depmod: *** Unresolved symbols in 
/lib/modules/2.4.22-pre3/kernel/drivers/net/wan/comx.o
depmod:         proc_get_inode
depmod: *** Unresolved symbols in 
/lib/modules/2.4.22-pre3/kernel/fs/hfsplus/hfsplus.o
depmod:         mark_page_accessed


         Margit
--=====================_8477319==_
Content-Type: application/octet-stream; name="patchpre3"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patchpre3"

ZGlmZiAtTmF1ciBsaW51eC0yLjQuMjJwcmUyL2RyaXZlcnMvbmV0L3dhbi9zYm5pLmMgbGludXgt
Mi40LjIycHJlMm13MC9kcml2ZXJzL25ldC93YW4vc2JuaS5jCi0tLSBsaW51eC0yLjQuMjJwcmUy
L2RyaXZlcnMvbmV0L3dhbi9zYm5pLmMJMjAwMi0xMS0yOSAwMDo1MzoxNC4wMDAwMDAwMDAgKzAx
MDAKKysrIGxpbnV4LTIuNC4yMnByZTJtdzAvZHJpdmVycy9uZXQvd2FuL3NibmkuYwkyMDAzLTA3
LTA0IDE4OjI2OjI2LjAwMDAwMDAwMCArMDIwMApAQCAtMTU1MiwxMyArMTU1MiwxMyBAQAogc3Rh
dGljIHUzMgogY2FsY19jcmMzMiggdTMyICBjcmMsICB1OCAgKnAsICB1MzIgIGxlbiApCiB7Ci0J
cmVnaXN0ZXIgdTMyICBfY3JjIF9fYXNtICggImF4IiApOworCXJlZ2lzdGVyIHUzMiAgX2NyYzsK
IAlfY3JjID0gY3JjOwogCQogCV9fYXNtIF9fdm9sYXRpbGUgKAogCQkieG9ybAklJWVieCwgJSVl
YnhcbiIKLQkJIm1vdmwJJTEsICUlZXNpXG4iIAotCQkibW92bAklMiwgJSVlY3hcbiIgCisJCSJt
b3ZsCSUyLCAlJWVzaVxuIiAKKwkJIm1vdmwJJTMsICUlZWN4XG4iIAogCQkibW92bAkkY3JjMzJ0
YWIsICUlZWRpXG4iCiAJCSJzaHJsCSQyLCAlJWVjeFxuIgogCQkianoJMWZcbiIKQEAgLTE1OTQs
NyArMTU5NCw3IEBACiAJCSJqbnoJMGJcbiIKIAogCSIxOlxuIgotCQkibW92bAklMiwgJSVlY3hc
biIKKwkJIm1vdmwJJTMsICUlZWN4XG4iCiAJCSJhbmRsCSQzLCAlJWVjeFxuIgogCQkianoJMmZc
biIKIApAQCAtMTYxOSw5ICsxNjE5LDkgQEAKIAkJInhvcmIJMiglJWVzaSksICUlYmxcbiIKIAkJ
InhvcmwJKCUlZWRpLCUlZWJ4LDQpLCAlJWVheFxuIgogCSIyOlxuIgotCQk6Ci0JCTogImEiIChf
Y3JjKSwgImciIChwKSwgImciIChsZW4pCi0JCTogImF4IiwgImJ4IiwgImN4IiwgImR4IiwgInNp
IiwgImRpIgorCQk6ICI9YSIgKF9jcmMpCisJCTogIjAiIChfY3JjKSwgImciIChwKSwgImciIChs
ZW4pCisJCTogImJ4IiwgImN4IiwgImR4IiwgInNpIiwgImRpIgogCSk7CiAKIAlyZXR1cm4gIF9j
cmM7CmRpZmYgLU5hdXIgbGludXgtMi40LjIycHJlMi9kcml2ZXJzL25ldC93YW4vc2RsYV9jaGRs
Yy5jIGxpbnV4LTIuNC4yMnByZTJtdzAvZHJpdmVycy9uZXQvd2FuL3NkbGFfY2hkbGMuYwotLS0g
bGludXgtMi40LjIycHJlMi9kcml2ZXJzL25ldC93YW4vc2RsYV9jaGRsYy5jCTIwMDItMTEtMjkg
MDA6NTM6MTQuMDAwMDAwMDAwICswMTAwCisrKyBsaW51eC0yLjQuMjJwcmUybXcwL2RyaXZlcnMv
bmV0L3dhbi9zZGxhX2NoZGxjLmMJMjAwMy0wNy0wNCAxNzoyMDoxOS4wMDAwMDAwMDAgKzAyMDAK
QEAgLTU5MSw4ICs1OTEsNyBAQAogCQogCiAJCWlmIChjaGRsY19zZXRfaW50cl9tb2RlKGNhcmQs
IEFQUF9JTlRfT05fVElNRVIpKXsKLQkJCXByaW50ayAoS0VSTl9JTkZPICIlczogCi0JCQkJRmFp
bGVkIHRvIHNldCBpbnRlcnJ1cHQgdHJpZ2dlcnMhXG4iLAorCQkJcHJpbnRrIChLRVJOX0lORk8g
IiVzOiBGYWlsZWQgdG8gc2V0IGludGVycnVwdCB0cmlnZ2VycyFcbiIsCiAJCQkJY2FyZC0+ZGV2
bmFtZSk7CiAJCQlyZXR1cm4gLUVJTzsJCiAgICAgICAgIAl9CmRpZmYgLU5hdXIgbGludXgtMi40
LjIycHJlMi9tbS9maWxlbWFwLmMgbGludXgtMi40LjIycHJlMm13MC9tbS9maWxlbWFwLmMKLS0t
IGxpbnV4LTIuNC4yMnByZTIvbW0vZmlsZW1hcC5jCTIwMDMtMDYtMzAgMDk6NTI6NDUuMDAwMDAw
MDAwICswMjAwCisrKyBsaW51eC0yLjQuMjJwcmUybXcwL21tL2ZpbGVtYXAuYwkyMDAzLTA3LTA1
IDE1OjIyOjQwLjAwMDAwMDAwMCArMDIwMApAQCAtMTMzOCw2ICsxMzM4LDggQEAKIAkJU2V0UGFn
ZVJlZmVyZW5jZWQocGFnZSk7CiB9CiAKK0VYUE9SVF9TWU1CT0wobWFya19wYWdlX2FjY2Vzc2Vk
KTsKKwogLyoKICAqIFRoaXMgaXMgYSBnZW5lcmljIGZpbGUgcmVhZCByb3V0aW5lLCBhbmQgdXNl
cyB0aGUKICAqIGlub2RlLT5pX29wLT5yZWFkcGFnZSgpIGZ1bmN0aW9uIGZvciB0aGUgYWN0dWFs
IGxvdy1sZXZlbAo=
--=====================_8477319==_--

