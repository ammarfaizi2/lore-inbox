Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129083AbQJ1Jao>; Sat, 28 Oct 2000 05:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129092AbQJ1Jaf>; Sat, 28 Oct 2000 05:30:35 -0400
Received: from cus.org.uk ([212.1.130.85]:59398 "EHLO moo.cus.org.uk")
	by vger.kernel.org with ESMTP id <S129083AbQJ1Jab>;
	Sat, 28 Oct 2000 05:30:31 -0400
Date: Sat, 28 Oct 2000 10:29:55 +0100 (BST)
From: Riley Williams <rhw@moo.cus.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Obviously-correct patch to 2.2.17
Message-ID: <Pine.LNX.4.21.0010281028310.11719-200000@moo.cus.org.uk>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="30692738-7395909-972725395=:11719"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--30692738-7395909-972725395=:11719
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi Alan.

This patch simply corrects a couple of comments in the said file to
reflect what the code actually does rather than (presumably) what the
code used to do at some time in the distant past.

In my case, I've been working on a patch for the kernel that uses
these facilities, and was getting confused because of the discrepancy
between what the comments say and what actually happens. It wasn't
until I realised that the comments were just plain wrong that I was
able to sort the thing out, so I'm submitting this patch to prevent
others having the same problem.

Incidentally, the code as it stands actually simplifies the patch I
was working on considerably, and I regard this as a useful feature as
a result.

I don't have the latest 2.4-pre kernel to hand to check, but it's
quite likely that this patch can also be applied to that with the same
results.

Best wishes from Riley.

 * Copyright (C) 2000, Memory Alpha Systems.
 * All rights and wrongs reserved.

+----------------------------------------------------------------------+
| There is something frustrating about the quality and speed of Linux  |
| development, ie., the quality is too high and the speed is too high, |
| in other words, I can implement this XXXX feature, but I bet someone |
| else has already done so and is just about to release their patch.   |
+----------------------------------------------------------------------+
 * http://www.memalpha.cx/Linux/Kernel/

--30692738-7395909-972725395=:11719
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="printk.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0010281029550.11719@moo.cus.org.uk>
Content-Description: Patch to kernel/printk.c
Content-Disposition: attachment; filename="printk.diff"

LS0tIGxpbnV4LTIuMi4xNy9rZXJuZWwvcHJpbnRrLmN+CVdlZCBPY3QgMjcg
MDE6NTM6NDIgMTk5OQ0KKysrIGxpbnV4LTIuMi4xNy9rZXJuZWwvcHJpbnRr
LmMJU2F0IE9jdCAyOCAxMDowMToyMCAyMDAwDQpAQCAtMTA5LDEyICsxMDks
MTIgQEANCiAgKiBDb21tYW5kcyB0byBkb19zeXNsb2c6DQogICoNCiAgKiAJ
MCAtLSBDbG9zZSB0aGUgbG9nLiAgQ3VycmVudGx5IGEgTk9QLg0KICAqIAkx
IC0tIE9wZW4gdGhlIGxvZy4gQ3VycmVudGx5IGEgTk9QLg0KICAqIAkyIC0t
IFJlYWQgZnJvbSB0aGUgbG9nLg0KLSAqIAkzIC0tIFJlYWQgdXAgdG8gdGhl
IGxhc3QgNGsgb2YgbWVzc2FnZXMgaW4gdGhlIHJpbmcgYnVmZmVyLg0KKyAq
IAkzIC0tIFJlYWQgYWxsIG1lc3NhZ2VzIHJlbWFpbmluZyBpbiB0aGUgcmlu
ZyBidWZmZXIuDQotICogCTQgLS0gUmVhZCBhbmQgY2xlYXIgbGFzdCA0ayBv
ZiBtZXNzYWdlcyBpbiB0aGUgcmluZyBidWZmZXINCisgKiAJNCAtLSBSZWFk
IGFuZCBjbGVhciBhbGwgbWVzc2FnZXMgcmVtYWluaW5nIGluIHRoZSByaW5n
IGJ1ZmZlcg0KICAqIAk1IC0tIENsZWFyIHJpbmcgYnVmZmVyLg0KICAqIAk2
IC0tIERpc2FibGUgcHJpbnRrJ3MgdG8gY29uc29sZQ0KICAqIAk3IC0tIEVu
YWJsZSBwcmludGsncyB0byBjb25zb2xlDQogICoJOCAtLSBTZXQgbGV2ZWwg
b2YgbWVzc2FnZXMgcHJpbnRlZCB0byBjb25zb2xlDQogICovDQo=
--30692738-7395909-972725395=:11719--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
