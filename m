Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129797AbQLQTKa>; Sun, 17 Dec 2000 14:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130656AbQLQTKV>; Sun, 17 Dec 2000 14:10:21 -0500
Received: from hornisse.agrinet.ch ([212.28.128.30]:30984 "EHLO pop.agri.ch")
	by vger.kernel.org with ESMTP id <S129797AbQLQTKN>;
	Sun, 17 Dec 2000 14:10:13 -0500
Message-ID: <3A3D0992.2F969BD7@pop.agri.ch>
Date: Sun, 17 Dec 2000 19:44:36 +0100
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
Organization: zero
X-Mailer: Mozilla 4.75 (Macintosh; U; PPC)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] ppc fixes for drivers/char/serial.c
Content-Type: multipart/mixed;
 boundary="------------ECF7C1F251C077661FD46173"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------ECF7C1F251C077661FD46173
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Alan,

can you may include the attached patch in one of the next pre19 patches?
It adds the possibility to work with pcmcia modem cards on PowerBooks,
this patch was in for a longer time in the ppc tree of Paul M. and Ben
Herrenschmidt. 
Ben told me to send it to you with his ack.

Thanks in advance,

Andreas
--------------ECF7C1F251C077661FD46173
Content-Type: application/x-java-applet;version=1.1.2; x-mac-type="3F3F3F3F"; x-mac-creator="3F3F3F3F";
 name="serial2218.diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="serial2218.diff"

LS0tIGxpbnV4L2RyaXZlcnMvY2hhci9zZXJpYWwuYwlXZWQgSnVuICA3IDIzOjI2OjQyIDIw
MDAKKysrIGxpbnV4LXBtYWMtc3RhYmxlLXRlc3QvZHJpdmVycy9jaGFyL3NlcmlhbC5jCVR1
ZSBOb3YgMTQgMTk6MDg6MzIgMjAwMApAQCAtMTUwLDYgKzE1MCwxMiBAQAogI2luY2x1ZGUg
PGFzbS9iaXRvcHMuaD4KICNpbmNsdWRlIDxhc20vc2VyaWFsLmg+CiAKKyNpZmRlZiBDT05G
SUdfTUFDX1NFUklBTAorI2RlZmluZSBTRVJJQUxfREVWX09GRlNFVAk0CisjZWxzZQorI2Rl
ZmluZSBTRVJJQUxfREVWX09GRlNFVAkwCisjZW5kaWYKKwogI2lmZGVmIFNFUklBTF9JTkxJ
TkUKICNkZWZpbmUgX0lOTElORV8gaW5saW5lCiAjZW5kaWYKQEAgLTMxMzAsNyArMzEzNiw3
IEBACiAJc2VyaWFsX2RyaXZlci5kcml2ZXJfbmFtZSA9ICJzZXJpYWwiOwogCXNlcmlhbF9k
cml2ZXIubmFtZSA9ICJ0dHlTIjsKIAlzZXJpYWxfZHJpdmVyLm1ham9yID0gVFRZX01BSk9S
OwotCXNlcmlhbF9kcml2ZXIubWlub3Jfc3RhcnQgPSA2NDsKKwlzZXJpYWxfZHJpdmVyLm1p
bm9yX3N0YXJ0ID0gNjQgKyBTRVJJQUxfREVWX09GRlNFVDsKIAlzZXJpYWxfZHJpdmVyLm51
bSA9IE5SX1BPUlRTOwogCXNlcmlhbF9kcml2ZXIudHlwZSA9IFRUWV9EUklWRVJfVFlQRV9T
RVJJQUw7CiAJc2VyaWFsX2RyaXZlci5zdWJ0eXBlID0gU0VSSUFMX1RZUEVfTk9STUFMOwpA
QCAtMzE5NCwxMSArMzIwMCwyMiBAQAogCQlzdGF0ZS0+aWNvdW50LmZyYW1lID0gc3RhdGUt
Pmljb3VudC5wYXJpdHkgPSAwOwogCQlzdGF0ZS0+aWNvdW50Lm92ZXJydW4gPSBzdGF0ZS0+
aWNvdW50LmJyayA9IDA7CiAJCXN0YXRlLT5pcnEgPSBpcnFfY2Fubm9uaWNhbGl6ZShzdGF0
ZS0+aXJxKTsKLQkJaWYgKGNoZWNrX3JlZ2lvbihzdGF0ZS0+cG9ydCw4KSkKLQkJCWNvbnRp
bnVlOwotCQlpZiAoc3RhdGUtPmZsYWdzICYgQVNZTkNfQk9PVF9BVVRPQ09ORikKLQkJCWF1
dG9jb25maWcoc3RhdGUpOworI2lmZGVmIENPTkZJR19QUEMKKwkJLyogUG93ZXJNYWNzIGRv
bid0IGhhdmUgbGVnYWN5IHNlcmlhbCBwb3J0cyBvbiBJT3MgYW5kIHdvdWxkIG1hY2hpbmUg
Y2hlY2sgKi8KKwkJaWYgKF9tYWNoaW5lICE9IF9NQUNIX1BtYWMpIHsKKyNlbmRpZgkJCisJ
CQlpZiAoY2hlY2tfcmVnaW9uKHN0YXRlLT5wb3J0LDgpKQorCQkJCWNvbnRpbnVlOworCQkJ
aWYgKHN0YXRlLT5mbGFncyAmIEFTWU5DX0JPT1RfQVVUT0NPTkYpCisJCQkJYXV0b2NvbmZp
ZyhzdGF0ZSk7CisjaWZkZWYgQ09ORklHX1BQQworCQl9CisjZW5kaWYJCQogCX0KKyNpZmRl
ZiBDT05GSUdfUFBDCisJaWYgKF9tYWNoaW5lID09IF9NQUNIX1BtYWMpCisJCXJldHVybiAw
OworI2VuZGlmCiAJLyoKIAkgKiBEZXRlY3QgdGhlIElSUSBvbmx5IG9uY2UgZXZlcnkgcG9y
dCBpcyBpbml0aWFsaXNlZCwKIAkgKiBiZWNhdXNlIHNvbWUgMTY0NTAgZG8gbm90IHJlc2V0
IHRvIDAgdGhlIE1DUiByZWdpc3Rlci4KQEAgLTMyNjgsMjIgKzMyODUsMjIgQEAKIAkJc3Rh
dGUtPmlycSA9IGRldGVjdF91YXJ0X2lycShzdGF0ZSk7CiAKIAlwcmludGsoS0VSTl9JTkZP
ICJ0dHklMDJkIGF0IDB4JTA0eCAoaXJxID0gJWQpIGlzIGEgJXNcbiIsCi0JICAgICAgIHN0
YXRlLT5saW5lLCBzdGF0ZS0+cG9ydCwgc3RhdGUtPmlycSwKKwkgICAgICAgc3RhdGUtPmxp
bmUgKyBTRVJJQUxfREVWX09GRlNFVCwgc3RhdGUtPnBvcnQsIHN0YXRlLT5pcnEsCiAJICAg
ICAgIHVhcnRfY29uZmlnW3N0YXRlLT50eXBlXS5uYW1lKTsKLQlyZXR1cm4gc3RhdGUtPmxp
bmU7CisJcmV0dXJuIHN0YXRlLT5saW5lICsgU0VSSUFMX0RFVl9PRkZTRVQ7CiB9CiAKIHZv
aWQgdW5yZWdpc3Rlcl9zZXJpYWwoaW50IGxpbmUpCiB7CiAJdW5zaWduZWQgbG9uZyBmbGFn
czsKLQlzdHJ1Y3Qgc2VyaWFsX3N0YXRlICpzdGF0ZSA9ICZyc190YWJsZVtsaW5lXTsKKwlz
dHJ1Y3Qgc2VyaWFsX3N0YXRlICpzdGF0ZSA9ICZyc190YWJsZVtsaW5lICsgU0VSSUFMX0RF
Vl9PRkZTRVRdOwogCiAJc2F2ZV9mbGFncyhmbGFncyk7CiAJY2xpKCk7CiAJaWYgKHN0YXRl
LT5pbmZvICYmIHN0YXRlLT5pbmZvLT50dHkpCiAJCXR0eV9oYW5ndXAoc3RhdGUtPmluZm8t
PnR0eSk7CiAJc3RhdGUtPnR5cGUgPSBQT1JUX1VOS05PV047Ci0JcHJpbnRrKEtFUk5fSU5G
TyAidHR5JTAyZCB1bmxvYWRlZFxuIiwgc3RhdGUtPmxpbmUpOworCXByaW50ayhLRVJOX0lO
Rk8gInR0eSUwMmQgdW5sb2FkZWRcbiIsIHN0YXRlLT5saW5lICsgU0VSSUFMX0RFVl9PRkZT
RVQpOwogCXJlc3RvcmVfZmxhZ3MoZmxhZ3MpOwogfQogCg==
--------------ECF7C1F251C077661FD46173--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
