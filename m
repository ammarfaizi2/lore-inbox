Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424604AbWKPX55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424604AbWKPX55 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 18:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424601AbWKPX55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 18:57:57 -0500
Received: from outbound-ash.frontbridge.com ([206.16.192.249]:32705 "EHLO
	outbound2-ash-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1424604AbWKPX54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 18:57:56 -0500
X-BigFish: VP
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [PATCH] ALSA: hda-intel - Disable MSI support by default
Date: Thu, 16 Nov 2006 15:54:37 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA490720E@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] ALSA: hda-intel - Disable MSI support by default
Thread-Index: AccJ1//X0U6vGLh9QmW7r74nfxg/IgAAbtAA
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: "Olivier Nicolas" <olivn@trollprod.org>
cc: "Linus Torvalds" <torvalds@osdl.org>, "Mws" <mws@twisted-brains.org>,
       "Jeff Garzik" <jeff@garzik.org>, "Krzysztof Halasa" <khc@pm.waw.pl>,
       "David Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       tiwai@suse.de
X-OriginalArrivalTime: 16 Nov 2006 23:54:38.0775 (UTC)
 FILETIME=[93A23470:01C709DA]
X-WSS-ID: 694225B40T0579871-01-01
Content-Type: multipart/mixed;
 boundary="----_=_NextPart_001_01C709DA.92CBA203"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C709DA.92CBA203
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: quoted-printable

-----Original Message-----
From: Olivier Nicolas [mailto:olivn@trollprod.org]=20


>IRQ 22 is disabled but snd_hda_intel seems to get a MSI interrupt! (It=20
>cannot be reproduced)

>313:          0          1   PCI-MSI-edge      HDA Intel

Please try attached one, also build hda_intel into kernel directly if it
is not.

YH


------_=_NextPart_001_01C709DA.92CBA203
Content-Type: application/octet-stream;
 name=hda_intel_pci_intx_11162006.diff
Content-Transfer-Encoding: base64
Content-Description: hda_intel_pci_intx_11162006.diff
Content-Disposition: attachment;
 filename=hda_intel_pci_intx_11162006.diff

ZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMgYi9zb3VuZC9wY2kvaGRhL2hk
YV9pbnRlbC5jCmluZGV4IGUzNWNmZDMuLjk4ZDI1ZDggMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9o
ZGEvaGRhX2ludGVsLmMKKysrIGIvc291bmQvcGNpL2hkYS9oZGFfaW50ZWwuYwpAQCAtNTUsNyAr
NTUsNyBAQCBzdGF0aWMgY2hhciAqbW9kZWw7CiBzdGF0aWMgaW50IHBvc2l0aW9uX2ZpeDsKIHN0
YXRpYyBpbnQgcHJvYmVfbWFzayA9IC0xOwogc3RhdGljIGludCBzaW5nbGVfY21kOwotc3RhdGlj
IGludCBlbmFibGVfbXNpOworc3RhdGljIGludCBkaXNhYmxlX21zaTsKIAogbW9kdWxlX3BhcmFt
KGluZGV4LCBpbnQsIDA0NDQpOwogTU9EVUxFX1BBUk1fREVTQyhpbmRleCwgIkluZGV4IHZhbHVl
IGZvciBJbnRlbCBIRCBhdWRpbyBpbnRlcmZhY2UuIik7CkBAIC02OSw4ICs2OSw4IEBAIG1vZHVs
ZV9wYXJhbShwcm9iZV9tYXNrLCBpbnQsIDA0NDQpOwogTU9EVUxFX1BBUk1fREVTQyhwcm9iZV9t
YXNrLCAiQml0bWFzayB0byBwcm9iZSBjb2RlY3MgKGRlZmF1bHQgPSAtMSkuIik7CiBtb2R1bGVf
cGFyYW0oc2luZ2xlX2NtZCwgYm9vbCwgMDQ0NCk7CiBNT0RVTEVfUEFSTV9ERVNDKHNpbmdsZV9j
bWQsICJVc2Ugc2luZ2xlIGNvbW1hbmQgdG8gY29tbXVuaWNhdGUgd2l0aCBjb2RlY3MgKGZvciBk
ZWJ1Z2dpbmcgb25seSkuIik7Ci1tb2R1bGVfcGFyYW0oZW5hYmxlX21zaSwgaW50LCAwKTsKLU1P
RFVMRV9QQVJNX0RFU0MoZW5hYmxlX21zaSwgIkVuYWJsZSBNZXNzYWdlIFNpZ25hbGVkIEludGVy
cnVwdCAoTVNJKSIpOworbW9kdWxlX3BhcmFtKGRpc2FibGVfbXNpLCBpbnQsIDApOworTU9EVUxF
X1BBUk1fREVTQyhkaXNhYmxlX21zaSwgIkRpc2FibGUgTWVzc2FnZSBTaWduYWxlZCBJbnRlcnJ1
cHQgKE1TSSkiKTsKIAogCiAvKiBqdXN0IGZvciBiYWNrd2FyZCBjb21wYXRpYmlsaXR5ICovCkBA
IC01NDcsNiArNTQ3LDcgQEAgc3RhdGljIHVuc2lnbmVkIGludCBhenhfcmlyYl9nZXRfcmVzcG9u
cwogCQljaGlwLT5tc2kgPSAwOwogCQlpZiAoYXp4X2FjcXVpcmVfaXJxKGNoaXAsIDEpIDwgMCkK
IAkJCXJldHVybiAtMTsKKwkJcGNpX2ludHgoY2hpcC0+cGNpLCAxKTsKIAkJZ290byBhZ2FpbjsK
IAl9CiAKQEAgLTEzODAsNyArMTM4MSw4IEBAIHN0YXRpYyBpbnQgX19kZXZpbml0IGF6eF9pbml0
X3N0cmVhbShzdHIKIAogc3RhdGljIGludCBhenhfYWNxdWlyZV9pcnEoc3RydWN0IGF6eCAqY2hp
cCwgaW50IGRvX2Rpc2Nvbm5lY3QpCiB7Ci0JaWYgKHJlcXVlc3RfaXJxKGNoaXAtPnBjaS0+aXJx
LCBhenhfaW50ZXJydXB0LCBJUlFGX0RJU0FCTEVEfElSUUZfU0hBUkVELAorCWlmIChyZXF1ZXN0
X2lycShjaGlwLT5wY2ktPmlycSwgYXp4X2ludGVycnVwdCwKKwkJCWNoaXAtPm1zaSA/IDAgOiBJ
UlFGX1NIQVJFRCwKIAkJCSJIREEgSW50ZWwiLCBjaGlwKSkgewogCQlwcmludGsoS0VSTl9FUlIg
ImhkYS1pbnRlbDogdW5hYmxlIHRvIGdyYWIgSVJRICVkLCAiCiAJCSAgICAgICAiZGlzYWJsaW5n
IGRldmljZVxuIiwgY2hpcC0+cGNpLT5pcnEpOwpAQCAtMTQzNSwxMSArMTQzNywxNiBAQCBzdGF0
aWMgaW50IGF6eF9yZXN1bWUoc3RydWN0IHBjaV9kZXYgKnBjCiAJCXJldHVybiAtRUlPOwogCX0K
IAlwY2lfc2V0X21hc3RlcihwY2kpOwotCWlmIChjaGlwLT5tc2kpCisJaWYgKGNoaXAtPm1zaSkg
eworCQlwY2lfaW50eChwY2ksIDApOwogCQlpZiAocGNpX2VuYWJsZV9tc2kocGNpKSA8IDApCiAJ
CQljaGlwLT5tc2kgPSAwOworCX0KIAlpZiAoYXp4X2FjcXVpcmVfaXJxKGNoaXAsIDEpIDwgMCkK
IAkJcmV0dXJuIC1FSU87CisKKwlpZiAoIWNoaXAtPm1zaSkgCisJCXBjaV9pbnR4KHBjaSwgMSk7
CiAJYXp4X2luaXRfY2hpcChjaGlwKTsKIAlzbmRfaGRhX3Jlc3VtZShjaGlwLT5idXMpOwogCXNu
ZF9wb3dlcl9jaGFuZ2Vfc3RhdGUoY2FyZCwgU05EUlZfQ1RMX1BPV0VSX0QwKTsKQEAgLTE1MzEs
NyArMTUzOCw3IEBAIHN0YXRpYyBpbnQgX19kZXZpbml0IGF6eF9jcmVhdGUoc3RydWN0IHMKIAlj
aGlwLT5wY2kgPSBwY2k7CiAJY2hpcC0+aXJxID0gLTE7CiAJY2hpcC0+ZHJpdmVyX3R5cGUgPSBk
cml2ZXJfdHlwZTsKLQljaGlwLT5tc2kgPSBlbmFibGVfbXNpOworCWNoaXAtPm1zaSA9ICFkaXNh
YmxlX21zaTsKIAogCWNoaXAtPnBvc2l0aW9uX2ZpeCA9IHBvc2l0aW9uX2ZpeDsKIAljaGlwLT5z
aW5nbGVfY21kID0gc2luZ2xlX2NtZDsKQEAgLTE1NjEsMTQgKzE1NjgsMTkgQEAgI2VuZGlmCiAJ
CWdvdG8gZXJyb3V0OwogCX0KIAotCWlmIChjaGlwLT5tc2kpCisJaWYgKGNoaXAtPm1zaSkgewor
CQlwY2lfaW50eChwY2ksIDApOwogCQlpZiAocGNpX2VuYWJsZV9tc2kocGNpKSA8IDApCiAJCQlj
aGlwLT5tc2kgPSAwOworCX0KIAogCWlmIChhenhfYWNxdWlyZV9pcnEoY2hpcCwgMCkgPCAwKSB7
CiAJCWVyciA9IC1FQlVTWTsKIAkJZ290byBlcnJvdXQ7CiAJfQorCQorCWlmKCFjaGlwLT5tc2kp
CisJCXBjaV9pbnR4KHBjaSwgMSk7CiAKIAlwY2lfc2V0X21hc3RlcihwY2kpOwogCXN5bmNocm9u
aXplX2lycShjaGlwLT5pcnEpOwo=

------_=_NextPart_001_01C709DA.92CBA203--


