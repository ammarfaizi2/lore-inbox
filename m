Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129523AbRAIB4k>; Mon, 8 Jan 2001 20:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130196AbRAIB4a>; Mon, 8 Jan 2001 20:56:30 -0500
Received: from cm-net-C8B026A1.poa.terra.com.br ([200.176.38.161]:52235 "EHLO
	dump") by vger.kernel.org with ESMTP id <S129523AbRAIB4X>;
	Mon, 8 Jan 2001 20:56:23 -0500
Date: Mon, 8 Jan 2001 23:49:48 +0000 (/etc/localtime)
From: aris@cathedrallabs.org
Reply-To: aris@cathedrallabs.org
To: linux-kernel@vger.kernel.org
cc: torvalds@transmeta.com
Subject: [PATCH][2.4] eepro 0.12c
Message-ID: <Pine.LNX.4.21.0101082332220.195-200000@matthew.cathedral.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="852975170-1435406135-978996779=:195"
Content-ID: <Pine.LNX.4.21.0101082333591.195@matthew.cathedral.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--852975170-1435406135-978996779=:195
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.21.0101082333592.195@matthew.cathedral.com>

hi linus,
	driver: eepro
	problem: the actual state of driver makes old supported board stop
	         to function after some time of operation.

	please consider applying this patch. the cleanup and cosmetic
changes will be in the next release of driver as you asked for.

-----------------------------------------------------------
aristeu sergio rozanski filho | www.cathedrallabs.org/~aris
aris@cathedrallabs.org        | aris@conectiva.com.br     
-----------------------------------------------------------


--852975170-1435406135-978996779=:195
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="eepro-2.4-0.12c.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0101082332590.195@matthew.cathedral.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="eepro-2.4-0.12c.patch"

LS0tIGxpbnV4L2RyaXZlcnMvbmV0L2VlcHJvLmMub2xkCVR1ZSBEZWMgIDUg
MjA6Mjk6MzggMjAwMA0KKysrIGxpbnV4L2RyaXZlcnMvbmV0L2VlcHJvLmMJ
CU1vbiBKYW4gIDggMjI6NTY6NDQgMjAwMQ0KQEAgLTIzLDYgKzIzLDcgQEAN
CiAJVGhpcyBpcyBhIGNvbXBhdGliaWxpdHkgaGFyZHdhcmUgcHJvYmxlbS4N
CiANCiAJVmVyc2lvbnM6DQorCTAuMTJjCWZpeGluZyBzb21lIHByb2JsZW1z
IHdpdGggb2xkIGNhcmRzIChhcmlzLCAwMS8wOC8yMDAxKQ0KIAkwLjEyYglt
aXNjIGZpeGVzIChhcmlzLCAwNi8yNi8yMDAwKQ0KIAkwLjEyYSAgIHBvcnQg
b2YgdmVyc2lvbiAwLjEyYSBvZiAyLjIueCBrZXJuZWxzIHRvIDIuMy54DQog
CQkoYXJpcyAoYXJpc0Bjb25lY3RpdmEuY29tLmJyKSwgMDUvMTkvMjAwMCkN
CkBAIC05Niw3ICs5Nyw3IEBADQogKi8NCiANCiBzdGF0aWMgY29uc3QgY2hh
ciAqdmVyc2lvbiA9DQotCSJlZXByby5jOiB2MC4xMmIgMDQvMjYvMjAwMCBh
cmlzQGNvbmVjdGl2YS5jb20uYnJcbiI7DQorCSJlZXByby5jOiB2MC4xMmMg
MDEvMDgvMjAwMCBhcmlzQGNvbmVjdGl2YS5jb20uYnJcbiI7DQogDQogI2lu
Y2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KIA0KQEAgLTUwMSw4ICs1MDIsMTAg
QEANCiAvKiBzZXQgZGlhZ25vc2UgZmxhZyAqLw0KICNkZWZpbmUgZWVwcm9f
ZGlhZyhpb2FkZHIpIG91dGIoRElBR05PU0VfQ01ELCBpb2FkZHIpDQogDQor
I2lmZGVmIEFOU1dFUl9UWF9BTkRfUlgJCS8qIGV4cGVyaW1lbnRhbCB3YXkg
b2YgaGFuZGxpbmcgaW50ZXJydXB0cyAqLw0KIC8qIGFjayBmb3IgcngvdHgg
aW50ICovDQogI2RlZmluZSBlZXByb19hY2tfcnh0eChpb2FkZHIpIG91dGIg
KFJYX0lOVCB8IFRYX0lOVCwgaW9hZGRyICsgU1RBVFVTX1JFRykNCisjZW5k
aWYNCiANCiAvKiBhY2sgZm9yIHJ4IGludCAqLw0KICNkZWZpbmUgZWVwcm9f
YWNrX3J4KGlvYWRkcikgb3V0YiAoUlhfSU5ULCBpb2FkZHIgKyBTVEFUVVNf
UkVHKQ0KQEAgLTEwNjcsNiArMTA3MCw4IEBADQogCX0NCiAJDQogCWVlcHJv
X3NlbF9yZXNldChpb2FkZHIpOw0KKwlTTE9XX0RPV047DQorCVNMT1dfRE9X
TjsNCiANCiAJbHAtPnR4X3N0YXJ0ID0gbHAtPnR4X2VuZCA9IFhNVF9MT1dF
Ul9MSU1JVCA8PCA4Ow0KIAlscC0+dHhfbGFzdCA9IDA7DQpAQCAtMTE2Miw5
ICsxMTY3LDExIEBADQogCXdoaWxlICgoKHN0YXR1cyA9IGluYihpb2FkZHIg
KyBTVEFUVVNfUkVHKSkgJiAweDA2KSAmJiAoYm9ndXNjb3VudC0tKSkNCiAJ
ew0KIAkJc3dpdGNoIChzdGF0dXMgJiAoUlhfSU5UIHwgVFhfSU5UKSkgew0K
KyNpZmRlZiBBTlNXRVJfVFhfQU5EX1JYDQogCQkJY2FzZSAoUlhfSU5UIHwg
VFhfSU5UKToNCiAJCQkJZWVwcm9fYWNrX3J4dHgoaW9hZGRyKTsNCiAJCQkJ
YnJlYWs7DQorI2VuZGlmDQogCQkJY2FzZSBSWF9JTlQ6DQogCQkJCWVlcHJv
X2Fja19yeChpb2FkZHIpOw0KIAkJCQlicmVhazsNCkBAIC0xMTc4LDYgKzEx
ODUsOSBAQA0KIA0KIAkJCS8qIEdldCB0aGUgcmVjZWl2ZWQgcGFja2V0cyAq
Lw0KIAkJCWVlcHJvX3J4KGRldik7DQorI2lmbmRlZiBBTlNXRVJfVFhfQU5E
X1JYDQorCQkJY29udGludWU7DQorI2VuZGlmDQogCQl9DQogCQlpZiAoc3Rh
dHVzICYgVFhfSU5UKSB7DQogCQkJaWYgKG5ldF9kZWJ1ZyA+IDQpDQpAQCAt
MTM2Nyw3ICsxMzc3LDExIEBADQogCQkvKiBSZS1lbmFibGUgUlggYW5kIFRY
IGludGVycnVwdHMgKi8NCiAJCWVlcHJvX2VuX2ludChpb2FkZHIpOw0KIAl9
DQotCWVlcHJvX2NvbXBsZXRlX3NlbHJlc2V0KGlvYWRkcik7DQorCWlmIChs
cC0+ZWVwcm8gPT0gTEFONTk1RlhfMTBJU0EpIHsNCisJCWVlcHJvX2NvbXBs
ZXRlX3NlbHJlc2V0KGlvYWRkcik7DQorCX0NCisJZWxzZQ0KKwkJZWVwcm9f
ZW5fcngoaW9hZGRyKTsNCiB9DQogDQogLyogVGhlIGhvcnJpYmxlIHJvdXRp
bmUgdG8gcmVhZCBhIHdvcmQgZnJvbSB0aGUgc2VyaWFsIEVFUFJPTS4gKi8N
CkBAIC0xNTM1LDcgKzE1NDksOSBAQA0KIAkJCXByaW50ayhLRVJOX0RFQlVH
ICIlczogZXhpdGluZyBoYXJkd2FyZV9zZW5kX3BhY2tldCByb3V0aW5lLlxu
IiwgZGV2LT5uYW1lKTsNCiAJCXJldHVybjsNCiAJfQ0KLQluZXRpZl9zdG9w
X3F1ZXVlKGRldik7DQorCWlmIChscC0+ZWVwcm8gPT0gTEFONTk1RlhfMTBJ
U0EpDQorCQluZXRpZl9zdG9wX3F1ZXVlKGRldik7DQorDQogCWlmIChuZXRf
ZGVidWcgPiA1KQ0KIAkJcHJpbnRrKEtFUk5fREVCVUcgIiVzOiBleGl0aW5n
IGhhcmR3YXJlX3NlbmRfcGFja2V0IHJvdXRpbmUuXG4iLCBkZXYtPm5hbWUp
Ow0KIH0NCkBAIC0xNjU0LDkgKzE2NzAsMTMgQEANCiAJCXhtdF9zdGF0dXMg
PSBpbncoaW9hZGRyK0lPX1BPUlQpOw0KIAkJDQogCQlpZiAoKHhtdF9zdGF0
dXMgJiBUWF9ET05FX0JJVCkgPT0gMCkgew0KLQkJCXVkZWxheSg0MCk7DQot
CQkJYm9ndXNjb3VudC0tOw0KLQkJCWNvbnRpbnVlOw0KKwkJCWlmIChscC0+
ZWVwcm8gPT0gTEFONTk1RlhfMTBJU0EpIHsNCisJCQkJdWRlbGF5KDQwKTsN
CisJCQkJYm9ndXNjb3VudC0tOw0KKwkJCQljb250aW51ZTsNCisJCQl9DQor
CQkJZWxzZQ0KKwkJCQlicmVhazsNCiAJCX0NCiANCiAJCXhtdF9zdGF0dXMg
PSBpbncoaW9hZGRyK0lPX1BPUlQpOyANCkBAIC0xNzIzLDcgKzE3NDMsNyBA
QA0KIAkgKiBpbnRlcnJ1cHQgYWdhaW4gZm9yIHR4LiBpbiBvdGhlciB3b3Jk
czogdHggdGltZW91dCB3aGF0IHdpbGwgdGFrZQ0KIAkgKiBhIGxvdCBvZiB0
aW1lIHRvIGhhcHBlbiwgc28gd2UnbGwgZG8gYSBjb21wbGV0ZSBzZWxyZXNl
dC4NCiAJICovDQotCWlmICghYm9ndXNjb3VudCkNCisJaWYgKCFib2d1c2Nv
dW50ICYmIGxwLT5lZXBybyA9PSBMQU41OTVGWF8xMElTQSkNCiAJCWVlcHJv
X2NvbXBsZXRlX3NlbHJlc2V0KGlvYWRkcik7DQogfQ0KIA0K
--852975170-1435406135-978996779=:195--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
