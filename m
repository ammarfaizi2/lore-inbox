Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031097AbWKPDuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031097AbWKPDuw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 22:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031096AbWKPDuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 22:50:52 -0500
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:41433 "EHLO
	outbound1-cpk-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1031097AbWKPDuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 22:50:51 -0500
X-BigFish: VP
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [PATCH] ALSA: hda-intel - Disable MSI support by default
Date: Wed, 15 Nov 2006 19:50:42 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA4907208@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] ALSA: hda-intel - Disable MSI support by default
Thread-Index: AccI+G+74GXGy7WIQ3ad7MeRPzzpxAAG1HgwAAeB11A=
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: "Lu, Yinghai" <yinghai.lu@amd.com>,
       "Olivier Nicolas" <olivn@trollprod.org>,
       "Linus Torvalds" <torvalds@osdl.org>
cc: "Mws" <mws@twisted-brains.org>, "Jeff Garzik" <jeff@garzik.org>,
       "Krzysztof Halasa" <khc@pm.waw.pl>,
       "David Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       tiwai@suse.de
X-OriginalArrivalTime: 16 Nov 2006 03:50:43.0684 (UTC)
 FILETIME=[642A0A40:01C70932]
X-WSS-ID: 69453F990T0490576-01-01
Content-Type: multipart/mixed;
 boundary="----_=_NextPart_001_01C70932.6396CF94"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C70932.6396CF94
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Add pci_intx to diable intx could make MSI work with pci.

Olivier, Please test it attached patch with latest git ... I hardcode to
make enable_msi=3D1.

YH


------_=_NextPart_001_01C70932.6396CF94
Content-Type: application/octet-stream;
 name=hda_intel_pci_intx.diff
Content-Transfer-Encoding: base64
Content-Description: hda_intel_pci_intx.diff
Content-Disposition: attachment;
 filename=hda_intel_pci_intx.diff

ZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMgYi9zb3VuZC9wY2kvaGRhL2hk
YV9pbnRlbC5jCmluZGV4IGUzNWNmZDMuLmU4YzRiZjUgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9o
ZGEvaGRhX2ludGVsLmMKKysrIGIvc291bmQvcGNpL2hkYS9oZGFfaW50ZWwuYwpAQCAtNTQ3LDYg
KzU0Nyw3IEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgYXp4X3JpcmJfZ2V0X3Jlc3BvbnMKIAkJY2hp
cC0+bXNpID0gMDsKIAkJaWYgKGF6eF9hY3F1aXJlX2lycShjaGlwLCAxKSA8IDApCiAJCQlyZXR1
cm4gLTE7CisJCXBjaV9pbnR4KGNoaXAtPnBjaSwgMSk7CiAJCWdvdG8gYWdhaW47CiAJfQogCkBA
IC0xNDM1LDExICsxNDM2LDE3IEBAIHN0YXRpYyBpbnQgYXp4X3Jlc3VtZShzdHJ1Y3QgcGNpX2Rl
diAqcGMKIAkJcmV0dXJuIC1FSU87CiAJfQogCXBjaV9zZXRfbWFzdGVyKHBjaSk7Ci0JaWYgKGNo
aXAtPm1zaSkKLQkJaWYgKHBjaV9lbmFibGVfbXNpKHBjaSkgPCAwKQorCWlmIChjaGlwLT5tc2kp
IHsKKwkJcGNpX2ludHgocGNpLCAwKTsKKwkJaWYgKHBjaV9lbmFibGVfbXNpKHBjaSkgPCAwKSB7
CiAJCQljaGlwLT5tc2kgPSAwOworCQl9CisJfQogCWlmIChhenhfYWNxdWlyZV9pcnEoY2hpcCwg
MSkgPCAwKQogCQlyZXR1cm4gLUVJTzsKKworCWlmICghY2hpcC0+bXNpKSAKKwkJcGNpX2ludHgo
cGNpLCAxKTsKIAlhenhfaW5pdF9jaGlwKGNoaXApOwogCXNuZF9oZGFfcmVzdW1lKGNoaXAtPmJ1
cyk7CiAJc25kX3Bvd2VyX2NoYW5nZV9zdGF0ZShjYXJkLCBTTkRSVl9DVExfUE9XRVJfRDApOwpA
QCAtMTUzMSw3ICsxNTM4LDggQEAgc3RhdGljIGludCBfX2RldmluaXQgYXp4X2NyZWF0ZShzdHJ1
Y3QgcwogCWNoaXAtPnBjaSA9IHBjaTsKIAljaGlwLT5pcnEgPSAtMTsKIAljaGlwLT5kcml2ZXJf
dHlwZSA9IGRyaXZlcl90eXBlOwotCWNoaXAtPm1zaSA9IGVuYWJsZV9tc2k7CisvLwljaGlwLT5t
c2kgPSBlbmFibGVfbXNpOworCWNoaXAtPm1zaSA9IDE7CiAKIAljaGlwLT5wb3NpdGlvbl9maXgg
PSBwb3NpdGlvbl9maXg7CiAJY2hpcC0+c2luZ2xlX2NtZCA9IHNpbmdsZV9jbWQ7CkBAIC0xNTYx
LDE0ICsxNTY5LDIwIEBAICNlbmRpZgogCQlnb3RvIGVycm91dDsKIAl9CiAKLQlpZiAoY2hpcC0+
bXNpKQotCQlpZiAocGNpX2VuYWJsZV9tc2kocGNpKSA8IDApCisJaWYgKGNoaXAtPm1zaSkgewor
CQlwY2lfaW50eChwY2ksIDApOworCQlpZiAocGNpX2VuYWJsZV9tc2kocGNpKSA8IDApIHsKIAkJ
CWNoaXAtPm1zaSA9IDA7CisJCX0KKwl9CiAKIAlpZiAoYXp4X2FjcXVpcmVfaXJxKGNoaXAsIDAp
IDwgMCkgewogCQllcnIgPSAtRUJVU1k7CiAJCWdvdG8gZXJyb3V0OwogCX0KKwkKKwlpZighY2hp
cC0+bXNpKQorCQlwY2lfaW50eChwY2ksIDEpOwogCiAJcGNpX3NldF9tYXN0ZXIocGNpKTsKIAlz
eW5jaHJvbml6ZV9pcnEoY2hpcC0+aXJxKTsK

------_=_NextPart_001_01C70932.6396CF94--


