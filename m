Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261523AbVBADce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbVBADce (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 22:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbVBADam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 22:30:42 -0500
Received: from [195.23.16.24] ([195.23.16.24]:23947 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261520AbVBADaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 22:30:20 -0500
Message-ID: <1107228505.41fef759ae43d@webmail.grupopie.com>
Date: Tue,  1 Feb 2005 03:28:25 +0000
From: "" <pmarques@grupopie.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "" <linux-kernel@vger.kernel.org>, "" <dm-devel@redhat.com>
Subject: [PATCH 2.6] 2/7 use kstrdup library function in dm-ioctl.c
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-MOQ110722850542fccf1651d8b2b4fbe40c1c1a4a0b17"
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 82.154.143.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format.

---MOQ110722850542fccf1651d8b2b4fbe40c1c1a4a0b17
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable


This patch removes a private strdup in dm-ioctl.c, and updates it to use =
the
kstrdup library function.

Signed-off-by: Paulo Marques <pmarques@grupopie.com>

--
Paulo Marques - www.grupopie.com
=20
All that is necessary for the triumph of evil is that good men do nothing=
.
Edmund Burke (1729 - 1797)

---MOQ110722850542fccf1651d8b2b4fbe40c1c1a4a0b17
Content-Type: text/x-diff; name="patch2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patch2"

LS0tIGxpbnV4LTIuNi4xMC9kcml2ZXJzL21kL2RtLWlvY3RsLmMub3JpZwkyMDA1LTAxLTMxIDE5
OjMzOjI2LjYzMTAzOTk2NyArMDAwMAorKysgbGludXgtMi42LjEwL2RyaXZlcnMvbWQvZG0taW9j
dGwuYwkyMDA1LTAxLTMxIDE5OjM0OjA4LjQ4ODc4NDE4MiArMDAwMApAQCAtMTIyLDE0ICsxMjIs
NiBAQCBzdGF0aWMgc3RydWN0IGhhc2hfY2VsbCAqX19nZXRfdXVpZF9jZWxsCiAvKi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
CiAgKiBJbnNlcnRpbmcsIHJlbW92aW5nIGFuZCByZW5hbWluZyBhIGRldmljZS4KICAqLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
Ki8KLXN0YXRpYyBpbmxpbmUgY2hhciAqa3N0cmR1cChjb25zdCBjaGFyICpzdHIpCi17Ci0JY2hh
ciAqciA9IGttYWxsb2Moc3RybGVuKHN0cikgKyAxLCBHRlBfS0VSTkVMKTsKLQlpZiAocikKLQkJ
c3RyY3B5KHIsIHN0cik7Ci0JcmV0dXJuIHI7Ci19Ci0KIHN0YXRpYyBzdHJ1Y3QgaGFzaF9jZWxs
ICphbGxvY19jZWxsKGNvbnN0IGNoYXIgKm5hbWUsIGNvbnN0IGNoYXIgKnV1aWQsCiAJCQkJICAg
IHN0cnVjdCBtYXBwZWRfZGV2aWNlICptZCkKIHsKQEAgLTEzOSw3ICsxMzEsNyBAQCBzdGF0aWMg
c3RydWN0IGhhc2hfY2VsbCAqYWxsb2NfY2VsbChjb25zCiAJaWYgKCFoYykKIAkJcmV0dXJuIE5V
TEw7CiAKLQloYy0+bmFtZSA9IGtzdHJkdXAobmFtZSk7CisJaGMtPm5hbWUgPSBrc3RyZHVwKG5h
bWUsIEdGUF9LRVJORUwpOwogCWlmICghaGMtPm5hbWUpIHsKIAkJa2ZyZWUoaGMpOwogCQlyZXR1
cm4gTlVMTDsKQEAgLTE0OSw3ICsxNDEsNyBAQCBzdGF0aWMgc3RydWN0IGhhc2hfY2VsbCAqYWxs
b2NfY2VsbChjb25zCiAJCWhjLT51dWlkID0gTlVMTDsKIAogCWVsc2UgewotCQloYy0+dXVpZCA9
IGtzdHJkdXAodXVpZCk7CisJCWhjLT51dWlkID0ga3N0cmR1cCh1dWlkLCBHRlBfS0VSTkVMKTsK
IAkJaWYgKCFoYy0+dXVpZCkgewogCQkJa2ZyZWUoaGMtPm5hbWUpOwogCQkJa2ZyZWUoaGMpOwpA
QCAtMjczLDcgKzI2NSw3IEBAIHN0YXRpYyBpbnQgZG1faGFzaF9yZW5hbWUoY29uc3QgY2hhciAq
b2wKIAkvKgogCSAqIGR1cGxpY2F0ZSBuZXcuCiAJICovCi0JbmV3X25hbWUgPSBrc3RyZHVwKG5l
dyk7CisJbmV3X25hbWUgPSBrc3RyZHVwKG5ldywgR0ZQX0tFUk5FTCk7CiAJaWYgKCFuZXdfbmFt
ZSkKIAkJcmV0dXJuIC1FTk9NRU07CiAK

---MOQ110722850542fccf1651d8b2b4fbe40c1c1a4a0b17--
