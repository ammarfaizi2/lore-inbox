Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279601AbRJXVMq>; Wed, 24 Oct 2001 17:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279602AbRJXVM0>; Wed, 24 Oct 2001 17:12:26 -0400
Received: from ns1.uklinux.net ([212.1.130.11]:27405 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S279601AbRJXVMT>;
	Wed, 24 Oct 2001 17:12:19 -0400
Envelope-To: <linux-kernel@vger.kernel.org>
Date: Wed, 24 Oct 2001 22:11:10 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: linux-kernel@vger.kernel.org
Subject: Depmod errors with fs modules, 2.4.12-ac3
Message-ID: <Pine.LNX.4.21.0110242208500.783-200000@pppg_penguin.linux.bogus>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811840-1985462054-1003957870=:783"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811840-1985462054-1003957870=:783
Content-Type: TEXT/PLAIN; charset=US-ASCII

I got the attached errors (in lockd.o, nfs.o, nfsd.o) tonight. Kernel is
2.4.12-ac3 with the preemptive patch.

Ken
-- 
         If a six turned out to be nine, I don't mind.

         Home page : http://www.kenmoffat.uklinux.net

---1463811840-1985462054-1003957870=:783
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="depmod.errors"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0110242211100.783@pppg_penguin.linux.bogus>
Content-Description: 
Content-Disposition: attachment; filename="depmod.errors"

ZGVwbW9kOiAqKiogVW5yZXNvbHZlZCBzeW1ib2xzIGluIC9saWIvbW9kdWxl
cy8yLjQuMTItYWMzLXByZWVtcHQva2VybmVsL2ZzL2xvY2tkL2xvY2tkLm8N
CmRlcG1vZDogCXJwY2lvZF91cA0KZGVwbW9kOiAJcnBjaW9kX2Rvd24NCmRl
cG1vZDogCXhkcl9kZWNvZGVfc3RyaW5nX2lucGxhY2UNCmRlcG1vZDogCXhk
cl9lbmNvZGVfc3RyaW5nDQpkZXBtb2Q6IAlycGNfcmVzdGFydF9jYWxsDQpk
ZXBtb2Q6IAlzdmNfZXhpdF90aHJlYWQNCmRlcG1vZDogCW5sbV9kZWJ1Zw0K
ZGVwbW9kOiAJc3ZjX3dha2VfdXANCmRlcG1vZDogCXN2Y19tYWtlc29jaw0K
ZGVwbW9kOiAJc3ZjX2Rlc3Ryb3kNCmRlcG1vZDogCXJwY19jcmVhdGVfY2xp
ZW50DQpkZXBtb2Q6IAlzdmNfY3JlYXRlX3RocmVhZA0KZGVwbW9kOiAJcnBj
X2NhbGxfYXN5bmMNCmRlcG1vZDogCXhkcl9lbmNvZGVfbmV0b2JqDQpkZXBt
b2Q6IAlzdmNfcmVjdg0KZGVwbW9kOiAJc3ZjX3Byb2Nlc3MNCmRlcG1vZDog
CXJwY19kZWxheQ0KZGVwbW9kOiAJcnBjX2Rlc3Ryb3lfY2xpZW50DQpkZXBt
b2Q6IAl4ZHJfZGVjb2RlX25ldG9iag0KZGVwbW9kOiAJc3ZjX2NyZWF0ZQ0K
ZGVwbW9kOiAJcnBjX2NhbGxfc3luYw0KZGVwbW9kOiAJeHBydF9zZXRfdGlt
ZW91dA0KZGVwbW9kOiAJeHBydF9kZXN0cm95DQpkZXBtb2Q6IAl4cHJ0X2Ny
ZWF0ZV9wcm90bw0KZGVwbW9kOiAqKiogVW5yZXNvbHZlZCBzeW1ib2xzIGlu
IC9saWIvbW9kdWxlcy8yLjQuMTItYWMzLXByZWVtcHQva2VybmVsL2ZzL25m
cy9uZnMubw0KZGVwbW9kOiAJcnBjX3dha2VfdXBfdGFzaw0KZGVwbW9kOiAJ
eGRyX3NoaWZ0X2lvdmVjDQpkZXBtb2Q6IAlycGNfa2lsbGFsbF90YXNrcw0K
ZGVwbW9kOiAJcnBjX2luaXRfdGFzaw0KZGVwbW9kOiAJcnBjX3NodXRkb3du
X2NsaWVudA0KZGVwbW9kOiAJcnBjaW9kX3VwDQpkZXBtb2Q6IAlycGNfbmV3
X3Rhc2sNCmRlcG1vZDogCXJwY2lvZF9kb3duDQpkZXBtb2Q6IAlycGNfd2Fr
ZV91cF9zdGF0dXMNCmRlcG1vZDogCXJwY19jbG50X3NpZ21hc2sNCmRlcG1v
ZDogCXJwY19wcm9jX3VucmVnaXN0ZXINCmRlcG1vZDogCXJwY19yZWxlYXNl
X3Rhc2sNCmRlcG1vZDogCXhkcl9lbmNvZGVfYXJyYXkNCmRlcG1vZDogCW5m
c19kZWJ1Zw0KZGVwbW9kOiAJcnBjX2NyZWF0ZV9jbGllbnQNCmRlcG1vZDog
CXJwY19zbGVlcF9vbg0KZGVwbW9kOiAJcnBjYXV0aF9sb29rdXBjcmVkDQpk
ZXBtb2Q6IAlycGNfY2xudF9zaWd1bm1hc2sNCmRlcG1vZDogCXJwY19jYWxs
X3NldHVwDQpkZXBtb2Q6IAlycGNfY2FsbF9zeW5jDQpkZXBtb2Q6IAlwdXRf
cnBjY3JlZA0KZGVwbW9kOiAJeHBydF9kZXN0cm95DQpkZXBtb2Q6IAlycGNf
ZXhlY3V0ZQ0KZGVwbW9kOiAJcnBjX3Byb2NfcmVnaXN0ZXINCmRlcG1vZDog
CXhkcl96ZXJvX2lvdmVjDQpkZXBtb2Q6IAl4cHJ0X2NyZWF0ZV9wcm90bw0K
ZGVwbW9kOiAqKiogVW5yZXNvbHZlZCBzeW1ib2xzIGluIC9saWIvbW9kdWxl
cy8yLjQuMTItYWMzLXByZWVtcHQva2VybmVsL2ZzL25mc2QvbmZzZC5vDQpk
ZXBtb2Q6IAl4ZHJfZGVjb2RlX3N0cmluZ19pbnBsYWNlDQpkZXBtb2Q6IAl4
ZHJfZGVjb2RlX3N0cmluZw0KZGVwbW9kOiAJc3ZjX2V4aXRfdGhyZWFkDQpk
ZXBtb2Q6IAlzdmNfcHJvY191bnJlZ2lzdGVyDQpkZXBtb2Q6IAl4ZHJfZW5j
b2RlX2FycmF5DQpkZXBtb2Q6IAlzdmNfbWFrZXNvY2sNCmRlcG1vZDogCXN2
Y19kZXN0cm95DQpkZXBtb2Q6IAlzdmNfY3JlYXRlX3RocmVhZA0KZGVwbW9k
OiAJc3ZjX3JlY3YNCmRlcG1vZDogCXN2Y19wcm9jZXNzDQpkZXBtb2Q6IAlz
dmNfY3JlYXRlDQpkZXBtb2Q6IAluZnNkX2RlYnVnDQpkZXBtb2Q6IAlzdmNf
cHJvY19yZWdpc3Rlcg0KZGVwbW9kOiAJc3ZjX3Byb2NfcmVhZA0K
---1463811840-1985462054-1003957870=:783--
