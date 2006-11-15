Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030906AbWKOTMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030906AbWKOTMI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 14:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030907AbWKOTMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 14:12:08 -0500
Received: from bay0-omc1-s25.bay0.hotmail.com ([65.54.246.97]:9279 "EHLO
	bay0-omc1-s25.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1030906AbWKOTMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 14:12:05 -0500
Message-ID: <BAY20-F4FAF4F4D4B7056942ECBCD8EA0@phx.gbl>
X-Originating-IP: [80.178.1.111]
X-Originating-Email: [yan_952@hotmail.com]
From: "Burman Yan" <yan_952@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org, rgooch@atnf.csiro.au
Subject: [PATCH 2.6.19-rc5] mtrr: replace kmalloc+memset with kzalloc
Date: Wed, 15 Nov 2006 21:11:59 +0200
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_6c05_2acb_36fd"
X-OriginalArrivalTime: 15 Nov 2006 19:12:04.0784 (UTC) FILETIME=[EFDABB00:01C708E9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_6c05_2acb_36fd
Content-Type: text/plain; format=flowed

Hi.

This patch replaces kmalloc+memset with kzalloc in mtrr related files

Regards
Yan Burman

_________________________________________________________________
FREE pop-up blocking with the new MSN Toolbar - get it now! 
http://toolbar.msn.click-url.com/go/onm00200415ave/direct/01/

------=_NextPart_000_6c05_2acb_36fd
Content-Type: application/octet-stream; name="kzalloc_mtrr.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="kzalloc_mtrr.patch"

UmVwbGFjZSBrbWFsbG9jK21lbXNldCB3aXRoIGt6YWxsb2MgCgpTaWduZWQt
b2ZmLWJ5OiBZYW4gQnVybWFuIDx5YW5fOTUyQGhvdG1haWwuY29tPgoKZGlm
ZiAtcnVicCBsaW51eC0yLjYuMTktcmM1X29yaWcvYXJjaC9pMzg2L2tlcm5l
bC9jcHUvbXRyci9pZi5jIGxpbnV4LTIuNi4xOS1yYzVfa3phbGxvYy9hcmNo
L2kzODYva2VybmVsL2NwdS9tdHJyL2lmLmMKLS0tIGxpbnV4LTIuNi4xOS1y
YzVfb3JpZy9hcmNoL2kzODYva2VybmVsL2NwdS9tdHJyL2lmLmMJMjAwNi0x
MS0wOSAxMjoxNjoyMS4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi4x
OS1yYzVfa3phbGxvYy9hcmNoL2kzODYva2VybmVsL2NwdS9tdHJyL2lmLmMJ
MjAwNi0xMS0xMSAyMjo0NDowNC4wMDAwMDAwMDAgKzAyMDAKQEAgLTQ0LDEw
ICs0NCw5IEBAIG10cnJfZmlsZV9hZGQodW5zaWduZWQgbG9uZyBiYXNlLCB1
bnNpZ24KIAogCW1heCA9IG51bV92YXJfcmFuZ2VzOwogCWlmIChmY291bnQg
PT0gTlVMTCkgewotCQlmY291bnQgPSBrbWFsbG9jKG1heCAqIHNpemVvZiAq
ZmNvdW50LCBHRlBfS0VSTkVMKTsKKwkJZmNvdW50ID0ga3phbGxvYyhtYXgg
KiBzaXplb2YgKmZjb3VudCwgR0ZQX0tFUk5FTCk7CiAJCWlmICghZmNvdW50
KQogCQkJcmV0dXJuIC1FTk9NRU07Ci0JCW1lbXNldChmY291bnQsIDAsIG1h
eCAqIHNpemVvZiAqZmNvdW50KTsKIAkJRklMRV9GQ09VTlQoZmlsZSkgPSBm
Y291bnQ7CiAJfQogCWlmICghcGFnZSkgewpkaWZmIC1ydWJwIGxpbnV4LTIu
Ni4xOS1yYzVfb3JpZy9hcmNoL2kzODYva2VybmVsL2NwdS9tdHJyL21haW4u
YyBsaW51eC0yLjYuMTktcmM1X2t6YWxsb2MvYXJjaC9pMzg2L2tlcm5lbC9j
cHUvbXRyci9tYWluLmMKLS0tIGxpbnV4LTIuNi4xOS1yYzVfb3JpZy9hcmNo
L2kzODYva2VybmVsL2NwdS9tdHJyL21haW4uYwkyMDA2LTExLTA5IDEyOjE2
OjIxLjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42LjE5LXJjNV9remFs
bG9jL2FyY2gvaTM4Ni9rZXJuZWwvY3B1L210cnIvbWFpbi5jCTIwMDYtMTEt
MTEgMjI6NDQ6MDQuMDAwMDAwMDAwICswMjAwCkBAIC01NjUsMTAgKzU2NSw4
IEBAIHN0YXRpYyBpbnQgbXRycl9zYXZlKHN0cnVjdCBzeXNfZGV2aWNlICoK
IAlpbnQgaTsKIAlpbnQgc2l6ZSA9IG51bV92YXJfcmFuZ2VzICogc2l6ZW9m
KHN0cnVjdCBtdHJyX3ZhbHVlKTsKIAotCW10cnJfc3RhdGUgPSBrbWFsbG9j
KHNpemUsR0ZQX0FUT01JQyk7Ci0JaWYgKG10cnJfc3RhdGUpCi0JCW1lbXNl
dChtdHJyX3N0YXRlLDAsc2l6ZSk7Ci0JZWxzZQorCW10cnJfc3RhdGUgPSBr
emFsbG9jKHNpemUsR0ZQX0FUT01JQyk7CisJaWYgKCFtdHJyX3N0YXRlKQog
CQlyZXR1cm4gLUVOT01FTTsKIAogCWZvciAoaSA9IDA7IGkgPCBudW1fdmFy
X3JhbmdlczsgaSsrKSB7Cgo=


------=_NextPart_000_6c05_2acb_36fd--
