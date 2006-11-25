Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935132AbWKYBhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935132AbWKYBhE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 20:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935133AbWKYBhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 20:37:04 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:60582 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S935132AbWKYBhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 20:37:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:mime-version:content-type:x-google-sender-auth;
        b=Pl27n9t1FSWq6s7ksDJxNHFOFhd60kL9RH8Xf2WOIWlY+cKYXyxQnTSiIz988CPe9DZNcNlxJw3LhTqrvmaOyt7UV1MHM0o9Vj0pUYnv5VpjMT7aj4eHqQBzHAus91L6g4BBDO3OIj2D4ZtpM99G16fGyXU10fja4q1DrFZqslk=
Message-ID: <86802c440611241736l545ddf33i3bb08f3cd6446b14@mail.gmail.com>
Date: Fri, 24 Nov 2006 17:36:59 -0800
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Andrew Morton" <akpm@osdl.org>, "Andi Kleen" <ak@muc.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 2/2] x86-64: change the size for interrupt array to NR_VECTORS
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_42375_8168133.1164418619854"
X-Google-Sender-Auth: fd0a061026670b24
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_42375_8168133.1164418619854
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Please check the patch.

------=_Part_42375_8168133.1164418619854
Content-Type: text/x-patch; name=i8259.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_euxcl20n
Content-Disposition: attachment; filename="i8259.patch"

W1BBVENIXSB4ODZfNjQ6IGludGVycnVwdCBhcnJheSBzaXplIHNob3VsZCBiZSBhbGlnbmVkIHRv
IE5SX1ZFQ1RPUlMKaW50ZXJydXB0IGFycmF5IGlzIHJlZmVycmVkIGZvciBpZHQgdmVjdG9ycyBp
bnN0ZWFkIG9mIE5SX0lSUVMsIHNvIGNoYW5nZSBzaXplCnRvIE5SX1ZFQ1RPUlMgLSBGSVJTVF9F
WFRFUk5BTF9WRUNUT1IuIEFsc28gY2hhbmdlIHRvIHN0YXRpYy4KClNpZ25lZC1vZmYtYnk6IFlp
bmdoYWkgTHUgPHlpbmdoYWlAYW1kLmNvbT4KCmRpZmYgLS1naXQgYS9hcmNoL3g4Nl82NC9rZXJu
ZWwvaTgyNTkuYyBiL2FyY2gveDg2XzY0L2tlcm5lbC9pODI1OS5jCmluZGV4IGM0ZWY4MDEuLmQ3
M2M3OWUgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2XzY0L2tlcm5lbC9pODI1OS5jCisrKyBiL2FyY2gv
eDg2XzY0L2tlcm5lbC9pODI1OS5jCkBAIC03Niw3ICs3Niw4IEBAICNkZWZpbmUgSVJRTElTVF8x
Nih4KSBcCiAJSVJRKHgsOCksIElSUSh4LDkpLCBJUlEoeCxhKSwgSVJRKHgsYiksIFwKIAlJUlEo
eCxjKSwgSVJRKHgsZCksIElSUSh4LGUpLCBJUlEoeCxmKQogCi12b2lkICgqaW50ZXJydXB0W05S
X0lSUVNdKSh2b2lkKSA9IHsKKy8qIGZvciB0aGUgaXJxIHZlY3RvcnMgKi8KK3N0YXRpYyB2b2lk
ICgqaW50ZXJydXB0W05SX1ZFQ1RPUlMgLSBGSVJTVF9FWFRFUk5BTF9WRUNUT1JdKSh2b2lkKSA9
IHsKIAkJCQkJICBJUlFMSVNUXzE2KDB4MiksIElSUUxJU1RfMTYoMHgzKSwKIAlJUlFMSVNUXzE2
KDB4NCksIElSUUxJU1RfMTYoMHg1KSwgSVJRTElTVF8xNigweDYpLCBJUlFMSVNUXzE2KDB4Nyks
CiAJSVJRTElTVF8xNigweDgpLCBJUlFMSVNUXzE2KDB4OSksIElSUUxJU1RfMTYoMHhhKSwgSVJR
TElTVF8xNigweGIpLAo=
------=_Part_42375_8168133.1164418619854--
