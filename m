Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288158AbSAQDyA>; Wed, 16 Jan 2002 22:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288159AbSAQDxv>; Wed, 16 Jan 2002 22:53:51 -0500
Received: from 24.213.60.123.up.mi.chartermi.net ([24.213.60.123]:56280 "EHLO
	front1.chartermi.net") by vger.kernel.org with ESMTP
	id <S288158AbSAQDxl>; Wed, 16 Jan 2002 22:53:41 -0500
From: reddog83 <reddog83@chartermi.net>
Reply-To: reddog83@chartermi.net
To: alan@lxorguk.ukuu.org.uk
Subject: [PATCH] radeonfb for kernel-2.4.18-pre1
Date: Wed, 16 Jan 2002 22:54:35 -0500
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_ZID2S9A9YWNNISWEUVNP"
Message-ID: <auto-000047991150@front1.chartermi.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_ZID2S9A9YWNNISWEUVNP
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi this patch fix's up the compiling issue with the Radeon Frame Buffer 
driver. With this patch it should compile. I checked all over the LKML and 
there has ben acouple of people who have sent the same patch in but have not 
been acknowledged. Please apply this patch. Or Alan would you please include 
this patch in your next ac release if you do have one? 
Thank you Victor
--------------Boundary-00=_ZID2S9A9YWNNISWEUVNP
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="radeonfb.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="radeonfb.diff"

LS0tIGxpbnV4LTIuNC4xOC1wcmUxL2RyaXZlcnMvdmlkZW8vcmFkZW9uZmIuYy5vcmlnICAgU2F0
IERlYyAyOSAyMDo0ODowNyAyMDAxCisrKyBsaW51eC0yLjQuMTgtcHJlMS9kcml2ZXJzL3ZpZGVv
L3JhZGVvbmZiLmMgICAgICAgIFNhdCBEZWMgMjkgMjI6MzU6MjEgMjAwMQpAQCAtNzYsNiArNzYs
NyBAQAogI2luY2x1ZGUgPHZpZGVvL2ZiY29uLWNmYjMyLmg+CiAjaW5jbHVkZSAicmFkZW9uLmgi
CisjZGVmaW5lIExWRFNfU1RBVEVfTUFTSyAweEZGRkZGRkZGCgogI2RlZmluZSBERUJVRyAgICAg
ICAgMApAQCAtMjI4MCw3ICsyMjgxLDcgQEAKICAgICAgc2F2ZS0+bHZkc19nZW5fY250bCA9IElO
UkVHKExWRFNfR0VOX0NOVEwpOwogICAgICBzYXZlLT5sdmRzX3BsbF9jbnRsID0gSU5SRUcoTFZE
U19QTExfQ05UTCk7CiAgICAgIHNhdmUtPnRtZHNfY3JjID0gSU5SRUcoVE1EU19DUkMpOwotICAg
ICBzYXZlLT50bWRzX3RyYW5zbWl0dGVyX2NudGwgPSBJTlJFRyhUTURTX1RSQU5TTUlUVEVSX0NO
VEwpOworLyogICBzYXZlLT50bWRzX3RyYW5zbWl0dGVyX2NudGwgPSBJTlJFRyhUTURTX1RSQU5T
TUlUVEVSX0NOVEwpOyAqLwogfQoKQEAgLTI1NTcsOCArMjU1OCw4IEBACiAgICAgICAgICAgICAg
fSBlbHNlIHsKICAgICAgICAgICAgICAgICAgICAgIC8qIERGUCAqLwogICAgICAgICAgICAgICAg
ICAgICAgbmV3bW9kZS5mcF9nZW5fY250bCB8PSAoRlBfRlBPTiB8IEZQX1RNRFNfRU4pOwotICAg
ICAgICAgICAgICAgICAgICAgbmV3bW9kZS50bWRzX3RyYW5zbWl0dGVyX2NudGwgPSAoVE1EU19S
QU5fUEFUX1JTVCB8Ci0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBJQ0hDU0VMKSAmIH4oVE1EU19QTExSU1QpOworLyogICAgICAgICAgICAgICAg
ICAgbmV3bW9kZS50bWRzX3RyYW5zbWl0dGVyX2NudGwgPSAoVE1EU19SQU5fUEFUX1JTVCB8Cisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJQ0hD
U0VMKSAmIH4oVE1EU19QTExSU1QpOyAqLwogICAgICAgICAgICAgICAgICAgICAgbmV3bW9kZS5j
cnRjX2V4dF9jbnRsICY9IH5DUlRDX0NSVF9PTjsKICAgICAgICAgICAgICB9CiBAQCAtMjY0Nyw3
ICsyNjQ4LDcgQEAKICAgICAgICAgICAgICBPVVRSRUcoRlBfVkVSVF9TVFJFVENILCBtb2RlLT5m
cF92ZXJ0X3N0cmV0Y2gpOwogICAgICAgICAgICAgIE9VVFJFRyhGUF9HRU5fQ05UTCwgbW9kZS0+
ZnBfZ2VuX2NudGwpOwogICAgICAgICAgICAgIE9VVFJFRyhUTURTX0NSQywgbW9kZS0+dG1kc19j
cmMpOwotICAgICAgICAgICAgIE9VVFJFRyhUTURTX1RSQU5TTUlUVEVSX0NOVEwsIG1vZGUtPnRt
ZHNfdHJhbnNtaXR0ZXJfY250bCk7CisvKiAgICAgICAgICAgT1VUUkVHKFRNRFNfVFJBTlNNSVRU
RVJfQ05UTCwgbW9kZS0+dG1kc190cmFuc21pdHRlcl9jbnRsKTsgKi8KICAgICAgICAgICAgICAg
aWYgKHByaW1hcnlfbW9uID09IE1UX0xDRCkgewogICAgICAgICAgICAgICAgICAgICAgdW5zaWdu
ZWQgaW50IHRtcCA9IElOUkVHKExWRFNfR0VOX0NOVEwpOwo=

--------------Boundary-00=_ZID2S9A9YWNNISWEUVNP--
