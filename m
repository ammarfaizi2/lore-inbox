Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbUCaUFe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 15:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbUCaUFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 15:05:34 -0500
Received: from build.arklinux.oregonstate.edu ([128.193.0.51]:31368 "EHLO
	test.arklinux.org") by vger.kernel.org with ESMTP id S262412AbUCaUFa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 15:05:30 -0500
Date: Wed, 31 Mar 2004 12:15:01 -0800 (PST)
From: bero@arklinux.org
X-X-Sender: bero@build.arklinux.oregonstate.edu
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] Aureal Vortex sound drivers broken in 2.6.5-rc3-mm3
Message-ID: <Pine.LNX.4.58.0403311213590.14154@build.arklinux.oregonstate.edu>
X-Legal-Notice: We do not accept spam. Violations will be prosecuted.
X-Subliminal-Message: Upgrade your system to Ark Linux today! http://www.arklinux.org/
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1048562944-990213000-1080764101=:14154"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1048562944-990213000-1080764101=:14154
Content-Type: TEXT/PLAIN; charset=US-ASCII

SSIA - fix attached.

LLaP
bero

-- 
Ark Linux - Linux for the masses
http://www.arklinux.org/

Redistribution and processing of this message is subject to
http://www.arklinux.org/terms.php
---1048562944-990213000-1080764101=:14154
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="linux-2.6.5-rc3-mm3-aureal-fix.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0403311215010.14154@build.arklinux.oregonstate.edu>
Content-Description: Fix Aureal
Content-Disposition: attachment; filename="linux-2.6.5-rc3-mm3-aureal-fix.patch"

LS0tIGxpbnV4LTIuNi40L2luY2x1ZGUvbGludXgvcGNpX2lkcy5oLmFyawky
MDA0LTA0LTAxIDA0OjU1OjU3LjAwMDAwMDAwMCArMDIwMA0KKysrIGxpbnV4
LTIuNi40L2luY2x1ZGUvbGludXgvcGNpX2lkcy5oCTIwMDQtMDQtMDEgMDQ6
NTg6MTguNDQwMDI0OTI4ICswMjAwDQpAQCAtMTYzOCw2ICsxNjM4LDcgQEAN
CiAjZGVmaW5lIFBDSV9WRU5ET1JfSURfQVVSRUFMCQkweDEyZWINCiAjZGVm
aW5lIFBDSV9ERVZJQ0VfSURfQVVSRUFMX1ZPUlRFWF8xCTB4MDAwMQ0KICNk
ZWZpbmUgUENJX0RFVklDRV9JRF9BVVJFQUxfVk9SVEVYXzIJMHgwMDAyDQor
I2RlZmluZSBQQ0lfREVWSUNFX0lEX0FVUkVBTF9BRFZBTlRBR0UJMHgwMDAz
DQogDQogI2RlZmluZSBQQ0lfVkVORE9SX0lEX0VMRUNUUk9OSUNERVNJR05H
TUJIIDB4MTJmOA0KICNkZWZpbmUgUENJX0RFVklDRV9JRF9MTUxfMzNSMTAJ
CTB4OGEwMg0KLS0tIGxpbnV4LTIuNi40L3NvdW5kL3BjaS9hdTg4eDAvYXU4
ODMwLmMuYXJrCTIwMDQtMDQtMDEgMDU6MDU6MDAuOTkwODI3OTA0ICswMjAw
DQorKysgbGludXgtMi42LjQvc291bmQvcGNpL2F1ODh4MC9hdTg4MzAuYwky
MDA0LTA0LTAxIDA1OjA1OjA3LjA1MjkwNjMyOCArMDIwMA0KQEAgLTEsNyAr
MSw3IEBADQogI2luY2x1ZGUgImF1ODgzMC5oIg0KICNpbmNsdWRlICJhdTg4
eDAuaCINCiBzdGF0aWMgc3RydWN0IHBjaV9kZXZpY2VfaWQgc25kX3ZvcnRl
eF9pZHNbXSA9IHsNCi0Je1BDSV9WRU5ET1JfSURfQVVSRUFMLCBQQ0lfREVW
SUNFX0lEX0FVUkVBTF9WT1JURVgyLA0KKwl7UENJX1ZFTkRPUl9JRF9BVVJF
QUwsIFBDSV9ERVZJQ0VfSURfQVVSRUFMX1ZPUlRFWF8yLA0KIAkgUENJX0FO
WV9JRCwgUENJX0FOWV9JRCwgMCwgMCwgMCx9LA0KIAl7MCx9DQogfTsNCi0t
LSBsaW51eC0yLjYuNC9zb3VuZC9wY2kvYXU4OHgwL2F1ODh4MC5oLmFyawky
MDA0LTA0LTAxIDA1OjA1OjEzLjYzODkwNTEwNCArMDIwMA0KKysrIGxpbnV4
LTIuNi40L3NvdW5kL3BjaS9hdTg4eDAvYXU4OHgwLmgJMjAwNC0wNC0wMSAw
NTowNToyMS41Nzg2OTgwNzIgKzAyMDANCkBAIC04MCw4ICs4MCw4IEBADQog
I2RlZmluZSBWT1JURVhfSVNfUVVBRCh4KSAoKHgtPmNvZGVjID09IE5VTEwp
ID8gIDAgOiAoeC0+Y29kZWMtPmV4dF9pZHwweDgwKSkNCiAvKiBDaGVjayBp
ZiBjaGlwIGhhcyBidWcuICovDQogI2RlZmluZSBJU19CQURfQ0hJUCh4KSAo
XA0KLQkoeC0+cmV2IDwgMyAmJiB4LT5kZXZpY2UgPT0gUENJX0RFVklDRV9J
RF9BVVJFQUxfVk9SVEVYKSB8fCBcDQotCSh4LT5yZXYgPCAweGZlICYmIHgt
PmRldmljZSA9PSBQQ0lfREVWSUNFX0lEX0FVUkVBTF9WT1JURVgyKSB8fCBc
DQorCSh4LT5yZXYgPCAzICYmIHgtPmRldmljZSA9PSBQQ0lfREVWSUNFX0lE
X0FVUkVBTF9WT1JURVhfMSkgfHwgXA0KKwkoeC0+cmV2IDwgMHhmZSAmJiB4
LT5kZXZpY2UgPT0gUENJX0RFVklDRV9JRF9BVVJFQUxfVk9SVEVYXzIpIHx8
IFwNCiAJKHgtPnJldiA8IDB4ZmUgJiYgeC0+ZGV2aWNlID09IFBDSV9ERVZJ
Q0VfSURfQVVSRUFMX0FEVkFOVEFHRSkpDQogDQogDQo=

---1048562944-990213000-1080764101=:14154--
