Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262072AbUKDFOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbUKDFOp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 00:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbUKDFOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 00:14:45 -0500
Received: from coriana6.CIS.McMaster.CA ([130.113.128.17]:22409 "EHLO
	coriana6.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S262072AbUKDFOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 00:14:40 -0500
Subject: [PATCH] bttv winfast 2000 tuner type
From: John McCutchan <ttb@tentacle.dhs.org>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-l+cj6R+82/g9koMD6BXK"
Date: Thu, 04 Nov 2004 00:18:27 -0500
Message-Id: <1099545507.24027.1.camel@vertex>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-PMX-Version-Mac: 4.7.0.111621, Antispam-Engine: 2.0.2.0, Antispam-Data: 2004.11.3.5
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTYPE_HAS_BOUNDARY 0, __CTYPE_MULTIPART 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-l+cj6R+82/g9koMD6BXK
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Trivial patch that lets you configure the tuner type of your winfast
2000 tuner card. The default value is the previous hard coded value.

-- 
John McCutchan <ttb@tentacle.dhs.org>

--=-l+cj6R+82/g9koMD6BXK
Content-Disposition: attachment; filename=bttv-winfast-2000-tuner-type.diff
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name=bttv-winfast-2000-tuner-type.diff; charset=UTF-8

LS0tIGNsZWFuL2xpbnV4L2RyaXZlcnMvbWVkaWEvdmlkZW8vS2NvbmZpZwkyMDA0LTEwLTE4IDE3
OjU1OjE4LjAwMDAwMDAwMCAtMDQwMA0KKysrIGxpbnV4L2RyaXZlcnMvbWVkaWEvdmlkZW8vS2Nv
bmZpZwkyMDA0LTExLTA0IDAwOjA3OjU3LjAwMDAwMDAwMCAtMDUwMA0KQEAgLTIyLDYgKzIyLDE4
IEBADQogCSAgVG8gY29tcGlsZSB0aGlzIGRyaXZlciBhcyBhIG1vZHVsZSwgY2hvb3NlIE0gaGVy
ZTogdGhlDQogCSAgbW9kdWxlIHdpbGwgYmUgY2FsbGVkIGJ0dHYuDQogDQorY29uZmlnIFZJREVP
X1dJTkZBU1QyMDAwX1RVTkVSX1RZUEUNCisJaW50ICJMZWFkdGVrIFdpbkZhc3QgMjAwMCB0dW5l
ciB0eXBlIg0KKwlkZXBlbmRzIG9uIFZJREVPX0JUODQ4DQorCWRlZmF1bHQgNQ0KKwloZWxwDQor
CSAgU2VsZWN0cyB0aGUgdHVuZXIgdHlwZSBmb3IgdGhlIFdpbkZhc3QgMjAwMCBUViBUdW5lciBj
YXJkcy4NCisNCisJICBLbm93biB0dW5lciB0eXBlczoNCisNCisJICA1IC0gUEFMDQorCSAgMiAt
IE5UU0MNCisNCiBjb25maWcgVklERU9fUE1TDQogCXRyaXN0YXRlICJNZWRpYXZpc2lvbiBQcm8g
TW92aWUgU3R1ZGlvIFZpZGVvIEZvciBMaW51eCINCiAJZGVwZW5kcyBvbiBWSURFT19ERVYgJiYg
SVNBDQotLS0gY2xlYW4vbGludXgvZHJpdmVycy9tZWRpYS92aWRlby9idHR2LWNhcmRzLmMJMjAw
NC0xMC0xOCAxNzo1NDowOC4wMDAwMDAwMDAgLTA0MDANCisrKyBsaW51eC9kcml2ZXJzL21lZGlh
L3ZpZGVvL2J0dHYtY2FyZHMuYwkyMDA0LTExLTA0IDAwOjExOjI1LjAwMDAwMDAwMCAtMDUwMA0K
QEAgLTc5NCw3ICs3OTQsNyBAQA0KIAkubmVlZHNfdHZhdWRpbwk9IDAsDQogCS5wbGwJCT0gUExM
XzI4LA0KIAkuaGFzX3JhZGlvCT0gMSwNCi0JLnR1bmVyX3R5cGUJPSA1LCAvLyBkZWZhdWx0IGZv
ciBub3csIGdwaW8gcmVhZHMgQkZGRjA2IGZvciBQYWwgYmcrZGsNCisJLnR1bmVyX3R5cGUJPSBD
T05GSUdfVklERU9fV0lORkFTVDIwMDBfVFVORVJfVFlQRSwgDQogCS5hdWRpb19ob29rCT0gd2lu
ZmFzdDIwMDBfYXVkaW8sDQogCS5oYXNfcmVtb3RlICAgICA9IDEsDQogfSx7DQo=


--=-l+cj6R+82/g9koMD6BXK--
