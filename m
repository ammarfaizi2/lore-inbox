Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754341AbWKZXXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754341AbWKZXXj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 18:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754887AbWKZXXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 18:23:39 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:64689 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1754341AbWKZXXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 18:23:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:mime-version:content-type:x-google-sender-auth;
        b=KdipeKQ+rHGbI5gANjjMmi4xLwCfNYNnQQiD2Z/ylWu7WIqfiCvVTdNmKrjXyn2U8hyBCysYRySu3WJwZwfd8keKmhJx3EsQw2rDpcNMiW1AC1t7DZ4RuKKYT8tb/OfzMu0M1/DUSA1Xh7hjXB/5EMgtLhwHZJZ1C72/QCd1+jM=
Message-ID: <86802c440611261523q4bbd4fbbob5dd36db12dd9a01@mail.gmail.com>
Date: Sun, 26 Nov 2006 15:23:36 -0800
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Andrew Morton" <akpm@osdl.org>, "Andi Kleen" <ak@muc.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 2/3] x86: remove duplicated parser for "pci=noacpi"
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_60593_4390527.1164583416800"
X-Google-Sender-Auth: 7bf08df1e3fd7507
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_60593_4390527.1164583416800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



------=_Part_60593_4390527.1164583416800
Content-Type: text/x-patch; name="ai_2.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="ai_2.diff"
X-Attachment-Id: f_ev02vmrk

W1BBVENIIDIvM10geDg2OiByZW1vdmUgZHVwbGljYXRlZCBwYXJzZXIgZm9yICJwY2k9bm9hY3Bp
IiAKClJlbW92ZSAicGNpPW5vYWNwaSIgcGFyc2UgaW4gYWNwaS9ib290LmMsIGJlY2F1c2UgaXQg
aXMgZHVwbGljYXRlZCAKd2l0aCB0aGF0IGluIHBjaS9jb21tb24uYy4KClNpZ25lZC1vZmYtYnk6
IFlpbmdoYWkgTHUgPHlpbmdoYWkubHVAYW1kLmNvbT4KCmRpZmYgLS1naXQgYS9hcmNoL2kzODYv
a2VybmVsL2FjcGkvYm9vdC5jIGIvYXJjaC9pMzg2L2tlcm5lbC9hY3BpL2Jvb3QuYwppbmRleCBk
MTJmYjk3Li42ZDYyZGQxIDEwMDY0NAotLS0gYS9hcmNoL2kzODYva2VybmVsL2FjcGkvYm9vdC5j
CisrKyBiL2FyY2gvaTM4Ni9rZXJuZWwvYWNwaS9ib290LmMKQEAgLTEyODUsMTUgKzEyOTMsNiBA
QCBzdGF0aWMgaW50IF9faW5pdCBwYXJzZV9hY3BpKGNoYXIgKmFyZykKIH0KIGVhcmx5X3BhcmFt
KCJhY3BpIiwgcGFyc2VfYWNwaSk7CiAKLS8qIEZJWE1FOiBVc2luZyBwY2k9IGZvciBhbiBBQ1BJ
IHBhcmFtZXRlciBpcyBhIHRyYXZlc3R5LiAqLwotc3RhdGljIGludCBfX2luaXQgcGFyc2VfcGNp
KGNoYXIgKmFyZykKLXsKLQlpZiAoYXJnICYmIHN0cmNtcChhcmcsICJub2FjcGkiKSA9PSAwKQot
CQlhY3BpX2Rpc2FibGVfcGNpKCk7Ci0JcmV0dXJuIDA7Ci19Ci1lYXJseV9wYXJhbSgicGNpIiwg
cGFyc2VfcGNpKTsKLQogI2lmZGVmIENPTkZJR19YODZfSU9fQVBJQwogc3RhdGljIGludCBfX2lu
aXQgcGFyc2VfYWNwaV9za2lwX3RpbWVyX292ZXJyaWRlKGNoYXIgKmFyZykKIHsKZGlmZiAtLWdp
dCBhL2FyY2gvaTM4Ni9wY2kvY29tbW9uLmMgYi9hcmNoL2kzODYvcGNpL2NvbW1vbi5jCmluZGV4
IGNkZmNmOTcuLjZkNWI3MGEgMTAwNjQ0Ci0tLSBhL2FyY2gvaTM4Ni9wY2kvY29tbW9uLmMKKysr
IGIvYXJjaC9pMzg2L3BjaS9jb21tb24uYwpAQCAtMjk0LDcgKzI5NCw3IEBAIGNoYXIgKiBfX2Rl
dmluaXQgIHBjaWJpb3Nfc2V0dXAoY2hhciAqc3RyKQogCX0KICNlbmRpZgogCWVsc2UgaWYgKCFz
dHJjbXAoc3RyLCAibm9hY3BpIikpIHsKLQkJYWNwaV9ub2lycV9zZXQoKTsKKwkJYWNwaV9kaXNh
YmxlX3BjaSgpOwogCQlyZXR1cm4gTlVMTDsKIAl9CiAJZWxzZSBpZiAoIXN0cmNtcChzdHIsICJu
b2Vhcmx5IikpIHsK
------=_Part_60593_4390527.1164583416800--
