Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263921AbTFYFBe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 01:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263944AbTFYFBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 01:01:34 -0400
Received: from user-vc8fdp3.biz.mindspring.com ([216.135.183.35]:31756 "EHLO
	mail.nateng.com") by vger.kernel.org with ESMTP id S263921AbTFYFBd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 01:01:33 -0400
X-RAV-AntiVirus: This e-mail has been scanned for viruses on host: mail.nateng.com
Date: Tue, 24 Jun 2003 22:14:58 -0700 (PDT)
From: Sir Ace <chandler@nateng.com>
X-X-Sender: chandler@jordan.eng.nateng.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH] bttv update for max cards
Message-ID: <Pine.LNX.4.53.0306242213220.596@jordan.eng.nateng.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="279758948-122686434-1056518098=:596"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--279758948-122686434-1056518098=:596
Content-Type: TEXT/PLAIN; charset=US-ASCII


For us unluck people who have many slots in our PCI backplane, and
actually are required to fill them with these cards, it sucks to have a
kernel limit of 4 cards.

This patch doubles the number to 8, which is still low for an IPC chassis,
but it is much better than 4.

  -- Sir Ace
--279758948-122686434-1056518098=:596
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="patch-2.4.21-bttv_card_num"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.53.0306242214580.596@jordan.eng.nateng.com>
Content-Description: 
Content-Disposition: attachment; filename="patch-2.4.21-bttv_card_num"

ZGlmZiAtLXVuaWZpZWQgLS1yZWN1cnNpdmUgLS1uZXctZmlsZSBsaW51eC0y
LjQuMjEvZHJpdmVycy9tZWRpYS92aWRlby9idHR2cC5oIGxpbnV4L2RyaXZl
cnMvbWVkaWEvdmlkZW8vYnR0dnAuaA0KLS0tIGxpbnV4LTIuNC4yMS9kcml2
ZXJzL21lZGlhL3ZpZGVvL2J0dHZwLmgJMjAwMy0wNi0xMyAwNzo1MTozNC4w
MDAwMDAwMDAgLTA3MDANCisrKyBsaW51eC9kcml2ZXJzL21lZGlhL3ZpZGVv
L2J0dHZwLmgJMjAwMy0wNi0yNSAxMzoxMDowOS4wMDAwMDAwMDAgLTA3MDAN
CkBAIC01NCw3ICs1NCw3IEBADQogI2RlZmluZSB2cHJpbnRrCQlpZiAoYnR0
dl92ZXJib3NlKSBwcmludGsNCiANCiAvKiBBbnlib2R5IHdobyB1c2VzIG1v
cmUgdGhhbiBmb3VyPyAqLw0KLSNkZWZpbmUgQlRUVl9NQVggNA0KKyNkZWZp
bmUgQlRUVl9NQVggOA0KIGV4dGVybiB1bnNpZ25lZCBpbnQgYnR0dl9udW07
CQkJLyogbnVtYmVyIG9mIEJ0ODQ4cyBpbiB1c2UgKi8NCiBleHRlcm4gc3Ry
dWN0IGJ0dHYgYnR0dnNbQlRUVl9NQVhdOw0KIA0K

--279758948-122686434-1056518098=:596--
