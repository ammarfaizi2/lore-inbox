Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282702AbRLFUFa>; Thu, 6 Dec 2001 15:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284178AbRLFUFQ>; Thu, 6 Dec 2001 15:05:16 -0500
Received: from auucp0.ams.ops.eu.uu.net ([195.129.70.39]:24202 "EHLO
	auucp0.ams.ops.eu.uu.net") by vger.kernel.org with ESMTP
	id <S283924AbRLFUE2>; Thu, 6 Dec 2001 15:04:28 -0500
Date: Thu, 6 Dec 2001 21:01:59 +0100 (CET)
From: kees <kees@schoen.nl>
To: <linux-kernel@vger.kernel.org>
Subject: Q: device(file) permissions for USB
Message-ID: <Pine.LNX.4.33.0112062055210.13843-200000@schoen3.schoen.nl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463801846-915869288-1007668919=:13843"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463801846-915869288-1007668919=:13843
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,

I have been playing with an USB camera. I've run into the following
problem:
The (default?) permissions for /proc/bus/usb/001/011 (and others) are
0644. This makes the ioctl (see attached trace to fail). So I have to:
either chmod the usb device file each time I unplug and replug the camera
OR make the pencam program SUID root, which is neither comfortable.
Is there a way to affect the default permissions for the USB devices?

regards
Kees

---1463801846-915869288-1007668919=:13843
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=TRACE_1
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0112062101590.13843@schoen3.schoen.nl>
Content-Description: 
Content-Disposition: attachment; filename=TRACE_1

b3BlbigiL3Byb2MvYnVzL3VzYi8wMDIvMDAxIiwgT19SRE9OTFkpID0gNQ0K
cmVhZCg1LCAiXDIyXDFcMFwxXHRcMFwwXDEwXDBcMFwwXDBcMFwwXDBcMlwx
XDEiLCAxOCkgPSAxOA0KY2xvc2UoNSkgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgID0gMA0KaXBjX3N1YmNhbGwoMHg0LCAweDgwNGU1NjgsIDB4
NDAwLCAwKSAgID0gMA0KY2xvc2UoNCkgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgID0gMA0Kb3BlbigiL3Byb2MvYnVzL3VzYi8wMDEvMDExIiwg
T19SRFdSKSAgID0gLTEgRUFDQ0VTIChQZXJtaXNzaW9uIGRlbmllZCkNCm9w
ZW4oIi9wcm9jL2J1cy91c2IvMDAxLzAxMSIsIE9fUkRPTkxZKSA9IDQNCmlv
Y3RsKDQsIDB4ODAwNDU1MDUsIDB4YmZmZmVhZjgpICAgICAgICA9IC0xIEVQ
RVJNIChPcGVyYXRpb24gbm90IHBlcm1pdHRlZCkNCmZzdGF0NjQoMSwge3N0
X21vZGU9U19JRkNIUnwwNjIwLCBzdF9yZGV2PW1ha2VkZXYoMTM2LCA3KSwg
Li4ufSkgPSAwDQpvbGRfbW1hcChOVUxMLCA0MDk2LCBQUk9UX1JFQUR8UFJP
VF9XUklURSwgTUFQX1BSSVZBVEV8TUFQX0FOT05ZTU9VUywgLTEsIDApID0g
MHg0MDAxNzAwMA0KaW9jdGwoMSwgVENHRVRTLCB7Qjk2MDAgb3Bvc3QgaXNp
ZyBpY2Fub24gZWNobyAuLi59KSA9IDANCndyaXRlKDEsICJwZW5jYW1fc2V0
X2NvbmZpZ3VyYXRpb24gZXJyb3JcbiIsIDMxKSA9IDMxDQppb2N0bCg0LCAw
eGMwMTA1NTAwLCAweGJmZmZlYWFjKSAgICAgICAgPSAtMSBFUEVSTSAoT3Bl
cmF0aW9uIG5vdCBwZXJtaXR0ZWQpDQppb2N0bCg0LCAweGMwMTA1NTAwLCAw
eGJmZmZlYWFjKSAgICAgICAgPSAtMSBFUEVSTSAoT3BlcmF0aW9uIG5vdCBw
ZXJtaXR0ZWQpDQp3cml0ZSgxLCAiTGFzdCBlcnJvcjogMjU1LCAgY29tbWFu
ZCA9IDB4ZmYiLi4uLCAzMykgPSAzMw0Kd3JpdGUoMSwgIkNhbWVyYSBwaW5n
IGZhaWxlZCEhIENoZWNrIGNvbm5lIi4uLiwgNTQpID0gNTQNCndyaXRlKDEs
ICJFcnJvciBpbml0aWFsaXppbmcgY2FtZXJhISFcbiIsIDI4KSA9IDI4DQpj
bG9zZSg0KSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPSAwDQo=
---1463801846-915869288-1007668919=:13843--
