Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932480AbVKGMwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbVKGMwp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 07:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbVKGMwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 07:52:45 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:3905
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932480AbVKGMwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 07:52:45 -0500
Message-Id: <436F5C5A.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Mon, 07 Nov 2005 13:53:30 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Gerd Knorr" <kraxel@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] make vesafb build without CONFIG_MTRR
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part5072715A.1__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part5072715A.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

vesafb did not build without CONFIG_MTRR.

From: Jan Beulich <jbeulich@novell.com>

(actual patch attached)

--=__Part5072715A.1__=
Content-Type: application/octet-stream; name="linux-2.6.14-vesafb-no-mtrr.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.14-vesafb-no-mtrr.patch"

dmVzYWZiIGRpZCBub3QgYnVpbGQgd2l0aG91dCBDT05GSUdfTVRSUi4KCkZyb206IEphbiBCZXVs
aWNoIDxqYmV1bGljaEBub3ZlbGwuY29tPgoKLS0tIC9ob21lL2piZXVsaWNoL3RtcC9saW51eC0y
LjYuMTQvZHJpdmVycy92aWRlby92ZXNhZmIuYwkyMDA1LTEwLTI4IDAyOjAyOjA4LjAwMDAwMDAw
MCArMDIwMAorKysgMi42LjE0L2RyaXZlcnMvdmlkZW8vdmVzYWZiLmMJMjAwNS0xMS0wNCAxMjox
OToxNS4wMDAwMDAwMDAgKzAxMDAKQEAgLTQxOSw2ICs0MTksNyBAQCBzdGF0aWMgaW50IF9faW5p
dCB2ZXNhZmJfcHJvYmUoc3RydWN0IGRlCiAJICogcmVnaW9uIGFscmVhZHkgKEZJWE1FKSAqLwog
CXJlcXVlc3RfcmVnaW9uKDB4M2MwLCAzMiwgInZlc2FmYiIpOwogCisjaWZkZWYgQ09ORklHX01U
UlIKIAlpZiAobXRycikgewogCQl1bnNpZ25lZCBpbnQgdGVtcF9zaXplID0gc2l6ZV90b3RhbDsK
IAkJdW5zaWduZWQgaW50IHR5cGUgPSAwOwpAQCAtNDU2LDYgKzQ1Nyw3IEBAIHN0YXRpYyBpbnQg
X19pbml0IHZlc2FmYl9wcm9iZShzdHJ1Y3QgZGUKIAkJCX0gd2hpbGUgKHRlbXBfc2l6ZSA+PSBQ
QUdFX1NJWkUgJiYgcmMgPT0gLUVJTlZBTCk7CiAJCX0KIAl9CisjZW5kaWYKIAkKIAlpbmZvLT5m
Ym9wcyA9ICZ2ZXNhZmJfb3BzOwogCWluZm8tPnZhciA9IHZlc2FmYl9kZWZpbmVkOwo=

--=__Part5072715A.1__=--
