Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbUCaTgg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 14:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbUCaTgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 14:36:36 -0500
Received: from 228.17.30.61.isp.tfn.net.tw ([61.30.17.228]:50962 "EHLO
	cm-msg-02.cmedia.com.tw") by vger.kernel.org with ESMTP
	id S262389AbUCaTg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 14:36:29 -0500
Subject: ANN: cmpci 6.67 released
Date: Thu, 1 Apr 2004 03:29:44 +0800
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C41756.853DF816"
Message-ID: <92C0412E07F63549B2A2F2345D3DB515F7D403@cm-msg-02.cmedia.com.tw>
X-MS-Has-Attach: yes
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]: cmpci.c
content-class: urn:content-classes:message
Thread-Index: AcPoPln518nTM2OeR7+CNxqaVKXWNQn7zVPjAcoAQ/Y=
From: =?big5?B?Qy5MLiBUaWVuIC0gpdCp08Kn?= <cltien@cmedia.com.tw>
To: <linux-kernel@vger.kernel.org>, <linux-audio-dev@music.columbia.edu>
Cc: =?big5?B?pqyrSLhzstUtuvSttiBTdXBwb3J0IKtIvWM=?= 
	<support@cmedia.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C41756.853DF816
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable


Hi,

I made serveral changes for 6.64, the change are as following:

revision 6.67
date: 2004/03/31 17:56:11;  author: cltien;  state: Exp;  lines: +3 -2
Disable the timed out debug message, nothing wrong.
----------------------------
revision 6.66
date: 2004/03/31 17:42:08;  author: cltien;  state: Exp;  lines: +3 -2
Make sure to call chkintr_mpu401 after attach_mpu401 called.
----------------------------
revision 6.65
date: 2004/03/29 22:58:49;  author: cltien;  state: Exp;  lines: +5 -3
Now the AC3_SW can work on PPC for chip ver 037 or older.

Sincerely,
ChenLi Tien

------_=_NextPart_001_01C41756.853DF816
Content-Type: application/octet-stream;
	name="cmpci-6.64-6.65.patch"
Content-Transfer-Encoding: base64
Content-Description: cmpci-6.64-6.65.patch
Content-Disposition: attachment;
	filename="cmpci-6.64-6.65.patch"

SW5kZXg6IGNtcGNpLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2hvbWUvY2x0aWVuL2N2cy9jbXBj
aS9jbXBjaS5jLHYKcmV0cmlldmluZyByZXZpc2lvbiA2LjY0CnJldHJpZXZpbmcgcmV2aXNpb24g
Ni42NQpkaWZmIC1hIC11IC1yNi42NCAtcjYuNjUKLS0tIGNtcGNpLmMJMjIgTWFyIDIwMDQgMTc6
MDc6MDIgLTAwMDAJNi42NAorKysgY21wY2kuYwkyOSBNYXIgMjAwNCAyMjo1ODo0OSAtMDAwMAk2
LjY1CkBAIC05NzcsMTQgKzk3NywxNiBAQAogewogCWludCAgIGkgPSBzaXplIC8gMjsKIAl1bnNp
Z25lZCBsb25nIGRhdGE7CisJdW5zaWduZWQgc2hvcnQgZGF0YTE2OwogCXVuc2lnbmVkIGxvbmcg
KmRzdCA9ICh1bnNpZ25lZCBsb25nICopIGRlc3Q7CiAJdW5zaWduZWQgc2hvcnQgKnNyYyA9ICh1
bnNpZ25lZCBzaG9ydCAqKXNvdXJjZTsKIAlpbnQgZXJyOwogCiAJZG8gewotCQlpZiAoKGVyciA9
IF9fZ2V0X3VzZXIoZGF0YSwgc3JjKSkpCisJCWlmICgoZXJyID0gX19nZXRfdXNlcihkYXRhMTYs
IHNyYykpKQogCQkJcmV0dXJuIGVycjsKIAkJc3JjKys7CisJCWRhdGEgPSAodW5zaWduZWQgbG9u
ZylsZTE2X3RvX2NwdShkYXRhMTYpOwogCQlkYXRhIDw8PSAxMjsJCQkvLyBvayBmb3IgMTYtYml0
IGRhdGEKIAkJaWYgKHMtPnNwZGlmX2NvdW50ZXIgPT0gMiB8fCBzLT5zcGRpZl9jb3VudGVyID09
IDMpCiAJCQlkYXRhIHw9IDB4NDAwMDAwMDA7CS8vIGluZGljYXRlIEFDLTMgcmF3IGRhdGEKQEAg
LTk5Niw3ICs5OTgsNyBAQAogCQkJZGF0YSB8PSA1OwkJLy8gb2RkLCAnVycKIAkJZWxzZQogCQkJ
ZGF0YSB8PSA5OwkJLy8gZXZlbiwgJ00nCi0JCSpkc3QrKyA9IGRhdGE7CisJCSpkc3QrKyA9IGNw
dV90b19sZTMyKGRhdGEpOwogCQlzLT5zcGRpZl9jb3VudGVyKys7CiAJCWlmIChzLT5zcGRpZl9j
b3VudGVyID09IDM4NCkKIAkJCXMtPnNwZGlmX2NvdW50ZXIgPSAwOwpAQCAtMzIwOCw3ICszMjEw
LDcgQEAKIAogc3RhdGljIGludCBfX2luaXQgaW5pdF9jbXBjaSh2b2lkKQogewotCXByaW50ayhL
RVJOX0lORk8gImNtcGNpOiB2ZXJzaW9uICRSZXZpc2lvbjogNi42NCAkIHRpbWUgIiBfX1RJTUVf
XyAiICIgX19EQVRFX18gIlxuIik7CisJcHJpbnRrKEtFUk5fSU5GTyAiY21wY2k6IHZlcnNpb24g
JFJldmlzaW9uOiA2LjY1ICQgdGltZSAiIF9fVElNRV9fICIgIiBfX0RBVEVfXyAiXG4iKTsKIAly
ZXR1cm4gcGNpX21vZHVsZV9pbml0KCZjbV9kcml2ZXIpOwogfQogCg==

------_=_NextPart_001_01C41756.853DF816
Content-Type: application/octet-stream;
	name="cmpci-6.65-6.66.patch"
Content-Transfer-Encoding: base64
Content-Description: cmpci-6.65-6.66.patch
Content-Disposition: attachment;
	filename="cmpci-6.65-6.66.patch"

SW5kZXg6IGNtcGNpLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2hvbWUvY2x0aWVuL2N2cy9jbXBj
aS9jbXBjaS5jLHYKcmV0cmlldmluZyByZXZpc2lvbiA2LjY1CnJldHJpZXZpbmcgcmV2aXNpb24g
Ni42NgpkaWZmIC1hIC11IC1yNi42NSAtcjYuNjYKLS0tIGNtcGNpLmMJMjkgTWFyIDIwMDQgMjI6
NTg6NDkgLTAwMDAJNi42NQorKysgY21wY2kuYwkzMSBNYXIgMjAwNCAxNzo0MjowOCAtMDAwMAk2
LjY2CkBAIC0xNTUwLDcgKzE1NTAsNyBAQAogCXNwaW5fdW5sb2NrKCZzLT5sb2NrKTsKICNpZmRl
ZiBDT05GSUdfU09VTkRfQ01QQ0lfTUlESQogCWlmIChpbnRzcmMgJiAweDAwMDEwMDAwKSB7CS8v
IFVBUlQgaW50ZXJydXB0Ci0JCWlmIChpbnRjaGtfbXB1NDAxKCh2b2lkICopcy0+bWlkaV9kZXZj
KSkKKwkJaWYgKHMtPm1pZGlfZGV2YyAmJiBpbnRjaGtfbXB1NDAxKCh2b2lkICopcy0+bWlkaV9k
ZXZjKSkKIAkJCW1wdWludHIoaXJxLCAodm9pZCAqKXMtPm1pZGlfZGV2YywgcmVncyk7CiAJCWVs
c2UKIAkJCWluYihzLT5pb21pZGkpOy8vIGR1bW15IHJlYWQKQEAgLTMwNzEsNiArMzA3MSw3IEBA
CiAJfQogI2VuZGlmCiAjaWZkZWYgQ09ORklHX1NPVU5EX0NNUENJX01JREkKKwlzLT5taWRpX2Rl
dmMgPSAwOwogCS8qIGRpc2FibGUgTVBVLTQwMSAqLwogCW1hc2tiKHMtPmlvYmFzZSArIENPREVD
X0NNSV9GVU5DVFJMMSwgfjB4MDQsIDApOwogCXMtPm1wdV9kYXRhLm5hbWUgPSAiY21wY2kgbXB1
IjsKQEAgLTMyMTAsNyArMzIxMSw3IEBACiAKIHN0YXRpYyBpbnQgX19pbml0IGluaXRfY21wY2ko
dm9pZCkKIHsKLQlwcmludGsoS0VSTl9JTkZPICJjbXBjaTogdmVyc2lvbiAkUmV2aXNpb246IDYu
NjUgJCB0aW1lICIgX19USU1FX18gIiAiIF9fREFURV9fICJcbiIpOworCXByaW50ayhLRVJOX0lO
Rk8gImNtcGNpOiB2ZXJzaW9uICRSZXZpc2lvbjogNi42NiAkIHRpbWUgIiBfX1RJTUVfXyAiICIg
X19EQVRFX18gIlxuIik7CiAJcmV0dXJuIHBjaV9tb2R1bGVfaW5pdCgmY21fZHJpdmVyKTsKIH0K
IAo=

------_=_NextPart_001_01C41756.853DF816
Content-Type: application/octet-stream;
	name="cmpci-6.66-6.67.patch"
Content-Transfer-Encoding: base64
Content-Description: cmpci-6.66-6.67.patch
Content-Disposition: attachment;
	filename="cmpci-6.66-6.67.patch"

SW5kZXg6IGNtcGNpLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2hvbWUvY2x0aWVuL2N2cy9jbXBj
aS9jbXBjaS5jLHYKcmV0cmlldmluZyByZXZpc2lvbiA2LjY2CnJldHJpZXZpbmcgcmV2aXNpb24g
Ni42NwpkaWZmIC1hIC11IC1yNi42NiAtcjYuNjcKLS0tIGNtcGNpLmMJMzEgTWFyIDIwMDQgMTc6
NDI6MDggLTAwMDAJNi42NgorKysgY21wY2kuYwkzMSBNYXIgMjAwNCAxNzo1NjoxMSAtMDAwMAk2
LjY3CkBAIC0xMjYsNiArMTI2LDcgQEAKIC8qIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSAqLwogI3VuZGVmIE9TU19E
T0NVTUVOVEVEX01JWEVSX1NFTUFOVElDUwogI3VuZGVmIERNQUJZVEVJTworI2RlZmluZQlEQkco
eCkge30KIC8qIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLSAqLwogCiAjZGVmaW5lIENNX01BR0lDICAoKFBDSV9WRU5E
T1JfSURfQ01FRElBPDwxNil8UENJX0RFVklDRV9JRF9DTUVESUFfQ004MzM4QSkKQEAgLTE5MDYs
NyArMTkwNyw3IEBACiAJCXRtbyA9IDMgKiBIWiAqIChjb3VudCArIHMtPmRtYV9kYWMuZnJhZ3Np
emUpIC8gMiAvIHMtPnJhdGVkYWM7CiAJCXRtbyA+Pj0gc2FtcGxlX3NoaWZ0WyhzLT5mbXQgPj4g
Q01fQ0ZNVF9EQUNTSElGVCkgJiBDTV9DRk1UX01BU0tdOwogCQlpZiAoIXNjaGVkdWxlX3RpbWVv
dXQodG1vICsgMSkpCi0JCQlwcmludGsoS0VSTl9ERUJVRyAiY21wY2k6IGRtYSB0aW1lZCBvdXQ/
P1xuIik7CisJCQlEQkcocHJpbnRrKEtFUk5fREVCVUcgImNtcGNpOiBkbWEgdGltZWQgb3V0Pz9c
biIpOykKICAgICAgICAgfQogICAgICAgICByZW1vdmVfd2FpdF9xdWV1ZSgmcy0+ZG1hX2RhYy53
YWl0LCAmd2FpdCk7CiAgICAgICAgIHNldF9jdXJyZW50X3N0YXRlKFRBU0tfUlVOTklORyk7CkBA
IC0zMjExLDcgKzMyMTIsNyBAQAogCiBzdGF0aWMgaW50IF9faW5pdCBpbml0X2NtcGNpKHZvaWQp
CiB7Ci0JcHJpbnRrKEtFUk5fSU5GTyAiY21wY2k6IHZlcnNpb24gJFJldmlzaW9uOiA2LjY2ICQg
dGltZSAiIF9fVElNRV9fICIgIiBfX0RBVEVfXyAiXG4iKTsKKwlwcmludGsoS0VSTl9JTkZPICJj
bXBjaTogdmVyc2lvbiAkUmV2aXNpb246IDYuNjcgJCB0aW1lICIgX19USU1FX18gIiAiIF9fREFU
RV9fICJcbiIpOwogCXJldHVybiBwY2lfbW9kdWxlX2luaXQoJmNtX2RyaXZlcik7CiB9CiAK

------_=_NextPart_001_01C41756.853DF816--
