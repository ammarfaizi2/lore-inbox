Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935593AbWK1FJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935593AbWK1FJW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 00:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935597AbWK1FJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 00:09:22 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:30414 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S935593AbWK1FJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 00:09:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:references:x-google-sender-auth;
        b=UL6N7rDQPiB/av6W9/XbAGUEN7ixQhncR4IP8HxWq1kypMqW/hOiiJOlQAOdT2Tj/cJq9Cn8hZ3SV43TwUh5DF91bc50B9+XXXWFBUzf64X+HBI/W5RRltY1Nv0+mEdZ8/q51SEK4hrXQWx28QdyU90aa7xV0d4vSOYBmVYhjmM=
Message-ID: <86802c440611272109n8a847f7ia61e247bdd16fa49@mail.gmail.com>
Date: Mon, 27 Nov 2006 21:09:19 -0800
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Len Brown" <lenb@kernel.org>
Subject: Re: [PATCH 3/3] x86: when acpi_noirq is set, use mptable instead of MADT
Cc: "Andrew Morton" <akpm@osdl.org>, "Andi Kleen" <ak@muc.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200611270037.53964.len.brown@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_2769_23584752.1164690559600"
References: <86802c440611261524p6b170f50rf7db3eafd4f7602e@mail.gmail.com>
	 <200611270037.53964.len.brown@intel.com>
X-Google-Sender-Auth: 477bc91be9db2d42
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_2769_23584752.1164690559600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Please check the updated patch.

------=_Part_2769_23584752.1164690559600
Content-Type: text/x-patch; name=ai_4.diff; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ev1umzhl
Content-Disposition: attachment; filename="ai_4.diff"

W1BBVENIIDMvM10geDg2OiB3aGVuIGFjcGlfbm9pcnEgaXMgc2V0LCB1c2UgbXB0YWJsZSBpbnN0
ZWFkIG9mIE1BRFQKCklmIG5vIERTRFQgZm91bmQsIGNhbGwgYWNwaV9kaXNhYmxlX3BjaQoKV2hl
biB1c2luZyBwY2k9bm9hY3BpLCBvciBhcGNpPW5vaXJxLCBhY3BpX25vaXJxIGlzIHNldC4gV2Ug
c2hvdWxkIHNraXAKYWNwaV9wcm9jZXNzX21hZHQuIFNvIHRvIGF2b2lkIGVudW1lcmF0ZSBsYXBp
YyB0d28gdGltZXMuCgpTaWduZWQtb2ZmLWJ5OiBZaW5naGFpIEx1IDx5aW5naGFpLmx1QGFtZC5j
b20+CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL3RhYmxlcy5jIGIvZHJpdmVycy9hY3BpL3Rh
Ymxlcy5jCmluZGV4IGJmYjNiZmMuLmY0OTdkNzggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYWNwaS90
YWJsZXMuYworKysgYi9kcml2ZXJzL2FjcGkvdGFibGVzLmMKQEAgLTI5Nyw2ICsyOTcsNyBAQCBh
Y3BpX2dldF90YWJsZV9oZWFkZXJfZWFybHkoZW51bSBhY3BpX3RhCiAKIAkJaWYgKCEqaGVhZGVy
KSB7CiAJCQlwcmludGsoS0VSTl9XQVJOSU5HIFBSRUZJWCAiVW5hYmxlIHRvIG1hcCBEU0RUXG4i
KTsKKwkJCWFjcGlfZGlzYWJsZV9wY2koKTsKIAkJCXJldHVybiAtRU5PREVWOwogCQl9CiAJfQpk
aWZmIC0tZ2l0IGEvYXJjaC9pMzg2L2tlcm5lbC9hY3BpL2Jvb3QuYyBiL2FyY2gvaTM4Ni9rZXJu
ZWwvYWNwaS9ib290LmMKaW5kZXggZDEyZmI5Ny4uMGQzNTBkMCAxMDA2NDQKLS0tIGEvYXJjaC9p
Mzg2L2tlcm5lbC9hY3BpL2Jvb3QuYworKysgYi9hcmNoL2kzODYva2VybmVsL2FjcGkvYm9vdC5j
CkBAIC0xMjQyLDcgKzEyNDIsMTEgQEAgaW50IF9faW5pdCBhY3BpX2Jvb3RfaW5pdCh2b2lkKQog
CS8qCiAJICogUHJvY2VzcyB0aGUgTXVsdGlwbGUgQVBJQyBEZXNjcmlwdGlvbiBUYWJsZSAoTUFE
VCksIGlmIHByZXNlbnQKIAkgKi8KLQlhY3BpX3Byb2Nlc3NfbWFkdCgpOworCS8qIHdpdGggYWNw
aV9ub2lycSB3ZSBkb24ndCBuZWVkIHRvIHByb2Nlc3MgbWFkdCwgU28gZG9uJ3QgbmVlZCAKKwkg
Kgllbm51bWVyYXRlIGxhcGljIHR3byB0aW1lcyAKKwkgKi8KKwlpZighYWNwaV9ub2lycSAmJiAh
YWNwaV9wY2lfZGlzYWJsZWQpCisJCWFjcGlfcHJvY2Vzc19tYWR0KCk7CiAKIAlhY3BpX3RhYmxl
X3BhcnNlKEFDUElfSFBFVCwgYWNwaV9wYXJzZV9ocGV0KTsKIAo=
------=_Part_2769_23584752.1164690559600--
