Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265106AbUGIRMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265106AbUGIRMN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 13:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265110AbUGIRMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 13:12:13 -0400
Received: from scooter.csds.uidaho.edu ([129.101.154.80]:18563 "EHLO
	scooter.csds.uidaho.edu") by vger.kernel.org with ESMTP
	id S265106AbUGIRML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 13:12:11 -0400
Date: Fri, 9 Jul 2004 10:12:12 -0700 (PDT)
From: Thomas DuBuisson <tomd@csds.uidaho.edu>
To: linux-kernel@vger.kernel.org
Subject: [Crypto] twofish-flag.patch
Message-ID: <Pine.LNX.4.53.0407091006040.11273@scooter.csds.uidaho.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1702973594-1353081069-1089393132=:11273"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1702973594-1353081069-1089393132=:11273
Content-Type: TEXT/PLAIN; charset=US-ASCII

Unless there is a good reason for the flag handling to be different in 
twofish than in AES or Serpent I think this needs applied.  It just sets 
the proper flag if someone tries to run twofish_setkey with an improper 
key size.

Thomas DuBuisson
--1702973594-1353081069-1089393132=:11273
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="twofish_flag.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.53.0407091012120.11273@scooter.csds.uidaho.edu>
Content-Description: 
Content-Disposition: attachment; filename="twofish_flag.patch"

LS0tIGxpbnV4LTIuNi43L2NyeXB0by90d29maXNoLmMub3JpZwkyMDA0LTA2
LTE1IDIyOjIwOjI2LjAwMDAwMDAwMCAtMDcwMA0KKysrIGxpbnV4LTIuNi43
L2NyeXB0by90d29maXNoLmMJMjAwNC0wNy0wOCAxMTowMzowMi4wMDAwMDAw
MDAgLTA3MDANCkBAIC02NjMsNyArNjYzLDEwIEBAIHN0YXRpYyBpbnQgdHdv
ZmlzaF9zZXRrZXkodm9pZCAqY3gsIGNvbnMNCiANCiAJLyogQ2hlY2sga2V5
IGxlbmd0aC4gKi8NCiAJaWYgKGtleV9sZW4gIT0gMTYgJiYga2V5X2xlbiAh
PSAyNCAmJiBrZXlfbGVuICE9IDMyKQ0KKwl7DQorCQkqZmxhZ3MgfD0gQ1JZ
UFRPX1RGTV9SRVNfQkFEX0tFWV9MRU47DQogCQlyZXR1cm4gLUVJTlZBTDsg
LyogdW5zdXBwb3J0ZWQga2V5IGxlbmd0aCAqLw0KKwl9DQogDQogCS8qIENv
bXB1dGUgdGhlIGZpcnN0IHR3byB3b3JkcyBvZiB0aGUgUyB2ZWN0b3IuICBU
aGUgbWFnaWMgbnVtYmVycyBhcmUNCiAJICogdGhlIGVudHJpZXMgb2YgdGhl
IFJTIG1hdHJpeCwgcHJlcHJvY2Vzc2VkIHRocm91Z2ggcG9seV90b19leHAu
IFRoZQ0K

--1702973594-1353081069-1089393132=:11273--
