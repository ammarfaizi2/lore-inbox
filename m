Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965125AbVKHM5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965125AbVKHM5G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 07:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965142AbVKHM5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 07:57:06 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:43315
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S965108AbVKHM5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 07:57:00 -0500
Message-Id: <4370AEE1.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Tue, 08 Nov 2005 13:57:53 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386: export genapic again
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part3A1804C1.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part3A1804C1.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

A change not too long ago made i386's genapic symbol no longer be
exported, and thus certain low-level functions no longer be usable.
Since close-to-the-hardware code may still be modular, this
rectifies the situation.

From: Jan Beulich <jbeulich@novell.com>

(actual patch attached)


--=__Part3A1804C1.0__=
Content-Type: application/octet-stream; name="linux-2.6.14-i386-genapic.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.14-i386-genapic.patch"

QSBjaGFuZ2Ugbm90IHRvbyBsb25nIGFnbyBtYWRlIGkzODYncyBnZW5hcGljIHN5bWJvbCBubyBs
b25nZXIgYmUKZXhwb3J0ZWQsIGFuZCB0aHVzIGNlcnRhaW4gbG93LWxldmVsIGZ1bmN0aW9ucyBu
byBsb25nZXIgYmUgdXNhYmxlLgpTaW5jZSBjbG9zZS10by10aGUtaGFyZHdhcmUgY29kZSBtYXkg
c3RpbGwgYmUgbW9kdWxhciwgdGhpcwpyZWN0aWZpZXMgdGhlIHNpdHVhdGlvbi4KCkZyb206IEph
biBCZXVsaWNoIDxqYmV1bGljaEBub3ZlbGwuY29tPgoKLS0tIDIuNi4xNC9hcmNoL2kzODYvbWFj
aC1nZW5lcmljL3Byb2JlLmMJMjAwNS0xMC0yOCAwMjowMjowOC4wMDAwMDAwMDAgKzAyMDAKKysr
IDIuNi4xNC1pMzg2LWdlbmFwaWMvYXJjaC9pMzg2L21hY2gtZ2VuZXJpYy9wcm9iZS5jCTIwMDUt
MTEtMDQgMTY6MTk6MzMuMDAwMDAwMDAwICswMTAwCkBAIC0zLDYgKzMsNyBAQAogICogCiAgKiBH
ZW5lcmljIHg4NiBBUElDIGRyaXZlciBwcm9iZSBsYXllci4KICAqLyAgCisjZGVmaW5lIEFQSUNf
REVGSU5JVElPTiAxCiAjaW5jbHVkZSA8bGludXgvY29uZmlnLmg+CiAjaW5jbHVkZSA8bGludXgv
dGhyZWFkcy5oPgogI2luY2x1ZGUgPGxpbnV4L2NwdW1hc2suaD4KQEAgLTEwLDYgKzExLDcgQEAK
ICNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4KICNpbmNsdWRlIDxsaW51eC9jdHlwZS5oPgogI2lu
Y2x1ZGUgPGxpbnV4L2luaXQuaD4KKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KICNpbmNsdWRl
IDxhc20vZml4bWFwLmg+CiAjaW5jbHVkZSA8YXNtL21wc3BlYy5oPgogI2luY2x1ZGUgPGFzbS9h
cGljZGVmLmg+CkBAIC0yMSw2ICsyMyw3IEBAIGV4dGVybiBzdHJ1Y3QgZ2VuYXBpYyBhcGljX2Vz
NzAwMDsKIGV4dGVybiBzdHJ1Y3QgZ2VuYXBpYyBhcGljX2RlZmF1bHQ7CiAKIHN0cnVjdCBnZW5h
cGljICpnZW5hcGljID0gJmFwaWNfZGVmYXVsdDsKK0VYUE9SVF9TWU1CT0woZ2VuYXBpYyk7CiAK
IHN0cnVjdCBnZW5hcGljICphcGljX3Byb2JlW10gX19pbml0ZGF0YSA9IHsgCiAJJmFwaWNfc3Vt
bWl0LAo=

--=__Part3A1804C1.0__=--
