Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129352AbQKRLc6>; Sat, 18 Nov 2000 06:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130159AbQKRLcs>; Sat, 18 Nov 2000 06:32:48 -0500
Received: from kauha.saunalahti.fi ([195.197.53.227]:30716 "EHLO
	kauha.saunalahti.fi") by vger.kernel.org with ESMTP
	id <S129352AbQKRLcf>; Sat, 18 Nov 2000 06:32:35 -0500
Date: Sat, 18 Nov 2000 13:46:40 +0200 (EET)
From: Kaj-Michael Lang <milang@tal.org>
To: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] swap=<device> kernel commandline 
Message-ID: <Pine.LNX.4.20.0011181342280.6391-200000@tori.tal.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="281236188-1900795059-974548000=:6391"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--281236188-1900795059-974548000=:6391
Content-Type: TEXT/PLAIN; charset=US-ASCII

This patch adds a swap kernel commandline option, so that you can add a
swap partition before init starts running on a low-memory machine. 

The patch is against 2.4.0-test11-pre7

This is my first try at a kernel patch so... I hope someone finds it
usefull.


--281236188-1900795059-974548000=:6391
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="swap.cmdline-2.4.0-test11-pre7.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.20.0011181346400.6391@tori.tal.org>
Content-Description: 
Content-Disposition: attachment; filename="swap.cmdline-2.4.0-test11-pre7.patch"

LS0tIGluaXQvbWFpbi5jLTIuNC4wdGVzdDExLXByZTcJU2F0IE5vdiAxOCAx
MjozMDo1OSAyMDAwDQorKysgaW5pdC9tYWluLmMJU2F0IE5vdiAxOCAxMjoz
NTowOCAyMDAwDQpAQCAtMTMxLDYgKzEzMSw3IEBADQogaW50IHJvb3RfbW91
bnRmbGFncyA9IE1TX1JET05MWTsNCiBjaGFyICpleGVjdXRlX2NvbW1hbmQ7
DQogY2hhciByb290X2RldmljZV9uYW1lWzY0XTsNCitjaGFyIHN3YXBfZGV2
aWNlX25hbWVbNjRdOw0KIA0KIA0KIHN0YXRpYyBjaGFyICogYXJndl9pbml0
W01BWF9JTklUX0FSR1MrMl0gPSB7ICJpbml0IiwgTlVMTCwgfTsNCkBAIC0y
OTcsNiArMjk4LDI1IEBADQogDQogX19zZXR1cCgicm9vdD0iLCByb290X2Rl
dl9zZXR1cCk7DQogDQorc3RhdGljIGludCBfX2luaXQgc3dhcF9kZXZfc2V0
dXAoY2hhciAqbGluZSkNCit7DQorCWludCBpOw0KKwljaGFyIGNoOw0KKw0K
KwltZW1zZXQgKHN3YXBfZGV2aWNlX25hbWUsIDAsIHNpemVvZiBzd2FwX2Rl
dmljZV9uYW1lKTsNCisJZm9yIChpID0gMDsgaSA8IHNpemVvZiBzd2FwX2Rl
dmljZV9uYW1lIC0gMTsgKytpKQ0KKwl7DQorCSAgICBjaCA9IGxpbmVbaV07
DQorCSAgICBpZiAoIGlzc3BhY2UgKGNoKSB8fCAoY2ggPT0gJywnKSB8fCAo
Y2ggPT0gJ1wwJykgKSBicmVhazsNCisJICAgIHN3YXBfZGV2aWNlX25hbWVb
aV0gPSBjaDsNCisJfQ0KKwlyZXR1cm4gMTsNCit9DQorDQorDQorX19zZXR1
cCgic3dhcD0iLCBzd2FwX2Rldl9zZXR1cCk7DQorDQorDQogc3RhdGljIGlu
dCBfX2luaXQgY2hlY2tzZXR1cChjaGFyICpsaW5lKQ0KIHsNCiAJc3RydWN0
IGtlcm5lbF9wYXJhbSAqcDsNCkBAIC03MjUsNiArNzQ1LDE1IEBADQogDQog
CW1vdW50X2RldmZzX2ZzICgpOw0KIA0KKwlpZiAoc3dhcF9kZXZpY2VfbmFt
ZVswXSE9MCkgew0KKwkgIHByaW50aygiU2V0dGluZyB1cCBzd2FwOiAlcyBc
biIsc3dhcF9kZXZpY2VfbmFtZSk7DQorCSAgaWYgKCBzeXNfc3dhcG9uKHN3
YXBfZGV2aWNlX25hbWUsMCk9PTAgKSB7DQorCQlwcmludGsoIlN3YXBvbiBv
a1xuIik7IA0KKwkJfSBlbHNlIHsNCisJCXByaW50aygiU3dhcG9uIGZhaWxl
ZCFcbiIpOw0KKwkJfQ0KKwl9DQorIA0KICNpZmRlZiBDT05GSUdfQkxLX0RF
Vl9JTklUUkQNCiAJcm9vdF9tb3VudGZsYWdzID0gcmVhbF9yb290X21vdW50
ZmxhZ3M7DQogCWlmIChtb3VudF9pbml0cmQgJiYgUk9PVF9ERVYgIT0gcmVh
bF9yb290X2Rldg0KQEAgLTc4MCwzICs4MDksNCBAQA0KIAlleGVjdmUoIi9i
aW4vc2giLGFyZ3ZfaW5pdCxlbnZwX2luaXQpOw0KIAlwYW5pYygiTm8gaW5p
dCBmb3VuZC4gIFRyeSBwYXNzaW5nIGluaXQ9IG9wdGlvbiB0byBrZXJuZWwu
Iik7DQogfQ0KKw0K
--281236188-1900795059-974548000=:6391--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
