Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbVBADlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbVBADlb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 22:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVBADcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 22:32:52 -0500
Received: from [195.23.16.24] ([195.23.16.24]:28811 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261524AbVBADaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 22:30:30 -0500
Message-ID: <1107228514.41fef7623df85@webmail.grupopie.com>
Date: Tue,  1 Feb 2005 03:28:34 +0000
From: "" <pmarques@grupopie.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6] 5/7 use kstrdup library function in net/sunrpc/svcauth_unix.c
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-MOQ11072285143080850994ae54ac67dac6025de02460"
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 82.154.143.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format.

---MOQ11072285143080850994ae54ac67dac6025de02460
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable


This patch removes a private strdup in net/sunrpc/svcauth_unix.c, and upd=
ates it
to use the kstrdup library function.

Signed-off-by: Paulo Marques <pmarques@grupopie.com>

--
Paulo Marques - www.grupopie.com
=20
All that is necessary for the triumph of evil is that good men do nothing=
.
Edmund Burke (1729 - 1797)

---MOQ11072285143080850994ae54ac67dac6025de02460
Content-Type: text/x-diff; name="patch5"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patch5"

LS0tIHZhbmlsbGEtMi42LjExLXJjMi1iazkvbmV0L3N1bnJwYy9zdmNhdXRoX3VuaXguYwkyMDA1
LTAxLTMxIDIwOjA1OjM0LjAwMDAwMDAwMCArMDAwMAorKysgbGludXgtMi42LjExLXJjMi1iazkv
bmV0L3N1bnJwYy9zdmNhdXRoX3VuaXguYwkyMDA1LTAxLTMxIDIwOjM2OjI4LjUzNjQwMDc5MSAr
MDAwMApAQCAtOCw2ICs4LDcgQEAKICNpbmNsdWRlIDxsaW51eC9lcnIuaD4KICNpbmNsdWRlIDxs
aW51eC9zZXFfZmlsZS5oPgogI2luY2x1ZGUgPGxpbnV4L2hhc2guaD4KKyNpbmNsdWRlIDxsaW51
eC9zdHJpbmcuaD4KIAogI2RlZmluZSBSUENEQkdfRkFDSUxJVFkJUlBDREJHX0FVVEgKIApAQCAt
MjAsMTQgKzIxLDYgQEAKICAqLwogCiAKLXN0YXRpYyBjaGFyICpzdHJkdXAoY2hhciAqcykKLXsK
LQljaGFyICpydiA9IGttYWxsb2Moc3RybGVuKHMpKzEsIEdGUF9LRVJORUwpOwotCWlmIChydikK
LQkJc3RyY3B5KHJ2LCBzKTsKLQlyZXR1cm4gcnY7Ci19Ci0KIHN0cnVjdCB1bml4X2RvbWFpbiB7
CiAJc3RydWN0IGF1dGhfZG9tYWluCWg7CiAJaW50CWFkZHJfY2hhbmdlczsKQEAgLTU1LDcgKzQ4
LDcgQEAgc3RydWN0IGF1dGhfZG9tYWluICp1bml4X2RvbWFpbl9maW5kKGNoYQogCWlmIChuZXcg
PT0gTlVMTCkKIAkJcmV0dXJuIE5VTEw7CiAJY2FjaGVfaW5pdCgmbmV3LT5oLmgpOwotCW5ldy0+
aC5uYW1lID0gc3RyZHVwKG5hbWUpOworCW5ldy0+aC5uYW1lID0ga3N0cmR1cChuYW1lLCBHRlBf
S0VSTkVMKTsKIAluZXctPmguZmxhdm91ciA9IFJQQ19BVVRIX1VOSVg7CiAJbmV3LT5hZGRyX2No
YW5nZXMgPSAwOwogCW5ldy0+aC5oLmV4cGlyeV90aW1lID0gTkVWRVI7Cg==

---MOQ11072285143080850994ae54ac67dac6025de02460--
