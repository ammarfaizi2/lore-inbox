Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264953AbUGZHLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264953AbUGZHLq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 03:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264960AbUGZHLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 03:11:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59310 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264953AbUGZHLo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 03:11:44 -0400
Date: Mon, 26 Jul 2004 00:11:34 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: marcelo.tosatti@cyclades.com
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org, <wolfgang@iksw-muees.de>
Subject: Patch for USB in 2.4 to fix endless resubmit in auerswald
Message-Id: <20040726001134.57949a45@lembas.zaitcev.lan>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Mon__26_Jul_2004_00_11_34_-0700_r3WNKfKQnJn/Pnwm"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Mon__26_Jul_2004_00_11_34_-0700_r3WNKfKQnJn/Pnwm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Patch from Wolfgang Mues - fixes an endless loop on disconnect.

I am sorry for MIME attachement, but the source code contains
a European character, which makes my mailer to encode the mail
and thus corrupt the patch, when sent normally.

-- Pete

--Multipart=_Mon__26_Jul_2004_00_11_34_-0700_r3WNKfKQnJn/Pnwm
Content-Type: application/octet-stream;
 name="linux-2.4.27-rc3-auer.diff"
Content-Disposition: attachment;
 filename="linux-2.4.27-rc3-auer.diff"
Content-Transfer-Encoding: base64

UGF0Y2ggZnJvbSBXb2xmZ2FuZyBNdWVzLgoKZGlmZiAtdXJwIC1YIGRvbnRkaWZmIGxpbnV4LTIu
NC4yNy1yYzMvZHJpdmVycy91c2IvYXVlcm1haW4uYyBsaW51eC0yLjQuMjctcmMzLXVzYi9kcml2
ZXJzL3VzYi9hdWVybWFpbi5jCi0tLSBsaW51eC0yLjQuMjctcmMzL2RyaXZlcnMvdXNiL2F1ZXJt
YWluLmMJMjAwNC0wMi0yNiAxNDowOTo1Ny4wMDAwMDAwMDAgLTA4MDAKKysrIGxpbnV4LTIuNC4y
Ny1yYzMtdXNiL2RyaXZlcnMvdXNiL2F1ZXJtYWluLmMJMjAwNC0wNy0yNSAyMzozNzowOS4wMDAw
MDAwMDAgLTA3MDAKQEAgLTU1LDcgKzU1LDcgQEAgZG8gewkJCVwKIAogLyotLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKi8K
IC8qIFZlcnNpb24gSW5mb3JtYXRpb24gKi8KLSNkZWZpbmUgRFJJVkVSX1ZFUlNJT04gIjEuMi42
IgorI2RlZmluZSBEUklWRVJfVkVSU0lPTiAiMS4yLjciCiAjZGVmaW5lIERSSVZFUl9BVVRIT1Ig
ICJXb2xmZ2FuZyBNw7xlcyA8d29sZmdhbmdAaWtzdy1tdWVlcy5kZT4iCiAjZGVmaW5lIERSSVZF
Ul9ERVNDICAgICJBdWVyc3dhbGQgUEJYL1N5c3RlbSBUZWxlcGhvbmUgdXNiIGRyaXZlciIKIApA
QCAtMTEwLDggKzExMCw4IEBAIHN0YXRpYyBpbnQgYXVlcnN3YWxkX3N0YXR1c19yZXRyeShpbnQg
c3QKIAljYXNlIDA6CiAJY2FzZSAtRVRJTUVET1VUOgogCWNhc2UgLUVPVkVSRkxPVzoKKwljYXNl
IC1FRkJJRzoKIAljYXNlIC1FQUdBSU46Ci0JY2FzZSAtRVBJUEU6CiAJY2FzZSAtRVBST1RPOgog
CWNhc2UgLUVJTFNFUToKIAljYXNlIC1FTk9TUjoK

--Multipart=_Mon__26_Jul_2004_00_11_34_-0700_r3WNKfKQnJn/Pnwm--
