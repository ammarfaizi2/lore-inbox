Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965074AbVKHM6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965074AbVKHM6B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 07:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965136AbVKHM6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 07:58:00 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:57907
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S965074AbVKHM57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 07:57:59 -0500
Message-Id: <4370AF1E.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Tue, 08 Nov 2005 13:58:54 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] provide stricmp
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartE4C6DA1E.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartE4C6DA1E.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

While strnicmp existed in the set of string support routines, stricmp
didn't, which this patch adjusts.

From: Jan Beulich <jbeulich@novell.com>

(actual patch attached)


--=__PartE4C6DA1E.0__=
Content-Type: application/octet-stream; name="linux-2.6.14-stricmp.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.14-stricmp.patch"

V2hpbGUgc3RybmljbXAgZXhpc3RlZCBpbiB0aGUgc2V0IG9mIHN0cmluZyBzdXBwb3J0IHJvdXRp
bmVzLCBzdHJpY21wCmRpZG4ndCwgd2hpY2ggdGhpcyBwYXRjaCBhZGp1c3RzLgoKRnJvbTogSmFu
IEJldWxpY2ggPGpiZXVsaWNoQG5vdmVsbC5jb20+CgotLS0gMi42LjE0L2luY2x1ZGUvbGludXgv
c3RyaW5nLmgJMjAwNS0xMC0yOCAwMjowMjowOC4wMDAwMDAwMDAgKzAyMDAKKysrIDIuNi4xNC1z
dHJpY21wL2luY2x1ZGUvbGludXgvc3RyaW5nLmgJMjAwNS0xMS0wNCAxNjoxOTozNC4wMDAwMDAw
MDAgKzAxMDAKQEAgLTQ3LDYgKzQ3LDkgQEAgZXh0ZXJuIGludCBzdHJjbXAoY29uc3QgY2hhciAq
LGNvbnN0IGNoYQogI2lmbmRlZiBfX0hBVkVfQVJDSF9TVFJOQ01QCiBleHRlcm4gaW50IHN0cm5j
bXAoY29uc3QgY2hhciAqLGNvbnN0IGNoYXIgKixfX2tlcm5lbF9zaXplX3QpOwogI2VuZGlmCisj
aWZuZGVmIF9fSEFWRV9BUkNIX1NUUklDTVAKK2V4dGVybiBpbnQgc3RyaWNtcChjb25zdCBjaGFy
ICosIGNvbnN0IGNoYXIgKik7CisjZW5kaWYKICNpZm5kZWYgX19IQVZFX0FSQ0hfU1RSTklDTVAK
IGV4dGVybiBpbnQgc3RybmljbXAoY29uc3QgY2hhciAqLCBjb25zdCBjaGFyICosIF9fa2VybmVs
X3NpemVfdCk7CiAjZW5kaWYKLS0tIDIuNi4xNC9saWIvc3RyaW5nLmMJMjAwNS0xMC0yOCAwMjow
MjowOC4wMDAwMDAwMDAgKzAyMDAKKysrIDIuNi4xNC1zdHJpY21wL2xpYi9zdHJpbmcuYwkyMDA1
LTExLTA0IDE2OjE5OjM1LjAwMDAwMDAwMCArMDEwMApAQCAtMjQsNiArMjQsMzEgQEAKICNpbmNs
dWRlIDxsaW51eC9jdHlwZS5oPgogI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgogCisjaWZuZGVm
IF9fSEFWRV9BUkNIX1NUUklDTVAKKy8qKgorICogc3RyaWNtcCAtIENvbXBhcmUgdHdvIHN0cmlu
Z3MgY2FzZS1pbnNlbnNpdGl2ZWx5CisgKiBAczE6IE9uZSBzdHJpbmcKKyAqIEBzMjogQW5vdGhl
ciBzdHJpbmcKKyAqLworaW50IHN0cmljbXAoY29uc3QgY2hhciAqczEsIGNvbnN0IGNoYXIgKnMy
KQoreworCXVuc2lnbmVkIGNoYXIgYzEsIGMyOworCisJZm9yICg7OykgeworCQljMSA9ICpzMSsr
OworCQljMiA9ICpzMisrOworCQlpZiAoIWMxIHx8ICFjMikKKwkJCWJyZWFrOworCQlpZiAoYzEg
PT0gYzIpCisJCQljb250aW51ZTsKKwkJaWYgKChjMSA9IHRvbG93ZXIoYzEpKSAhPSAoYzIgPSB0
b2xvd2VyKGMyKSkpCisJCQlicmVhazsKKwl9CisJcmV0dXJuIChpbnQpYzEgLSAoaW50KWMyOwor
fQorI2VuZGlmCitFWFBPUlRfU1lNQk9MKHN0cmljbXApOworCiAjaWZuZGVmIF9fSEFWRV9BUkNI
X1NUUk5JQ01QCiAvKioKICAqIHN0cm5pY21wIC0gQ2FzZSBpbnNlbnNpdGl2ZSwgbGVuZ3RoLWxp
bWl0ZWQgc3RyaW5nIGNvbXBhcmlzb24K

--=__PartE4C6DA1E.0__=--
