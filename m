Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbVKIN6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbVKIN6y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 08:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbVKIN6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 08:58:54 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:29486
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750762AbVKIN6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 08:58:53 -0500
Message-Id: <43720EE7.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Wed, 09 Nov 2005 14:59:51 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/39] NLKD/i386 - early/late CPU up/down notification
References: <43720DAE.76F0.0078.0@novell.com> <43720E2E.76F0.0078.0@novell.com> <43720E72.76F0.0078.0@novell.com> <43720EAF.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part9EBCA2C7.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part9EBCA2C7.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

i386-specific part of the new mechanism to allow debuggers to learn
about starting/dying CPUs as early/late as possible.

Signed-Off-By: Jan Beulich <jbeulich@novell.com>

(actual patch attached)


--=__Part9EBCA2C7.0__=
Content-Type: application/octet-stream; name="linux-2.6.14-nlkd-notify-cpu-i386.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.14-nlkd-notify-cpu-i386.patch"

aTM4Ni1zcGVjaWZpYyBwYXJ0IG9mIHRoZSBuZXcgbWVjaGFuaXNtIHRvIGFsbG93IGRlYnVnZ2Vy
cyB0byBsZWFybgphYm91dCBzdGFydGluZy9keWluZyBDUFVzIGFzIGVhcmx5L2xhdGUgYXMgcG9z
c2libGUuCgpTaWduZWQtT2ZmLUJ5OiBKYW4gQmV1bGljaCA8amJldWxpY2hAbm92ZWxsLmNvbT4K
CkluZGV4OiAyLjYuMTQtbmxrZC9hcmNoL2kzODYva2VybmVsL3NtcGJvb3QuYwo9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
Ci0tLSAyLjYuMTQtbmxrZC5vcmlnL2FyY2gvaTM4Ni9rZXJuZWwvc21wYm9vdC5jCTIwMDUtMTEt
MDkgMTA6NDA6MTcuMDAwMDAwMDAwICswMTAwCisrKyAyLjYuMTQtbmxrZC9hcmNoL2kzODYva2Vy
bmVsL3NtcGJvb3QuYwkyMDA1LTExLTA0IDE2OjE5OjMzLjAwMDAwMDAwMCArMDEwMApAQCAtNDg2
LDYgKzQ4Niw3IEBAIHN0YXRpYyB2b2lkIF9fZGV2aW5pdCBzdGFydF9zZWNvbmRhcnkodm8KIAlz
bXBfY2FsbGluKCk7CiAJd2hpbGUgKCFjcHVfaXNzZXQoc21wX3Byb2Nlc3Nvcl9pZCgpLCBzbXBf
Y29tbWVuY2VkX21hc2spKQogCQlyZXBfbm9wKCk7CisJY3B1X25vdGlmeShDUFVfQUxJVkUpOwog
CXNldHVwX3NlY29uZGFyeV9BUElDX2Nsb2NrKCk7CiAJaWYgKG5taV93YXRjaGRvZyA9PSBOTUlf
SU9fQVBJQykgewogCQlkaXNhYmxlXzgyNTlBX2lycSgwKTsKQEAgLTk3MCw2ICs5NzEsNyBAQCB2
b2lkIGNwdV9leGl0X2NsZWFyKHZvaWQpCiAJaW50IGNwdSA9IHJhd19zbXBfcHJvY2Vzc29yX2lk
KCk7CiAKIAlpZGxlX3Rhc2tfZXhpdCgpOworCWNwdV9ub3RpZnkoQ1BVX0RZSU5HKTsKIAogCWNw
dWNvdW50IC0tOwogCWNwdV91bmluaXQoKTsK

--=__Part9EBCA2C7.0__=--
