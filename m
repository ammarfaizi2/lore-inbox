Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbUCDSE5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 13:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbUCDSE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 13:04:57 -0500
Received: from 18-165-237-24-mvl.nwc.gci.net ([24.237.165.18]:42168 "EHLO
	nevaeh-linux.org") by vger.kernel.org with ESMTP id S262031AbUCDSEy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 13:04:54 -0500
Date: Thu, 4 Mar 2004 09:04:50 -0900 (AKST)
From: Arthur Corliss <corliss@digitalmages.com>
X-X-Sender: acorliss@bifrost.nevaeh-linux.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] 2.6.x BSD Process Accounting w/High UID
Message-ID: <Pine.LNX.4.58.0403040901010.30814@bifrost.nevaeh-linux.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-317189467-389641434-1078423490=:30814"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---317189467-389641434-1078423490=:30814
Content-Type: TEXT/PLAIN; charset=US-ASCII

Greetings:

The patch only changes two lines which redefine the ac_uid/ac_gid fields as
uid_t/gid_t respectively.  Fixes accounting for high uid/gids.

	--Arthur Corliss
	  Bolverk's Lair -- http://arthur.corlissfamily.org/
	  Digital Mages -- http://www.digitalmages.com/
	  "Live Free or Die, the Only Way to Live" -- NH State Motto
---317189467-389641434-1078423490=:30814
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="highuid-acct.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0403040904500.30814@bifrost.nevaeh-linux.org>
Content-Description: 
Content-Disposition: attachment; filename="highuid-acct.patch"

LS0tIGxpbnV4LTIuNi4zL2luY2x1ZGUvbGludXgvYWNjdC5oICAgIDIwMDQt
MDItMTcgMTg6NTc6MTguMDAwMDAwMDAwIC0wOTAwDQorKysgbGludXgvaW5j
bHVkZS9saW51eC9hY2N0LmggIDIwMDQtMDMtMDQgMDg6NDc6NDguMDAwMDAw
MDAwIC0wOTAwDQpAQCAtNDEsOCArNDEsOCBAQA0KICAqICAgICBObyBiaW5h
cnkgZm9ybWF0IGJyZWFrIHdpdGggMi4wIC0gYnV0IHdoZW4gd2UgaGl0IDMy
Yml0IHVpZCB3ZSdsbA0KICAqICAgICBoYXZlIHRvIGJpdGUgb25lDQogICov
DQotICAgICAgIF9fdTE2ICAgICAgICAgICBhY191aWQ7ICAgICAgICAgICAg
ICAgICAvKiBBY2NvdW50aW5nIFJlYWwgVXNlciBJRCAqLw0KLSAgICAgICBf
X3UxNiAgICAgICAgICAgYWNfZ2lkOyAgICAgICAgICAgICAgICAgLyogQWNj
b3VudGluZyBSZWFsIEdyb3VwIElEICovDQorICAgICAgIHVpZF90ICAgICAg
ICAgICBhY191aWQ7ICAgICAgICAgICAgICAgICAvKiBBY2NvdW50aW5nIFJl
YWwgVXNlciBJRCAqLw0KKyAgICAgICBnaWRfdCAgICAgICAgICAgYWNfZ2lk
OyAgICAgICAgICAgICAgICAgLyogQWNjb3VudGluZyBSZWFsIEdyb3VwIElE
ICovDQogICAgICAgIF9fdTE2ICAgICAgICAgICBhY190dHk7ICAgICAgICAg
ICAgICAgICAvKiBBY2NvdW50aW5nIENvbnRyb2wgVGVybWluYWwgKi8NCiAg
ICAgICAgX191MzIgICAgICAgICAgIGFjX2J0aW1lOyAgICAgICAgICAgICAg
IC8qIEFjY291bnRpbmcgUHJvY2VzcyBDcmVhdGlvbiBUaW1lICovDQogICAg
ICAgIGNvbXBfdCAgICAgICAgICBhY191dGltZTsgICAgICAgICAgICAgICAv
KiBBY2NvdW50aW5nIFVzZXIgVGltZSAqLw0K

---317189467-389641434-1078423490=:30814--
