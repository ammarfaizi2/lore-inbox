Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318884AbSHSN3s>; Mon, 19 Aug 2002 09:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318885AbSHSN3s>; Mon, 19 Aug 2002 09:29:48 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:37277 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S318884AbSHSN3r>; Mon, 19 Aug 2002 09:29:47 -0400
Date: Mon, 19 Aug 2002 09:33:44 -0400 (EDT)
From: Albert Cranford <root@cranford.com>
Reply-To: ac9410@attbi.com
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.5.31 blacklist IMB Laptops from I2C-Sensors
Message-ID: <Pine.LNX.4.44.0208190923280.417-200000@home1.cranford.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1343968659-1029764024=:417"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1343968659-1029764024=:417
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hello Linus,
This patch addresses concerns that Sensor detection  corrupts IBM Laptops by
setting a global value "disable_smbus" in dmi_scan.  With this set, it will
now be possible to blacklist IBM Laptops and not scan for sensors.
Thanks,
Albert
-- 
ac9410@attbi.com


--8323328-1343968659-1029764024=:417
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=dmi-patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0208190933440.417@home1.cranford.com>
Content-Description: 
Content-Disposition: attachment; filename=dmi-patch

LS0tIGxpbnV4LTIuNS4zMS9hcmNoL2kzODYva2VybmVsL2RtaV9zY2FuLmMu
b3JpZyAgICAgMjAwMi0wNy0zMSAyMzoxMDoyMS4wMDAwMDAwMDAgLTA0MDAN
CisrKyBsaW51eC9hcmNoL2kzODYva2VybmVsL2RtaV9zY2FuLmMgIDIwMDIt
MDctMzEgMjM6MTM6NTIuMDAwMDAwMDAwIC0wNDAwDQpAQCAtMTMsNiArMTMs
NyBAQA0KIA0KIHVuc2lnbmVkIGxvbmcgZG1pX2Jyb2tlbjsNCiBpbnQgaXNf
c29ueV92YWlvX2xhcHRvcDsNCitpbnQgaXNfYnJva2VuX3NtYnVzOw0KIA0K
IHN0cnVjdCBkbWlfaGVhZGVyDQogew0KQEAgLTQ2OCw2ICs0NjksMjAgQEAN
CiAJcmV0dXJuIDA7DQogfQ0KIA0KKy8qIA0KKyAqIERvbid0IGFjY2VzcyBT
TUJ1cyBvbiBJQk0gc3lzdGVtcyB3aGljaCBnZXQgY29ycnVwdGVkIGVlcHJv
bXMgDQorICovDQorDQorc3RhdGljIF9faW5pdCBpbnQgZGlzYWJsZV9zbWJ1
cyhzdHJ1Y3QgZG1pX2JsYWNrbGlzdCAqZCkNCit7DQorCWlmIChpc19icm9r
ZW5fc21idXMgPT0gMCkNCisJew0KKwkJaXNfYnJva2VuX3NtYnVzID0gMTsN
CisJCXByaW50ayhLRVJOX0lORk8gIiVzIG1hY2hpbmUgZGV0ZWN0ZWQuIERp
c2FibGluZyBTTUJ1cyBhY2Nlc3Nlcy5cbiIsIGQtPmlkZW50KTsNCisJfQ0K
KwlyZXR1cm4gMDsNCit9DQorDQogLyoNCiAgKglTaW1wbGUgInByaW50IGlm
IHRydWUiIGNhbGxiYWNrDQogICovDQpAQCAtNzM3LDYgKzc1MiwxNSBAQA0K
IAkgKi8NCiAJIA0KIAl7IHNldF9hcG1faW50cywgIklCTSIsIHsJLyogQWxs
b3cgaW50ZXJydXB0cyBkdXJpbmcgc3VzcGVuZCBvbiBJQk0gbGFwdG9wcyAq
Lw0KKwkJCU1BVENIKERNSV9TWVNfVkVORE9SLCAiSUJNIiksDQorCQkJTk9f
TUFUQ0gsIE5PX01BVENILCBOT19NQVRDSA0KKwkJCX0gfSwNCisNCisJLyoN
CisJICoJU01CdXMgLyBzZW5zb3JzIHNldHRpbmdzDQorCSAqLw0KKwkgDQor
CXsgZGlzYWJsZV9zbWJ1cywgIklCTSIsIHsNCiAJCQlNQVRDSChETUlfU1lT
X1ZFTkRPUiwgIklCTSIpLA0KIAkJCU5PX01BVENILCBOT19NQVRDSCwgTk9f
TUFUQ0gNCiAJCQl9IH0sDQo=
--8323328-1343968659-1029764024=:417--
