Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132567AbRAVQcV>; Mon, 22 Jan 2001 11:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132560AbRAVQcM>; Mon, 22 Jan 2001 11:32:12 -0500
Received: from chiara.elte.hu ([157.181.150.200]:12551 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S132490AbRAVQb7>;
	Mon, 22 Jan 2001 11:31:59 -0500
Date: Mon, 22 Jan 2001 17:31:15 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] wait4-2.4.0-A0
Message-ID: <Pine.LNX.4.30.0101221730020.4205-200000@elte.hu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="655616-1897787063-980181075=:4205"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--655616-1897787063-980181075=:4205
Content-Type: TEXT/PLAIN; charset=US-ASCII


the attached patch (against -pre9) fixes a possibly dangerous sys_wait4()
prototype mismatch.

	Ingo

--655616-1897787063-980181075=:4205
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="wait4-2.4.0-A0"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0101221731150.4205@elte.hu>
Content-Description: 
Content-Disposition: attachment; filename="wait4-2.4.0-A0"

LS0tIGxpbnV4L2luY2x1ZGUvbGludXgvc2NoZWQuaC5vcmlnCU1vbiBKYW4g
MjIgMTc6Mjg6MzYgMjAwMQ0KKysrIGxpbnV4L2luY2x1ZGUvbGludXgvc2No
ZWQuaAlNb24gSmFuIDIyIDE3OjI5OjE3IDIwMDENCkBAIC01NjMsNiArNTYz
LDcgQEANCiAjZGVmaW5lIHdha2VfdXBfaW50ZXJydXB0aWJsZV9hbGwoeCkJ
X193YWtlX3VwKCh4KSxUQVNLX0lOVEVSUlVQVElCTEUsIDApDQogI2RlZmlu
ZSB3YWtlX3VwX2ludGVycnVwdGlibGVfc3luYyh4KQlfX3dha2VfdXBfc3lu
YygoeCksVEFTS19JTlRFUlJVUFRJQkxFLCAxKQ0KICNkZWZpbmUgd2FrZV91
cF9pbnRlcnJ1cHRpYmxlX3N5bmNfbnIoeCkgX193YWtlX3VwX3N5bmMoKHgp
LFRBU0tfSU5URVJSVVBUSUJMRSwgIG5yKQ0KK2FzbWxpbmthZ2UgbG9uZyBz
eXNfd2FpdDQocGlkX3QgcGlkLHVuc2lnbmVkIGludCAqIHN0YXRfYWRkciwg
aW50IG9wdGlvbnMsIHN0cnVjdCBydXNhZ2UgKiBydSk7DQogDQogZXh0ZXJu
IGludCBpbl9ncm91cF9wKGdpZF90KTsNCiBleHRlcm4gaW50IGluX2Vncm91
cF9wKGdpZF90KTsNCi0tLSBsaW51eC9hcmNoL2kzODYva2VybmVsL3NpZ25h
bC5jLm9yaWcJTW9uIEphbiAyMiAxNzoyODoyNSAyMDAxDQorKysgbGludXgv
YXJjaC9pMzg2L2tlcm5lbC9zaWduYWwuYwlNb24gSmFuIDIyIDE3OjI4OjMx
IDIwMDENCkBAIC0yNiw4ICsyNiw2IEBADQogDQogI2RlZmluZSBfQkxPQ0tB
QkxFICh+KHNpZ21hc2soU0lHS0lMTCkgfCBzaWdtYXNrKFNJR1NUT1ApKSkN
CiANCi1hc21saW5rYWdlIGludCBzeXNfd2FpdDQocGlkX3QgcGlkLCB1bnNp
Z25lZCBsb25nICpzdGF0X2FkZHIsDQotCQkJIGludCBvcHRpb25zLCB1bnNp
Z25lZCBsb25nICpydSk7DQogYXNtbGlua2FnZSBpbnQgRkFTVENBTEwoZG9f
c2lnbmFsKHN0cnVjdCBwdF9yZWdzICpyZWdzLCBzaWdzZXRfdCAqb2xkc2V0
KSk7DQogDQogaW50IGNvcHlfc2lnaW5mb190b191c2VyKHNpZ2luZm9fdCAq
dG8sIHNpZ2luZm9fdCAqZnJvbSkNCg==
--655616-1897787063-980181075=:4205--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
