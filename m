Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312235AbSCTVzg>; Wed, 20 Mar 2002 16:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312237AbSCTVz1>; Wed, 20 Mar 2002 16:55:27 -0500
Received: from lightning.hereintown.net ([207.196.96.3]:7569 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S312235AbSCTVzQ>; Wed, 20 Mar 2002 16:55:16 -0500
Date: Wed, 20 Mar 2002 17:12:43 -0500 (EST)
From: Chris Meadors <clubneon@hereintown.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Alpha compile fixes for 2.5.7
Message-ID: <Pine.LNX.4.40.0203201705320.7618-200000@rc.priv.hereintown.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463805697-1722780320-1016662363=:7618"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463805697-1722780320-1016662363=:7618
Content-Type: TEXT/PLAIN; charset=US-ASCII

First let me say sorry, I'm using Pine, I think it will mangle the white
space if I inline the patch, so it made it an attatchment (if I continue
with this kernel hacking I'll find a better way to do this).

These were the changes I had to make to get 2.5.7 to compile (still
doesn't link) on my Alpha with my config.  There may need to be some other
changes, but this is a start.

The changes needed to get it to link will probally touch all platforms, so
I'll leave that alone.

-Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks

---1463805697-1722780320-1016662363=:7618
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="alpha-compile-fixes.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.40.0203201712430.7618@rc.priv.hereintown.net>
Content-Description: 
Content-Disposition: attachment; filename="alpha-compile-fixes.diff"

LS0tIGxpbnV4L2luY2x1ZGUvYXNtLWFscGhhL21tYW4uaH4JTW9uIE1hciAx
OCAxNTozNzowMyAyMDAyDQorKysgbGludXgvaW5jbHVkZS9hc20tYWxwaGEv
bW1hbi5oCVdlZCBNYXIgMjAgMDg6MDQ6NDIgMjAwMg0KQEAgLTQsNiArNCw3
IEBADQogI2RlZmluZSBQUk9UX1JFQUQJMHgxCQkvKiBwYWdlIGNhbiBiZSBy
ZWFkICovDQogI2RlZmluZSBQUk9UX1dSSVRFCTB4MgkJLyogcGFnZSBjYW4g
YmUgd3JpdHRlbiAqLw0KICNkZWZpbmUgUFJPVF9FWEVDCTB4NAkJLyogcGFn
ZSBjYW4gYmUgZXhlY3V0ZWQgKi8NCisjZGVmaW5lIFBST1RfU0VNCTB4OAkJ
LyogcGFnZSBtYXkgYmUgdXNlZCBmb3IgYXRvbWljIG9wcyAqLw0KICNkZWZp
bmUgUFJPVF9OT05FCTB4MAkJLyogcGFnZSBjYW4gbm90IGJlIGFjY2Vzc2Vk
ICovDQogDQogI2RlZmluZSBNQVBfU0hBUkVECTB4MDEJCS8qIFNoYXJlIGNo
YW5nZXMgKi8NCi0tLSBsaW51eC9hcmNoL2FscGhhL2tlcm5lbC9vc2Zfc3lz
LmN+CU1vbiBNYXIgMTggMTU6Mzc6MDEgMjAwMg0KKysrIGxpbnV4L2FyY2gv
YWxwaGEva2VybmVsL29zZl9zeXMuYwlXZWQgTWFyIDIwIDA5OjQ1OjQwIDIw
MDINCkBAIC0yMTksNyArMjE5LDcgQEANCiAJICogaXNuJ3QgYWN0dWFsbHkg
Z29pbmcgdG8gbWF0dGVyLCBhcyBpZiB0aGUgcGFyZW50IGhhcHBlbnMNCiAJ
ICogdG8gY2hhbmdlIHdlIGNhbiBoYXBwaWx5IHJldHVybiBlaXRoZXIgb2Yg
dGhlIHBpZHMuDQogCSAqLw0KLQkoJnJlZ3MpLT5yMjAgPSB0c2stPnBfb3Bw
dHItPnBpZDsNCisJKCZyZWdzKS0+cjIwID0gdHNrLT5yZWFsX3BhcmVudC0+
cGlkOw0KIAlyZXR1cm4gdHNrLT5waWQ7DQogfQ0KIA0KLS0tIGxpbnV4L2Fy
Y2gvYWxwaGEva2VybmVsL3B0cmFjZS5jfglNb24gTWFyIDE4IDE1OjM3OjE4
IDIwMDINCisrKyBsaW51eC9hcmNoL2FscGhhL2tlcm5lbC9wdHJhY2UuYwlX
ZWQgTWFyIDIwIDA5OjI5OjI3IDIwMDINCkBAIC0yOTIsNyArMjkyLDcgQEAN
CiAJCWlmIChyZXF1ZXN0ICE9IFBUUkFDRV9LSUxMKQ0KIAkJCWdvdG8gb3V0
Ow0KIAl9DQotCWlmIChjaGlsZC0+cF9wcHRyICE9IGN1cnJlbnQpIHsNCisJ
aWYgKGNoaWxkLT5wYXJlbnQgIT0gY3VycmVudCkgew0KIAkJREJHKERCR19N
RU0sICgiY2hpbGQgbm90IHBhcmVudCBvZiB0aGlzIHByb2Nlc3NcbiIpKTsN
CiAJCWdvdG8gb3V0Ow0KIAl9DQotLS0gbGludXgvaW5jbHVkZS9hc20tYWxw
aGEvc2lnaW5mby5ofglXZWQgTWFyIDIwIDA1OjA3OjE2IDIwMDINCisrKyBs
aW51eC9pbmNsdWRlL2FzbS1hbHBoYS9zaWdpbmZvLmgJV2VkIE1hciAyMCAw
ODoxMDo0NCAyMDAyDQpAQCAtMTA4LDYgKzEwOCw3IEBADQogI2RlZmluZSBT
SV9BU1lOQ0lPCS00CQkvKiBzZW50IGJ5IEFJTyBjb21wbGV0aW9uICovDQog
I2RlZmluZSBTSV9TSUdJTwktNQkJLyogc2VudCBieSBxdWV1ZWQgU0lHSU8g
Ki8NCiAjZGVmaW5lIFNJX1RLSUxMCS02CQkvKiBzZW50IGJ5IHRraWxsIHN5
c3RlbSBjYWxsICovDQorI2RlZmluZSBTSV9ERVRIUkVBRAktNwkJLyogc2Vu
dCBieSBleGVjdmUoKSBraWxsaW5nIHN1YnNpZGlhcnkgdGhyZWFkcyAqLw0K
IA0KICNkZWZpbmUgU0lfRlJPTVVTRVIoc2lwdHIpCSgoc2lwdHIpLT5zaV9j
b2RlIDw9IDApDQogI2RlZmluZSBTSV9GUk9NS0VSTkVMKHNpcHRyKQkoKHNp
cHRyKS0+c2lfY29kZSA+IDApDQotLS0gbGludXgvYXJjaC9hbHBoYS9rZXJu
ZWwvc2lnbmFsLmN+CU1vbiBNYXIgMTggMTU6Mzc6MTQgMjAwMg0KKysrIGxp
bnV4L2FyY2gvYWxwaGEva2VybmVsL3NpZ25hbC5jCVdlZCBNYXIgMjAgMDk6
Mjc6NDcgMjAwMg0KQEAgLTY2MSw4ICs2NjEsOCBAQA0KIAkJCQlpbmZvLnNp
X3NpZ25vID0gc2lnbnI7DQogCQkJCWluZm8uc2lfZXJybm8gPSAwOw0KIAkJ
CQlpbmZvLnNpX2NvZGUgPSBTSV9VU0VSOw0KLQkJCQlpbmZvLnNpX3BpZCA9
IGN1cnJlbnQtPnBfcHB0ci0+cGlkOw0KLQkJCQlpbmZvLnNpX3VpZCA9IGN1
cnJlbnQtPnBfcHB0ci0+dWlkOw0KKwkJCQlpbmZvLnNpX3BpZCA9IGN1cnJl
bnQtPnBhcmVudC0+cGlkOw0KKwkJCQlpbmZvLnNpX3VpZCA9IGN1cnJlbnQt
PnBhcmVudC0+dWlkOw0KIAkJCX0NCiANCiAJCQkvKiBJZiB0aGUgKG5ldykg
c2lnbmFsIGlzIG5vdyBibG9ja2VkLCByZXF1ZXVlIGl0LiAgKi8NCkBAIC03
MDEsNyArNzAxLDcgQEANCiAJCQljYXNlIFNJR1NUT1A6DQogCQkJCWN1cnJl
bnQtPnN0YXRlID0gVEFTS19TVE9QUEVEOw0KIAkJCQljdXJyZW50LT5leGl0
X2NvZGUgPSBzaWducjsNCi0JCQkJaWYgKCEoY3VycmVudC0+cF9wcHRyLT5z
aWctPmFjdGlvbltTSUdDSExELTFdDQorCQkJCWlmICghKGN1cnJlbnQtPnBh
cmVudC0+c2lnLT5hY3Rpb25bU0lHQ0hMRC0xXQ0KIAkJCQkgICAgICAuc2Eu
c2FfZmxhZ3MgJiBTQV9OT0NMRFNUT1ApKQ0KIAkJCQkJbm90aWZ5X3BhcmVu
dChjdXJyZW50LCBTSUdDSExEKTsNCiAJCQkJc2NoZWR1bGUoKTsNCi0tLSBs
aW51eC9pbmNsdWRlL2FzbS1hbHBoYS90aHJlYWRfaW5mby5ofglXZWQgTWFy
IDIwIDA1OjA3OjE1IDIwMDINCisrKyBsaW51eC9pbmNsdWRlL2FzbS1hbHBo
YS90aHJlYWRfaW5mby5oCVdlZCBNYXIgMjAgMTE6Mzg6MjcgMjAwMg0KQEAg
LTIwLDYgKzIwLDcgQEANCiAJc3RydWN0IGV4ZWNfZG9tYWluCSpleGVjX2Rv
bWFpbjsJLyogZXhlY3V0aW9uIGRvbWFpbiAqLw0KIAltbV9zZWdtZW50X3QJ
CWFkZHJfbGltaXQ7CS8qIHRocmVhZCBhZGRyZXNzIHNwYWNlICovDQogCWlu
dAkJCWNwdTsJCS8qIGN1cnJlbnQgQ1BVICovDQorCWludAkJCXByZWVtcHRf
Y291bnQ7CS8qIDAgPT4gcHJlZW1wdGFibGUsIDwwID0+IEJVRyAqLw0KIA0K
IAlpbnQgYnB0X25zYXZlZDsNCiAJdW5zaWduZWQgbG9uZyBicHRfYWRkclsy
XTsJCS8qIGJyZWFrcG9pbnQgaGFuZGxpbmcgICovDQo=
---1463805697-1722780320-1016662363=:7618--
