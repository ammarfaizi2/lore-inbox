Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161857AbWKPGIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161857AbWKPGIO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 01:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031011AbWKPGIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 01:08:14 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:60580 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1031010AbWKPGIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 01:08:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:references:x-google-sender-auth;
        b=ERjjGzq5kLQZR+j/IBufvx6b1LtIcth9SxHZuIaDdaOEwY+rJlnja538ke+uSPmpYhp9PPCBjuG3D22PvBy5BwvCUuQUrQQVaw/07+Lpw/AFVakSHX5QuyCCb3W7D1l5mC98BoyZYD/MCMT/oEibNM49dumIHelZgxblxEf3O3o=
Message-ID: <86802c440611152208jf415991vdd348a0a369f8aa2@mail.gmail.com>
Date: Wed, 15 Nov 2006 22:08:11 -0800
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Olivier Nicolas" <olivn@trollprod.org>
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
Cc: "Linus Torvalds" <torvalds@osdl.org>, Mws <mws@twisted-brains.org>,
       "Jeff Garzik" <jeff@garzik.org>, "Krzysztof Halasa" <khc@pm.waw.pl>,
       "David Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       tiwai@suse.de
In-Reply-To: <455B7E3F.6040403@trollprod.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_90938_14781435.1163657291675"
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>
	 <455B688F.8070007@garzik.org>
	 <Pine.LNX.4.64.0611151127560.3349@woody.osdl.org>
	 <200611152059.53845.mws@twisted-brains.org>
	 <Pine.LNX.4.64.0611151210380.3349@woody.osdl.org>
	 <455B7E3F.6040403@trollprod.org>
X-Google-Sender-Auth: f304899ccfb462a0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_90938_14781435.1163657291675
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Please try the patch about using pci_intx.

it could use msi.

YH

------=_Part_90938_14781435.1163657291675
Content-Type: text/x-patch; name=hda_intel_pci_intx.diff; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eukreq2d
Content-Disposition: attachment; filename="hda_intel_pci_intx.diff"

ZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMgYi9zb3VuZC9wY2kvaGRhL2hk
YV9pbnRlbC5jCmluZGV4IGUzNWNmZDMuLjg4Yjk5YWIgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9o
ZGEvaGRhX2ludGVsLmMKKysrIGIvc291bmQvcGNpL2hkYS9oZGFfaW50ZWwuYwpAQCAtNTQ3LDYg
KzU0Nyw3IEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgYXp4X3JpcmJfZ2V0X3Jlc3BvbnMKIAkJY2hp
cC0+bXNpID0gMDsKIAkJaWYgKGF6eF9hY3F1aXJlX2lycShjaGlwLCAxKSA8IDApCiAJCQlyZXR1
cm4gLTE7CisJCXBjaV9pbnR4KGNoaXAtPnBjaSwgMSk7CiAJCWdvdG8gYWdhaW47CiAJfQogCkBA
IC0xNDM1LDExICsxNDM2LDE2IEBAIHN0YXRpYyBpbnQgYXp4X3Jlc3VtZShzdHJ1Y3QgcGNpX2Rl
diAqcGMKIAkJcmV0dXJuIC1FSU87CiAJfQogCXBjaV9zZXRfbWFzdGVyKHBjaSk7Ci0JaWYgKGNo
aXAtPm1zaSkKKwlpZiAoY2hpcC0+bXNpKSB7CisJCXBjaV9pbnR4KHBjaSwgMCk7CiAJCWlmIChw
Y2lfZW5hYmxlX21zaShwY2kpIDwgMCkKIAkJCWNoaXAtPm1zaSA9IDA7CisJfQogCWlmIChhenhf
YWNxdWlyZV9pcnEoY2hpcCwgMSkgPCAwKQogCQlyZXR1cm4gLUVJTzsKKworCWlmICghY2hpcC0+
bXNpKSAKKwkJcGNpX2ludHgocGNpLCAxKTsKIAlhenhfaW5pdF9jaGlwKGNoaXApOwogCXNuZF9o
ZGFfcmVzdW1lKGNoaXAtPmJ1cyk7CiAJc25kX3Bvd2VyX2NoYW5nZV9zdGF0ZShjYXJkLCBTTkRS
Vl9DVExfUE9XRVJfRDApOwpAQCAtMTUzMSw3ICsxNTM3LDggQEAgc3RhdGljIGludCBfX2Rldmlu
aXQgYXp4X2NyZWF0ZShzdHJ1Y3QgcwogCWNoaXAtPnBjaSA9IHBjaTsKIAljaGlwLT5pcnEgPSAt
MTsKIAljaGlwLT5kcml2ZXJfdHlwZSA9IGRyaXZlcl90eXBlOwotCWNoaXAtPm1zaSA9IGVuYWJs
ZV9tc2k7CisvLwljaGlwLT5tc2kgPSBlbmFibGVfbXNpOworCWNoaXAtPm1zaSA9IDE7CiAKIAlj
aGlwLT5wb3NpdGlvbl9maXggPSBwb3NpdGlvbl9maXg7CiAJY2hpcC0+c2luZ2xlX2NtZCA9IHNp
bmdsZV9jbWQ7CkBAIC0xNTYxLDE0ICsxNTY4LDE5IEBAICNlbmRpZgogCQlnb3RvIGVycm91dDsK
IAl9CiAKLQlpZiAoY2hpcC0+bXNpKQorCWlmIChjaGlwLT5tc2kpIHsKKwkJcGNpX2ludHgocGNp
LCAwKTsKIAkJaWYgKHBjaV9lbmFibGVfbXNpKHBjaSkgPCAwKQogCQkJY2hpcC0+bXNpID0gMDsK
Kwl9CiAKIAlpZiAoYXp4X2FjcXVpcmVfaXJxKGNoaXAsIDApIDwgMCkgewogCQllcnIgPSAtRUJV
U1k7CiAJCWdvdG8gZXJyb3V0OwogCX0KKwkKKwlpZighY2hpcC0+bXNpKQorCQlwY2lfaW50eChw
Y2ksIDEpOwogCiAJcGNpX3NldF9tYXN0ZXIocGNpKTsKIAlzeW5jaHJvbml6ZV9pcnEoY2hpcC0+
aXJxKTsK
------=_Part_90938_14781435.1163657291675--
