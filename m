Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262298AbVCXAhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbVCXAhd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 19:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbVCXAhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 19:37:33 -0500
Received: from skora.net ([62.141.41.44]:3713 "EHLO skora.net")
	by vger.kernel.org with ESMTP id S262298AbVCXAh2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 19:37:28 -0500
To: Roger Luethi <rl@hellgate.ch>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] via-rhine.c, wol-bugfix, Kernel 2.6.11.5
From: Thomas Skora <thomas@skora.net>
Date: Thu, 24 Mar 2005 01:37:55 +0100
Message-ID: <87psxp6fq4.fsf@powers.localnet>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hello!

The via-rhine driver in the actual kernel release 2.6.11.5 resets
wake-on-lan-settings of the chip. This leads to the fact, that wol is
disabled after the first reboot. I've attached a little patch, that
fixes the problem.

Thomas Skora


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=patch-via-wol
Content-Transfer-Encoding: base64

LS0tIGxpbnV4LTIuNi4xMS41L2RyaXZlcnMvbmV0L3ZpYS1yaGluZS5jLm9yaWcJMjAwNS0wMy0y
NCAwMDo1NDoxNi4wMDAwMDAwMDAgKzAxMDAKKysrIGxpbnV4LTIuNi4xMS41L2RyaXZlcnMvbmV0
L3ZpYS1yaGluZS5jCTIwMDUtMDMtMjQgMDA6NTQ6MTYuMDAwMDAwMDAwICswMTAwCkBAIC01NDIs
NyArNTQyLDcgQEAgc3RhdGljIHZvaWQgcmhpbmVfcG93ZXJfaW5pdChzdHJ1Y3QgbmV0XwogCiAJ
aWYgKHJwLT5xdWlya3MgJiBycVdPTCkgewogCQkvKiBNYWtlIHN1cmUgY2hpcCBpcyBpbiBwb3dl
ciBzdGF0ZSBEMCAqLwotCQlpb3dyaXRlOChpb3JlYWQ4KGlvYWRkciArIFN0aWNreUhXKSAmIDB4
RkUsIGlvYWRkciArIFN0aWNreUhXKTsKKwkJaW93cml0ZTgoaW9yZWFkOChpb2FkZHIgKyBTdGlj
a3lIVykgJiAweEZDLCBpb2FkZHIgKyBTdGlja3lIVyk7CiAKIAkJLyogRGlzYWJsZSAiZm9yY2Ug
UE1FLWVuYWJsZSIgKi8KIAkJaW93cml0ZTgoMHg4MCwgaW9hZGRyICsgV09MY2dDbHIpOwo=
--=-=-=--
