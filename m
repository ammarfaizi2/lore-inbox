Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275573AbRJJMQb>; Wed, 10 Oct 2001 08:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275576AbRJJMQV>; Wed, 10 Oct 2001 08:16:21 -0400
Received: from web20503.mail.yahoo.com ([216.136.226.138]:20229 "HELO
	web20503.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S275573AbRJJMQL>; Wed, 10 Oct 2001 08:16:11 -0400
Message-ID: <20011010121642.50220.qmail@web20503.mail.yahoo.com>
Date: Wed, 10 Oct 2001 14:16:42 +0200 (CEST)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: [PATCH] two printk fixes for 2.4.10-ac10
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1440549930-1002716202=:48572"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1440549930-1002716202=:48572
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

Hi there !

here are two small fixes for erroneous printk() in
ide-tape and i2o_proc in 2.4.10-ac10. Very likely to
find the same probs in 2.4.11 (didn't verify though).

Alan, please apply.

Cheers,
Willy


___________________________________________________________
Un nouveau Nokia Game commence. 
Allez sur http://fr.yahoo.com/nokiagame avant le 3 novembre
pour participer à cette aventure tous médias.
--0-1440549930-1002716202=:48572
Content-Type: application/x-unknown; name="patch-2.4-i2o_proc-fix"
Content-Transfer-Encoding: base64
Content-Description: patch-2.4-i2o_proc-fix
Content-Disposition: attachment; filename="patch-2.4-i2o_proc-fix"

LS0tIGxpbnV4L2RyaXZlcnMvbWVzc2FnZS9pMm8vaTJvX3Byb2MuYwlXZWQg
T2N0IDEwIDEzOjM5OjM5IDIwMDEKKysrIGxpbnV4L2RyaXZlcnMvbWVzc2Fn
ZS9pMm8vaTJvX3Byb2MuYwlXZWQgT2N0IDEwIDEzOjQxOjA1IDIwMDEKQEAg
LTMyOTcsNyArMzI5Nyw3IEBACiB2b2lkIGkyb19wcm9jX2Rldl9kZWwoc3Ry
dWN0IGkyb19jb250cm9sbGVyICpjLCBzdHJ1Y3QgaTJvX2RldmljZSAqZCkK
IHsKICNpZmRlZiBEUklWRVJERUJVRwotCXByaW50ayhLRVJOX0lORk8sICJE
ZWxldGluZyBkZXZpY2UgJWQgZnJvbSBpb3AlZFxuIiwgCisJcHJpbnRrKEtF
Uk5fSU5GTyAiRGVsZXRpbmcgZGV2aWNlICVkIGZyb20gaW9wJWRcbiIsIAog
CQlkLT5sY3RfZGF0YS50aWQsIGMtPnVuaXQpOwogI2VuZGlmCiAK

--0-1440549930-1002716202=:48572
Content-Type: application/x-unknown; name="patch-2.4-ide-tape-fix"
Content-Transfer-Encoding: base64
Content-Description: patch-2.4-ide-tape-fix
Content-Disposition: attachment; filename="patch-2.4-ide-tape-fix"

LS0tIGxpbnV4L2RyaXZlcnMvaWRlL2lkZS10YXBlLmMJV2VkIE9jdCAxMCAx
MzozODoxNyAyMDAxCisrKyBsaW51eC9kcml2ZXJzL2lkZS9pZGUtdGFwZS5j
CVdlZCBPY3QgMTAgMTM6NDA6MDYgMjAwMQpAQCAtNDc4NCw3ICs0Nzg0LDcg
QEAKIAkJICovCiAJCWlmICh0YXBlLT5maXJzdF9mcmFtZV9wb3NpdGlvbiAr
IHRhcGUtPm5yX3N0YWdlcyA+PSB0YXBlLT5jYXBhY2l0eSAtIE9TX0VXKSAg
ewogI2lmIE9OU1RSRUFNX0RFQlVHCi0JCQlwcmludGsoS0VSTl9JTkZPLCAi
Y2hyZGV2X3dyaXRlOiBXcml0ZSB0cnVuY2F0ZWQgYXQgRU9NIGVhcmx5IHdh
cm5pbmciKTsKKwkJCXByaW50ayhLRVJOX0lORk8gImNocmRldl93cml0ZTog
V3JpdGUgdHJ1bmNhdGVkIGF0IEVPTSBlYXJseSB3YXJuaW5nIik7CiAjZW5k
aWYKIAkJCWlmICh0YXBlLT5jaHJkZXZfZGlyZWN0aW9uID09IGlkZXRhcGVf
ZGlyZWN0aW9uX3dyaXRlKQogCQkJCWlkZXRhcGVfd3JpdGVfcmVsZWFzZShp
bm9kZSk7Cg==

--0-1440549930-1002716202=:48572--
