Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbVKIODX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbVKIODX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 09:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbVKIODW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 09:03:22 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:16175
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750735AbVKIODW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 09:03:22 -0500
Message-Id: <43720FF6.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Wed, 09 Nov 2005 15:04:22 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH 9/39] NLKD - hotkey notification
References: <43720DAE.76F0.0078.0@novell.com> <43720E2E.76F0.0078.0@novell.com> <43720E72.76F0.0078.0@novell.com> <43720EAF.76F0.0078.0@novell.com> <43720F5E.76F0.0078.0@novell.com> <43720F95.76F0.0078.0@novell.com> <43720FBA.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartAE8C92F6.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartAE8C92F6.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

A mechanism to allow debuggers to trigger on a certain hotkey
(combination). Derived (generalized) from similar KDB work.

Signed-Off-By: Jan Beulich <jbeulich@novell.com>

(actual patch attached)


--=__PartAE8C92F6.0__=
Content-Type: application/octet-stream; name="linux-2.6.14-nlkd-notify-keyboard.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.14-nlkd-notify-keyboard.patch"

QSBtZWNoYW5pc20gdG8gYWxsb3cgZGVidWdnZXJzIHRvIHRyaWdnZXIgb24gYSBjZXJ0YWluIGhv
dGtleQooY29tYmluYXRpb24pLiBEZXJpdmVkIChnZW5lcmFsaXplZCkgZnJvbSBzaW1pbGFyIEtE
QiB3b3JrLgoKU2lnbmVkLU9mZi1CeTogSmFuIEJldWxpY2ggPGpiZXVsaWNoQG5vdmVsbC5jb20+
CgpJbmRleDogMi42LjE0LW5sa2QvZHJpdmVycy9jaGFyL2tleWJvYXJkLmMKPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQot
LS0gMi42LjE0LW5sa2Qub3JpZy9kcml2ZXJzL2NoYXIva2V5Ym9hcmQuYwkyMDA1LTExLTA5IDEw
OjQwOjE3LjAwMDAwMDAwMCArMDEwMAorKysgMi42LjE0LW5sa2QvZHJpdmVycy9jaGFyL2tleWJv
YXJkLmMJMjAwNS0xMS0wNyAwOTozOTowNS4wMDAwMDAwMDAgKzAxMDAKQEAgLTM5LDYgKzM5LDcg
QEAKICNpbmNsdWRlIDxsaW51eC92dF9rZXJuLmg+CiAjaW5jbHVkZSA8bGludXgvc3lzcnEuaD4K
ICNpbmNsdWRlIDxsaW51eC9pbnB1dC5oPgorI2luY2x1ZGUgPGxpbnV4L2tkZWJ1Zy5oPgogCiBz
dGF0aWMgdm9pZCBrYmRfZGlzY29ubmVjdChzdHJ1Y3QgaW5wdXRfaGFuZGxlICpoYW5kbGUpOwog
ZXh0ZXJuIHZvaWQgY3RybF9hbHRfZGVsKHZvaWQpOwpAQCAtMTUzLDYgKzE1NCw5IEBAIHN0YXRp
YyBpbnQgc3lzcnFfZG93bjsKICNlbmRpZgogc3RhdGljIGludCBzeXNycV9hbHQ7CiAKK3N0cnVj
dCBub3RpZmllcl9ibG9jayAqa2RlYnVnX2NoYWluID0gTlVMTDsKK0VYUE9SVF9TWU1CT0woa2Rl
YnVnX2NoYWluKTsKKwogLyoKICAqIFRyYW5zbGF0aW9uIG9mIHNjYW5jb2RlcyB0byBrZXljb2Rl
cy4gV2Ugc2V0IHRoZW0gb24gb25seSB0aGUgZmlyc3QgYXR0YWNoZWQKICAqIGtleWJvYXJkIC0g
Zm9yIHBlci1rZXlib2FyZCBzZXR0aW5nLCAvZGV2L2lucHV0L2V2ZW50IGlzIG1vcmUgdXNlZnVs
LgpAQCAtMTA1Miw2ICsxMDU2LDExIEBAIHN0YXRpYyB2b2lkIGtiZF9rZXljb2RlKHVuc2lnbmVk
IGludCBrZXkKIAogCXJlcCA9IChkb3duID09IDIpOwogCisJaWYgKG5vdGlmeV9rZGVidWcoS0RF
QlVHX0tFWUJPQVJELAorCSAgICAgICAgICAgICAgICAgIGtleWNvZGUgfCAoKGxvbmcpIWRvd24g
PDwgKEJJVFNfUEVSX0xPTkcgLSAxKSksCisJICAgICAgICAgICAgICAgICAgcmVncykgPT0gTk9U
SUZZX1NUT1ApCisJCXJldHVybjsKKwogI2lmZGVmIENPTkZJR19NQUNfRU1VTU9VU0VCVE4KIAlp
ZiAobWFjX2hpZF9tb3VzZV9lbXVsYXRlX2J1dHRvbnMoMSwga2V5Y29kZSwgZG93bikpCiAJCXJl
dHVybjsKSW5kZXg6IDIuNi4xNC1ubGtkL2luY2x1ZGUvbGludXgva2RlYnVnLmgKPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQotLS0gL2Rldi9udWxsCTE5NzAtMDEtMDEgMDA6MDA6MDAuMDAwMDAwMDAwICswMDAwCisrKyAy
LjYuMTQtbmxrZC9pbmNsdWRlL2xpbnV4L2tkZWJ1Zy5oCTIwMDUtMTEtMDkgMTA6MjU6MTYuMDAw
MDAwMDAwICswMTAwCkBAIC0wLDAgKzEsMjcgQEAKKyNpZm5kZWYgX0tERUJVR19ICisjZGVmaW5l
IF9LREVCVUdfSAorCisvKgorICogVGhpcyBub3RpZmllciBpcyB0byByZXBsYWNlIGhhcmRjb2Rl
ZCBlbnRyaWVzIGluIGUuZy4gdGhlIGtleWJvYXJkCisgKiBkcml2ZXIgdXNlZCBieSBrZXJuZWwg
ZGVidWdnZXJzLgorICovCisjaW5jbHVkZSA8bGludXgvbm90aWZpZXIuaD4KKworc3RydWN0IHB0
X3JlZ3M7CisKK3N0cnVjdCBrZGVidWdfYXJncyB7CisJc3RydWN0IHB0X3JlZ3MgKnJlZ3M7CisJ
bG9uZyBkYXRhOworfTsKKworZXh0ZXJuIHN0cnVjdCBub3RpZmllcl9ibG9jayAqa2RlYnVnX2No
YWluOworCisjZGVmaW5lIEtERUJVR19LRVlCT0FSRCAxCisKK3N0YXRpYyBpbmxpbmUgaW50IG5v
dGlmeV9rZGVidWcodW5zaWduZWQgbG9uZyBldmVudCwgbG9uZyBkYXRhLCBzdHJ1Y3QgcHRfcmVn
cyAqcmVncykKK3sKKwlzdHJ1Y3Qga2RlYnVnX2FyZ3MgYXJncyA9IHsgLnJlZ3M9cmVncywgLmRh
dGEgPSBkYXRhIH07CisJcmV0dXJuIG5vdGlmaWVyX2NhbGxfY2hhaW4oJmtkZWJ1Z19jaGFpbiwg
ZXZlbnQsICZhcmdzKTsKK30KKworI2VuZGlmCg==

--=__PartAE8C92F6.0__=--
