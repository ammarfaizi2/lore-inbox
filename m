Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288712AbSADTYB>; Fri, 4 Jan 2002 14:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288727AbSADTXy>; Fri, 4 Jan 2002 14:23:54 -0500
Received: from pc2-camb4-0-cust102.cam.cable.ntl.com ([213.107.105.102]:6280
	"EHLO eden.lincnet") by vger.kernel.org with ESMTP
	id <S288712AbSADTXo>; Fri, 4 Jan 2002 14:23:44 -0500
Date: Fri, 4 Jan 2002 19:23:40 +0000 (GMT)
From: Carl Ritson <critson@perlfu.co.uk>
X-X-Sender: <critson@eden.lincnet>
To: <rui.p.m.sousa@clix.pt>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] kdev_t compile fixes emu10k1 (2.5.2-pre7)
Message-ID: <Pine.LNX.4.33.0201041916440.8923-200000@eden.lincnet>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463809535-817308798-1010172184=:8923"
Content-ID: <Pine.LNX.4.33.0201041923220.8923@eden.lincnet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463809535-817308798-1010172184=:8923
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.33.0201041923221.8923@eden.lincnet>

Convert MINOR to minor.

Carl Ritson
critson@perlfu.co.uk

---1463809535-817308798-1010172184=:8923
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME=patch-kdev_t-emu10k1
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0201041923040.8923@eden.lincnet>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME=patch-kdev_t-emu10k1

ZGlmZiAtdSBsaW51eC0yLjUvZHJpdmVycy9zb3VuZC9lbXUxMGsxL2F1ZGlv
LmMgbGludXgvZHJpdmVycy9zb3VuZC9lbXUxMGsxL2F1ZGlvLmMNCi0tLSBs
aW51eC0yLjUvZHJpdmVycy9zb3VuZC9lbXUxMGsxL2F1ZGlvLmMJVHVlIE9j
dCAgOSAxODo1MzoxNyAyMDAxDQorKysgbGludXgvZHJpdmVycy9zb3VuZC9l
bXUxMGsxL2F1ZGlvLmMJRnJpIEphbiAgNCAxOTowNDoxMyAyMDAyDQpAQCAt
MTA5OCw3ICsxMDk4LDcgQEANCiANCiBzdGF0aWMgaW50IGVtdTEwazFfYXVk
aW9fb3BlbihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmls
ZSkNCiB7DQotCWludCBtaW5vciA9IE1JTk9SKGlub2RlLT5pX3JkZXYpOw0K
KwlpbnQgbWlub3IgPSBtaW5vcihpbm9kZS0+aV9yZGV2KTsNCiAJc3RydWN0
IGVtdTEwazFfY2FyZCAqY2FyZCA9IE5VTEw7DQogCXN0cnVjdCBsaXN0X2hl
YWQgKmVudHJ5Ow0KIAlzdHJ1Y3QgZW11MTBrMV93YXZlZGV2aWNlICp3YXZl
X2RldjsNCmRpZmYgLXUgbGludXgtMi41L2RyaXZlcnMvc291bmQvZW11MTBr
MS9taWRpLmMgbGludXgvZHJpdmVycy9zb3VuZC9lbXUxMGsxL21pZGkuYw0K
LS0tIGxpbnV4LTIuNS9kcml2ZXJzL3NvdW5kL2VtdTEwazEvbWlkaS5jCVR1
ZSBPY3QgIDkgMTg6NTM6MTggMjAwMQ0KKysrIGxpbnV4L2RyaXZlcnMvc291
bmQvZW11MTBrMS9taWRpLmMJRnJpIEphbiAgNCAxOTowODoxMiAyMDAyDQpA
QCAtODcsNyArODcsNyBAQA0KIA0KIHN0YXRpYyBpbnQgZW11MTBrMV9taWRp
X29wZW4oc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbGUp
DQogew0KLQlpbnQgbWlub3IgPSBNSU5PUihpbm9kZS0+aV9yZGV2KTsNCisJ
aW50IG1pbm9yID0gbWlub3IoaW5vZGUtPmlfcmRldik7DQogCXN0cnVjdCBl
bXUxMGsxX2NhcmQgKmNhcmQgPSBOVUxMOw0KIAlzdHJ1Y3QgZW11MTBrMV9t
aWRpZGV2aWNlICptaWRpX2RldjsNCiAJc3RydWN0IGxpc3RfaGVhZCAqZW50
cnk7DQpkaWZmIC11IGxpbnV4LTIuNS9kcml2ZXJzL3NvdW5kL2VtdTEwazEv
bWl4ZXIuYyBsaW51eC9kcml2ZXJzL3NvdW5kL2VtdTEwazEvbWl4ZXIuYw0K
LS0tIGxpbnV4LTIuNS9kcml2ZXJzL3NvdW5kL2VtdTEwazEvbWl4ZXIuYwlU
dWUgT2N0ICA5IDE4OjUzOjE4IDIwMDENCisrKyBsaW51eC9kcml2ZXJzL3Nv
dW5kL2VtdTEwazEvbWl4ZXIuYwlGcmkgSmFuICA0IDE5OjA4OjU5IDIwMDIN
CkBAIC02NDAsNyArNjQwLDcgQEANCiANCiBzdGF0aWMgaW50IGVtdTEwazFf
bWl4ZXJfb3BlbihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAq
ZmlsZSkNCiB7DQotCWludCBtaW5vciA9IE1JTk9SKGlub2RlLT5pX3JkZXYp
Ow0KKwlpbnQgbWlub3IgPSBtaW5vcihpbm9kZS0+aV9yZGV2KTsNCiAJc3Ry
dWN0IGVtdTEwazFfY2FyZCAqY2FyZCA9IE5VTEw7DQogCXN0cnVjdCBsaXN0
X2hlYWQgKmVudHJ5Ow0K
---1463809535-817308798-1010172184=:8923--
