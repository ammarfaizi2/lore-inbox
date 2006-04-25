Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751589AbWDYVYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbWDYVYV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 17:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579AbWDYVYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 17:24:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:31297 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751586AbWDYVYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 17:24:20 -0400
X-IronPort-AV: i="4.04,154,1144047600"; 
   d="scan'208"; a="28499595:sNHT43763972"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C668AE.9218D2CE"
Subject: RE: Problems with EDAC coexisting with BIOS
Date: Tue, 25 Apr 2006 14:24:00 -0700
Message-ID: <5389061B65D50446B1783B97DFDB392DA97799@orsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: Problems with EDAC coexisting with BIOS
Thread-Index: AcZooinUFmuobZodQRKda3DhCVAlUQADCSbg
From: "Gross, Mark" <mark.gross@intel.com>
To: "Corey Minyard" <minyard@acm.org>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       <bluesmoke-devel@lists.sourceforge.net>,
       "LKML" <linux-kernel@vger.kernel.org>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Ong, Soo Keong" <soo.keong.ong@intel.com>,
       "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>
X-OriginalArrivalTime: 25 Apr 2006 21:24:01.0834 (UTC) FILETIME=[9283B0A0:01C668AE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C668AE.9218D2CE
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



>-----Original Message-----
>From: Corey Minyard [mailto:minyard@acm.org]
>Sent: Tuesday, April 25, 2006 12:55 PM
>To: Gross, Mark
>Cc: Alan Cox; bluesmoke-devel@lists.sourceforge.net; LKML; Carbonari,
>Steven; Ong, Soo Keong; Wang, Zhenyu Z
>Subject: Re: Problems with EDAC coexisting with BIOS
>
>Shouldn't you provide a way (kernel command line) to override this
check
>if the function can be safely unhidden?
>

Done.=20
Signed-off-by: Mark Gross


--mgross

------_=_NextPart_001_01C668AE.9218D2CE
Content-Type: application/octet-stream;
	name="e752x_edac.patch"
Content-Transfer-Encoding: base64
Content-Description: e752x_edac.patch
Content-Disposition: attachment;
	filename="e752x_edac.patch"

ZGlmZiAtdXJOIC1YIGxpbnV4LTIuNi4xNi9Eb2N1bWVudGF0aW9uL2RvbnRkaWZmIGxpbnV4LTIu
Ni4xNi9kcml2ZXJzL2VkYWMvZTc1MnhfZWRhYy5jIGxpbnV4LTIuNi4xNl9lZGFjL2RyaXZlcnMv
ZWRhYy9lNzUyeF9lZGFjLmMKLS0tIGxpbnV4LTIuNi4xNi9kcml2ZXJzL2VkYWMvZTc1MnhfZWRh
Yy5jCTIwMDYtMDMtMTkgMjE6NTM6MjkuMDAwMDAwMDAwIC0wODAwCisrKyBsaW51eC0yLjYuMTZf
ZWRhYy9kcml2ZXJzL2VkYWMvZTc1MnhfZWRhYy5jCTIwMDYtMDQtMjUgMTM6NTk6NDUuMDAwMDAw
MDAwIC0wNzAwCkBAIC0yOSw2ICsyOSw3IEBACiAKICNpbmNsdWRlICJlZGFjX21jLmgiCiAKK3N0
YXRpYyBpbnQgZm9yY2VfZnVuY3Rpb25fdW5oaWRlID0gMDsKIAogI2lmbmRlZiBQQ0lfREVWSUNF
X0lEX0lOVEVMXzc1MjBfMAogI2RlZmluZSBQQ0lfREVWSUNFX0lEX0lOVEVMXzc1MjBfMCAgICAg
IDB4MzU5MApAQCAtNzU1LDEwICs3NTYsMTkgQEAKIAlkZWJ1Z2YwKCJNQzogIiBfX0ZJTEVfXyAi
OiAlcygpOiBtY2lcbiIsIF9fZnVuY19fKTsKIAlkZWJ1Z2YwKCJTdGFydGluZyBQcm9iZTFcbiIp
OwogCi0JLyogZW5hYmxlIGRldmljZSAwIGZ1bmN0aW9uIDEgKi8KKwkvKiBjaGVjayB0byBzZWUg
aWYgZGV2aWNlIDAgZnVuY3Rpb24gMSBpcyBlbmJhbGVkIGlmIGl0IGlzbid0IHdlCisJICogYXNz
dW1lIHRoZSBCSU9TIGhhcyByZXNlcnZlZCBpdCBmb3IgYSByZWFzb24gYW5kIGlzIGV4cGVjdGlu
ZworCSAqIGV4Y2x1c2l2ZSBhY2Nlc3MsIHdlIHRha2UgY2FyZSB0byBub3QgdmlvbGF0ZSB0aGF0
IGFzc3VtcHRpb24gYW5kCisJICogZmFpbCB0aGUgcHJvYmUuICovCiAJcGNpX3JlYWRfY29uZmln
X2J5dGUocGRldiwgRTc1MlhfREVWUFJFUzEsICZzdGF0OCk7Ci0Jc3RhdDggfD0gKDEgPDwgNSk7
Ci0JcGNpX3dyaXRlX2NvbmZpZ19ieXRlKHBkZXYsIEU3NTJYX0RFVlBSRVMxLCBzdGF0OCk7CisJ
aWYgKCEoc3RhdDggJiAoMSA8PCA1KSkpIHsKKwkJcHJpbnRrKEtFUk5fSU5GTyAiY29udGFjdCB5
b3VyIGJpb3MgdmVuZG9yIHRvIHNlZSBpZiB0aGUgIiAKKwkJIkU3NTJ4IGVycm9yIHJlZ2lzdGVy
cyBjYW4gYmUgc2FmZWx5IHVuLWhpZGRlblxuIik7CisJCWlmICghZm9yY2VfZnVuY3Rpb25fdW5o
aWRlKQorCQkJZ290byBmYWlsOworCX0KKyAgICAgICAgc3RhdDggfD0gKDEgPDwgNSk7CisgICAg
ICAgIHBjaV93cml0ZV9jb25maWdfYnl0ZShwZGV2LCBFNzUyWF9ERVZQUkVTMSwgc3RhdDgpOwog
CiAJLyogbmVlZCB0byBmaW5kIG91dCB0aGUgbnVtYmVyIG9mIGNoYW5uZWxzICovCiAJcGNpX3Jl
YWRfY29uZmlnX2R3b3JkKHBkZXYsIEU3NTJYX0RSQywgJmRyYyk7CkBAIC0xMDY5LDMgKzEwNzks
OCBAQAogTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOwogTU9EVUxFX0FVVEhPUigiTGludXggTmV0d29y
eCAoaHR0cDovL2xueGkuY29tKSBUb20gWmltbWVybWFuXG4iKTsKIE1PRFVMRV9ERVNDUklQVElP
TigiTUMgc3VwcG9ydCBmb3IgSW50ZWwgZTc1MnggbWVtb3J5IGNvbnRyb2xsZXJzIik7CisKK21v
ZHVsZV9wYXJhbShmb3JjZV9mdW5jdGlvbl91bmhpZGUsIGludCwgMDY0NCk7CitNT0RVTEVfUEFS
TV9ERVNDKGZvcmNlX2Z1bmN0aW9uX3VuaGlkZSwgImlmIEJJT1Mgc2V0cyBEZXYwOkZ1bjEgdXAg
YXMgaGlkZGVuOiIKKyIgMT1mb3JjZSB1bmhpZGUgYW5kIGhvcGUgQklPUyBkb2Vzbid0IGZpZ2h0
IGRyaXZlciBmb3IgRGV2MDpGdW4xIGFjY2VzcyIpOworCg==

------_=_NextPart_001_01C668AE.9218D2CE--
