Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbWDYX0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWDYX0R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 19:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWDYX0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 19:26:17 -0400
Received: from mga01.intel.com ([192.55.52.88]:5747 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932294AbWDYX0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 19:26:16 -0400
X-IronPort-AV: i="4.04,155,1144047600"; 
   d="scan'208"; a="28550016:sNHT50859508"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C668BF.9C614E4E"
Subject: RE: Problems with EDAC coexisting with BIOS
Date: Tue, 25 Apr 2006 16:25:59 -0700
Message-ID: <5389061B65D50446B1783B97DFDB392DA97BD0@orsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: Problems with EDAC coexisting with BIOS
Thread-Index: AcZouU6hzb7NTxjeRKuPcktduNJ4ugABgiJw
From: "Gross, Mark" <mark.gross@intel.com>
To: "Corey Minyard" <minyard@acm.org>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       <bluesmoke-devel@lists.sourceforge.net>,
       "LKML" <linux-kernel@vger.kernel.org>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Ong, Soo Keong" <soo.keong.ong@intel.com>,
       "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>
X-OriginalArrivalTime: 25 Apr 2006 23:26:00.0348 (UTC) FILETIME=[9CB04DC0:01C668BF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C668BF.9C614E4E
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



>-----Original Message-----
>From: Corey Minyard [mailto:minyard@acm.org]
>Sent: Tuesday, April 25, 2006 3:40 PM
>To: Gross, Mark
>Cc: Alan Cox; bluesmoke-devel@lists.sourceforge.net; LKML; Carbonari,
>Steven; Ong, Soo Keong; Wang, Zhenyu Z
>Subject: Re: Problems with EDAC coexisting with BIOS
>
>Gross, Mark wrote:
>
>>>
>>>
>>>
>>
>>Done.
>>Signed-off-by: Mark Gross
>>
>>
>>--mgross
>>
>>
>Yes, this is what I was talking about.  I believe the mode of
>module_param should be 444, since modifying this after the module is
>loaded won't do anything.  Also, it might be nice to print something
>different in the "force" case.

How about printing nothing like it used too?

See attached. =20

Signed-off-by: Mark Gross

--mgross

------_=_NextPart_001_01C668BF.9C614E4E
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
ZWRhYy9kcml2ZXJzL2VkYWMvZTc1MnhfZWRhYy5jCTIwMDYtMDQtMjUgMTY6MTk6MjUuMDAwMDAw
MDAwIC0wNzAwCkBAIC0yOSw2ICsyOSw3IEBACiAKICNpbmNsdWRlICJlZGFjX21jLmgiCiAKK3N0
YXRpYyBpbnQgZm9yY2VfZnVuY3Rpb25fdW5oaWRlID0gMDsKIAogI2lmbmRlZiBQQ0lfREVWSUNF
X0lEX0lOVEVMXzc1MjBfMAogI2RlZmluZSBQQ0lfREVWSUNFX0lEX0lOVEVMXzc1MjBfMCAgICAg
IDB4MzU5MApAQCAtNzU1LDEwICs3NTYsMTggQEAKIAlkZWJ1Z2YwKCJNQzogIiBfX0ZJTEVfXyAi
OiAlcygpOiBtY2lcbiIsIF9fZnVuY19fKTsKIAlkZWJ1Z2YwKCJTdGFydGluZyBQcm9iZTFcbiIp
OwogCi0JLyogZW5hYmxlIGRldmljZSAwIGZ1bmN0aW9uIDEgKi8KKwkvKiBjaGVjayB0byBzZWUg
aWYgZGV2aWNlIDAgZnVuY3Rpb24gMSBpcyBlbmJhbGVkIGlmIGl0IGlzbid0IHdlCisJICogYXNz
dW1lIHRoZSBCSU9TIGhhcyByZXNlcnZlZCBpdCBmb3IgYSByZWFzb24gYW5kIGlzIGV4cGVjdGlu
ZworCSAqIGV4Y2x1c2l2ZSBhY2Nlc3MsIHdlIHRha2UgY2FyZSB0byBub3QgdmlvbGF0ZSB0aGF0
IGFzc3VtcHRpb24gYW5kCisJICogZmFpbCB0aGUgcHJvYmUuICovCiAJcGNpX3JlYWRfY29uZmln
X2J5dGUocGRldiwgRTc1MlhfREVWUFJFUzEsICZzdGF0OCk7Ci0Jc3RhdDggfD0gKDEgPDwgNSk7
Ci0JcGNpX3dyaXRlX2NvbmZpZ19ieXRlKHBkZXYsIEU3NTJYX0RFVlBSRVMxLCBzdGF0OCk7CisJ
aWYgKCFmb3JjZV9mdW5jdGlvbl91bmhpZGUgJiYgIShzdGF0OCAmICgxIDw8IDUpKSkgeworCQlw
cmludGsoS0VSTl9JTkZPICJjb250YWN0IHlvdXIgYmlvcyB2ZW5kb3IgdG8gc2VlIGlmIHRoZSAi
IAorCQkiRTc1MnggZXJyb3IgcmVnaXN0ZXJzIGNhbiBiZSBzYWZlbHkgdW4taGlkZGVuXG4iKTsK
KwkJCWdvdG8gZmFpbDsKKwl9CisgICAgICAgIHN0YXQ4IHw9ICgxIDw8IDUpOworICAgICAgICBw
Y2lfd3JpdGVfY29uZmlnX2J5dGUocGRldiwgRTc1MlhfREVWUFJFUzEsIHN0YXQ4KTsKIAogCS8q
IG5lZWQgdG8gZmluZCBvdXQgdGhlIG51bWJlciBvZiBjaGFubmVscyAqLwogCXBjaV9yZWFkX2Nv
bmZpZ19kd29yZChwZGV2LCBFNzUyWF9EUkMsICZkcmMpOwpAQCAtMTA2OSwzICsxMDc4LDggQEAK
IE1PRFVMRV9MSUNFTlNFKCJHUEwiKTsKIE1PRFVMRV9BVVRIT1IoIkxpbnV4IE5ldHdvcnggKGh0
dHA6Ly9sbnhpLmNvbSkgVG9tIFppbW1lcm1hblxuIik7CiBNT0RVTEVfREVTQ1JJUFRJT04oIk1D
IHN1cHBvcnQgZm9yIEludGVsIGU3NTJ4IG1lbW9yeSBjb250cm9sbGVycyIpOworCittb2R1bGVf
cGFyYW0oZm9yY2VfZnVuY3Rpb25fdW5oaWRlLCBpbnQsIDA0NDQpOworTU9EVUxFX1BBUk1fREVT
Qyhmb3JjZV9mdW5jdGlvbl91bmhpZGUsICJpZiBCSU9TIHNldHMgRGV2MDpGdW4xIHVwIGFzIGhp
ZGRlbjoiCisiIDE9Zm9yY2UgdW5oaWRlIGFuZCBob3BlIEJJT1MgZG9lc24ndCBmaWdodCBkcml2
ZXIgZm9yIERldjA6RnVuMSBhY2Nlc3MiKTsKKwo=

------_=_NextPart_001_01C668BF.9C614E4E--
