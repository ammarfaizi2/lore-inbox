Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283231AbRLDSTL>; Tue, 4 Dec 2001 13:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281158AbRLDSTB>; Tue, 4 Dec 2001 13:19:01 -0500
Received: from mail12.svr.pol.co.uk ([195.92.193.215]:45644 "EHLO
	mail12.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S283231AbRLDSRR>; Tue, 4 Dec 2001 13:17:17 -0500
From: Paul Cook <paul@anville.co.uk>
Reply-To: paul@anville.co.uk
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Small X25 IOCTL Fix
Date: Tue, 4 Dec 2001 18:17:46 +0000
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_M50UCS184FYRLSIV3W2C"
Message-Id: <E16BK82-0006RP-00.2001-12-04-18-17-14@mail12.svr.pol.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_M50UCS184FYRLSIV3W2C
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit


Hi,

without the following small patch, it is impossible, using the ioctl 
interface, to disable the throughput facility without patching /include/x25.h 
and re-compiling.

This is made against a 2.2.19, but looks equally relevant for 2.4.x



--------------Boundary-00=_M50UCS184FYRLSIV3W2C
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="x25_ioctl.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="x25_ioctl.diff"

LS0tIG5ldC94MjUvb2xkX2FmX3gyNS5jCVdlZCBOb3YgMjggMTg6Mzc6MTUgMjAwMQorKysgbmV0
L3gyNS9hZl94MjUuYwlUaHUgTm92IDI5IDEyOjMzOjUwIDIwMDEKQEAgLTExNTAsNyArMTE1MCw3
IEBACiAJCQkJcmV0dXJuIC1FSU5WQUw7CiAJCQlpZiAoZmFjaWxpdGllcy53aW5zaXplX2luIDwg
MSB8fCBmYWNpbGl0aWVzLndpbnNpemVfaW4gPiAxMjcpCiAJCQkJcmV0dXJuIC1FSU5WQUw7Ci0J
CQlpZiAoZmFjaWxpdGllcy50aHJvdWdocHV0IDwgMHgwMyB8fCBmYWNpbGl0aWVzLnRocm91Z2hw
dXQgPiAweDJDKQorCQkJaWYgKGZhY2lsaXRpZXMudGhyb3VnaHB1dCAmJiAoZmFjaWxpdGllcy50
aHJvdWdocHV0IDwgMHgwMyB8fCBmYWNpbGl0aWVzLnRocm91Z2hwdXQgPiAweDJDKSkKIAkJCQly
ZXR1cm4gLUVJTlZBTDsKIAkJCWlmIChmYWNpbGl0aWVzLnJldmVyc2UgIT0gMCAmJiBmYWNpbGl0
aWVzLnJldmVyc2UgIT0gMSkKIAkJCQlyZXR1cm4gLUVJTlZBTDsK

--------------Boundary-00=_M50UCS184FYRLSIV3W2C--
