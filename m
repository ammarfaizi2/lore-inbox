Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261973AbVDVFHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbVDVFHH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 01:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbVDVFHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 01:07:04 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:52102 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261973AbVDVFEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 01:04:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type;
        b=FBNgs7O+j2yl1cMSnMsd+n5oqlMRJzClpnCzd8ZnynYGVRZQjM803FTk1w9KTGUMfwu2UtpKPPDof59RqXv/JXWJt/jdtTBlxDJKwnoEb6oUytEShoKJFlUmgBHYoSqBktxvs+GRxCyCVxMoevXagxMjY79qcFvu4rV1S/v/aPM=
Message-ID: <9cde8bff05042122044872d7de@mail.gmail.com>
Date: Fri, 22 Apr 2005 14:04:07 +0900
From: aq <aquynh@gmail.com>
Reply-To: aq <aquynh@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] dontdiff file sorted in alphabet order
Cc: rddunlap@osdl.org, greg@kroah.com, lkml <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1383_20444544.1114146247984"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_1383_20444544.1114146247984
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hello,

The Documentation/dontdiffI file of 2.6.12-rc3 kernel is a little
messy. Here is a patch to sort the content of that file in alphabet
order. Please apply.

# diffstat  dontdiff.patch=20
 dontdiff |  136 +++++++++++++++++++++++++++++++---------------------------=
-----
 1 files changed, 68 insertions(+), 68 deletions(-)

Signed-off-by: Nguyen Anh Quynh <aquynh@gmail.com>

------=_Part_1383_20444544.1114146247984
Content-Type: application/octet-stream; name="dontdiff.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dontdiff.patch"

LS0tIERvY3VtZW50YXRpb24vZG9udGRpZmYJMjAwNS0wNC0yMiAxNDowMDo1Mi4wMDAwMDAwMDAg
KzA5MDAKKysrIERvY3VtZW50YXRpb24vZG9udGRpZmYuYXEJMjAwNS0wNC0yMiAxMzo0ODo0Mi4w
MDAwMDAwMDAgKzA5MDAKQEAgLTEsMTM3ICsxLDEzNyBAQAotLioKKyouYQorKi5hdXgKKyouYmlu
CisqLmNwaW8KKyouY3NzCisqLmR2aQorKi5lcHMKKyouZ2lmCisqLmdyZXAKKyouZ3JwCisqLmd6
CisqLmh0bWwKKyouanBlZworKi5rbworKi5sb2cKKyoubHN0CisqLm1vZC5jCisqLm8KKyoub3Jp
ZworKi5vdXQKKyoucGRmCisqLnBuZworKi5wcworKi5yZWoKKyoucworKi5zZ21sCisqLnNvCisq
LnRleAorKi52ZXIKKypfTU9EVUxFUworKl92Z2ExNi5jCisqY3Njb3BlKgogKn4KKy4qCisuY3Nj
b3BlCis1M2M3MDBfZC5oCiA1M2M4eHhfZC5oKgotKi5hCitCaXRLZWVwZXIKK0NPUFlJTkcKK0NS
RURJVFMKK0NWUworQ2hhbmdlU2V0CitLZXJudHlwZXMKK01PRFMudHh0CitNb2R1bGUuc3ltdmVy
cworUEVORElORworU0NDUworU3lzdGVtLm1hcCoKK1RBR1MKIGFpYzcqcmVnLmgqCi1haWM3KnNl
cS5oKgogYWljNypyZWdfcHJpbnQuYyoKLTUzYzcwMF9kLmgKK2FpYzcqc2VxLmgqCiBhaWNhc20K
IGFpY2RiLmgqCiBhc20KIGFzbV9vZmZzZXRzLioKIGF1dG9jb25mLmgqCi0qLmF1eAogYmJvb3Rz
ZWN0Ci0qLmJpbgogYmluMmMKIGJpbmtlcm5lbC5zcGVjCi1CaXRLZWVwZXIKIGJvb3RzZWN0CiBi
c2V0dXAKIGJ0Zml4dXBwcmVwCiBidWlsZAogYnZtbGludXgKIGJ6SW1hZ2UqCi1DaGFuZ2VTZXQK
IGNsYXNzbGlzdC5oKgotY29tcGlsZS5oKgogY29tcCoubG9nCitjb21waWxlLmgqCiBjb25maWcK
IGNvbmZpZy0qCiBjb25maWdfZGF0YS5oKgogY29ubWFrZWhhc2gKIGNvbnNvbGVtYXBfZGVmdGJs
LmMqCi1DT1BZSU5HCi1DUkVESVRTCi0uY3Njb3BlCi0qY3Njb3BlKgorY3JjMzJ0YWJsZS5oKgog
Y3Njb3BlLioKLSoub3V0Ci0qLmNzcwotQ1ZTCiBkZWZrZXltYXAuYyoKIGRldmxpc3QuaCoKIGRv
Y3Byb2MKIGR1bW15X3N5bS5jKgotKi5kdmkKLSouZXBzCitlbGZjb25maWcuaCoKIGZpbGVsaXN0
CiBmaXhkZXAKIGZvcmUyMDBlX21rZmlybQogZm9yZTIwMGVfcGNhX2Z3LmMqCiBnZW4tZGV2bGlz
dAotZ2VuX2luaXRfY3BpbwotZ2VuX2NyYzMydGFibGUKLWNyYzMydGFibGUuaCoKLSouY3Bpbwog
Z2VuLWtkYl9jbWRzLmMqCi1nZW50YmwKK2dlbl9jcmMzMnRhYmxlCitnZW5faW5pdF9jcGlvCiBn
ZW5rc3ltcwotKi5naWYKLSouZ3oKLSouaHRtbAorZ2VudGJsCiBpa2NvbmZpZy5oKgogaW5pdHJh
bWZzX2xpc3QKLSouanBlZwora2FsbHN5bXMKIGtjb25maWcKIGtjb25maWcudGsKLUtlcm50eXBl
cwoga2V5d29yZHMuYyoKIGtzeW0uYyoKIGtzeW0uaCoKLWthbGxzeW1zCi1ta19lbGZjb25maWcK
LWVsZmNvbmZpZy5oKgotbW9kcG9zdAotcG5tdG9sb2dvCi1sb2dvXyouYwotKi5sb2cKIGxleC5j
KgorbG9nb18qLmMKIGxvZ29fKl9jbHV0MjI0LmMKIGxvZ29fKl9tb25vLmMKIGx4ZGlhbG9nCiBt
YWtlX3RpbWVzX2gKIG1hcAorbWF1aV9ib290LmgKK21rX2VsZmNvbmZpZwogbWtkZXAKLSpfTU9E
VUxFUwotTU9EUy50eHQKK21rdGFibGVzCittb2Rwb3N0CiBtb2R2ZXJzaW9ucy5oKgotTW9kdWxl
LnN5bXZlcnMKLSoubW9kLmMKLSoubwotKi5rbwotKi5vcmlnCi0qLmxzdAotKi5ncnAKLSouZ3Jl
cAogb3VpLmMqCi1ta3RhYmxlcwotcmFpZDZ0YWJsZXMuYwotcmFpZDZpbnQqLmMKLXJhaWQ2YWx0
aXZlYyouYwotd2FueGxmdy5pbmMKLW1hdWlfYm9vdC5oCi1wc3NfYm9vdC5oCi10cml4X2Jvb3Qu
aAotKi5wZGYKIHBhcnNlLmMqCiBwYXJzZS5oKgotUEVORElORworcG5tdG9sb2dvCiBwcGNfZGVm
cy5oKgogcHJvbWNvbl90YmwuYyoKLSoucG5nCi0qLnBzCi0qLnJlagotU0NDUworcHNzX2Jvb3Qu
aAorcmFpZDZhbHRpdmVjKi5jCityYWlkNmludCouYworcmFpZDZ0YWJsZXMuYwogc2V0dXAKLSou
cwotKi5zbwotKi5zZ21sCiBzaW03MTBfZC5oKgogc21fdGJsKgogc3BsaXQtaW5jbHVkZQotU3lz
dGVtLm1hcCoKIHRhZ3MKLVRBR1MKLSoudGV4CiB0aW1lcy5oKgogdGtwYXJzZQotKi52ZXIKK3Ry
aXhfYm9vdC5oCiB2ZXJzaW9uLmgqCi0qX3ZnYTE2LmMKIHZtbGludXgKLXZtbGludXgubGRzCiB2
bWxpbnV4LSoKK3ZtbGludXgubGRzCiB2c3lzY2FsbC5sZHMKK3dhbnhsZncuaW5jCiB6SW1hZ2UK

------=_Part_1383_20444544.1114146247984--
