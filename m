Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935121AbWKYBaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935121AbWKYBaV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 20:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935122AbWKYBaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 20:30:21 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:65425 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S935121AbWKYBaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 20:30:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:mime-version:content-type:x-google-sender-auth;
        b=Fj9WvAf1uezHmauaxlSRS6kdMom7z3PtkWgswd8xq/xGAyhsMMN+QYRVPlp9p1kYcVIpBe/8cMs22EAFU4nOmSp6Awq+Q3FU8D3Bhkj1tsrFVhsT/WN47MD9TALGjGzg1uG4ywIbPxM8SijbLym/ykB6qVo1SgAYw+/XviEcHYs=
Message-ID: <86802c440611241730l55e81294u21944b528d95c15d@mail.gmail.com>
Date: Fri, 24 Nov 2006 17:30:18 -0800
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Andrew Morton" <akpm@osdl.org>, "Andi Kleen" <ak@muc.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 1/2] x86-64: calling clear_bss before set_intr_gate with early_idt_handler
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_42323_6339789.1164418218189"
X-Google-Sender-Auth: 083ddd6c1c06576e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_42323_6339789.1164418218189
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Please check the patch.

------=_Part_42323_6339789.1164418218189
Content-Type: text/x-patch; name=head64.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_euxchrl5
Content-Disposition: attachment; filename="head64.patch"

W1BBVENIXSB4ODZfNjQ6IGNsZWFyX2JzcyBiZWZvcmUgc2V0X2ludHJfZ2F0ZSB3aXRoIGVhcmx5
X2lkdF9oYW5kbGVyCmlkdF90YWJsZSBpcyBpbiB0aGUgLmJzcyBzZWN0aW9uLCBzbyBjbGVhcl9i
c3MgbmVlZCB0byBjYWxsZWQgYXQgZmlyc3QKClNpZ25lZC1vZmYtYnk6IFlpbmdoYWkgTHUgPHlp
bmdoYWkubHVAYW1kLmNvbT4gCgpkaWZmIC0tZ2l0IGEvYXJjaC94ODZfNjQva2VybmVsL2hlYWQ2
NC5jIGIvYXJjaC94ODZfNjQva2VybmVsL2hlYWQ2NC5jCmluZGV4IDk1NjFlYjMuLmNjMjMwYjkg
MTAwNjQ0Ci0tLSBhL2FyY2gveDg2XzY0L2tlcm5lbC9oZWFkNjQuYworKysgYi9hcmNoL3g4Nl82
NC9rZXJuZWwvaGVhZDY0LmMKQEAgLTU3LDEwICs1NywxMiBAQCB2b2lkIF9faW5pdCB4ODZfNjRf
c3RhcnRfa2VybmVsKGNoYXIgKiByCiB7CiAJaW50IGk7CiAKLQlmb3IgKGkgPSAwOyBpIDwgMjU2
OyBpKyspCisJLyogY2xlYXIgYnNzIGJlZm9yZSBzZXRfaW50cl9nYXRlIHdpdGggZWFybHlfaWR0
X2hhbmRsZXIgKi8KKwljbGVhcl9ic3MoKTsKKworCWZvciAoaSA9IDA7IGkgPCBJRFRfRU5UUklF
UzsgaSsrKQogCQlzZXRfaW50cl9nYXRlKGksIGVhcmx5X2lkdF9oYW5kbGVyKTsKIAlhc20gdm9s
YXRpbGUoImxpZHQgJTAiIDo6ICJtIiAoaWR0X2Rlc2NyKSk7Ci0JY2xlYXJfYnNzKCk7CiAKIAll
YXJseV9wcmludGsoIktlcm5lbCBhbGl2ZVxuIik7CiAK
------=_Part_42323_6339789.1164418218189--
