Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbUCDSM0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 13:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbUCDSM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 13:12:26 -0500
Received: from 18-165-237-24-mvl.nwc.gci.net ([24.237.165.18]:51384 "EHLO
	nevaeh-linux.org") by vger.kernel.org with ESMTP id S262056AbUCDSMY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 13:12:24 -0500
Date: Thu, 4 Mar 2004 09:12:21 -0900 (AKST)
From: Arthur Corliss <corliss@digitalmages.com>
X-X-Sender: acorliss@bifrost.nevaeh-linux.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH] 2.4.x BSD Process Accounting w/High UID
Message-ID: <Pine.LNX.4.58.0403040910150.872@bifrost.nevaeh-linux.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-317189467-1092686189-1078423941=:872"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---317189467-1092686189-1078423941=:872
Content-Type: TEXT/PLAIN; charset=US-ASCII

Greetings:

The patch only changes two lines of code  which redefine the
ac_uid/ac_gid fields as uid_t/gid_t respectively.  Fixes accounting for
high uid/gids.

	--Arthur Corliss
	  Bolverk's Lair -- http://arthur.corlissfamily.org/
	  Digital Mages -- http://www.digitalmages.com/
	  "Live Free or Die, the Only Way to Live" -- NH State Motto
---317189467-1092686189-1078423941=:872
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="2.4-highuid-acct.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0403040912210.872@bifrost.nevaeh-linux.org>
Content-Description: 
Content-Disposition: attachment; filename="2.4-highuid-acct.patch"

LS0tIGxpbnV4LTIuNC4yNS9pbmNsdWRlL2xpbnV4L2FjY3QuaCAgIDIwMDQt
MDMtMDQgMDc6NTA6NDkuMDAwMDAwMDAwIC0wOTAwDQorKysgbGludXgvaW5j
bHVkZS9saW51eC9hY2N0LmggIDIwMDQtMDMtMDQgMDk6MDc6MTguMDAwMDAw
MDAwIC0wOTAwDQpAQCAtMzgsMTEgKzM4LDEzIEBADQogew0KICAgICAgICBj
aGFyICAgICAgICAgICAgYWNfZmxhZzsgICAgICAgICAgICAgICAgLyogQWNj
b3VudGluZyBGbGFncyAqLw0KIC8qDQotICogICAgIE5vIGJpbmFyeSBmb3Jt
YXQgYnJlYWsgd2l0aCAyLjAgLSBidXQgd2hlbiB3ZSBoaXQgMzJiaXQgdWlk
IHdlJ2xsDQotICogICAgIGhhdmUgdG8gYml0ZSBvbmUNCisgKiAgICAgVGhl
IHB1cmUgbGludXggc291cmNlIGRlZmluZXMgdWlkX3QgJiBnaWRfdCBhcyB1
MzIgYnkgZGVmYXVsdA0KKyAqICAgICBvbiBtb3N0IHBsYXRmb3Jtcy4gIFRo
aXMgYnJlYWtzIGNvbXBhdGliaWxpdHkgd2l0aCBvbGRlciB1dGlsaXRpZXMN
CisgKiAgICAgYW5kIGFjY291bnQgZmlsZXMgY29tcGlsZWQgaXRoIGFjX3Vp
ZC9hY19naWQgYXMgX191MTYuICBVbmZvcnR1bmF0ZWx5LA0KKyAqICAgICB0
aGlzIGhhcyB0byBoYXBwZW4gaWYgeW91IGFjdHVhbGx5IHVzZSBoaWdoIHVp
ZC9naWRzLg0KICAqLw0KLSAgICAgICBfX3UxNiAgICAgICAgICAgYWNfdWlk
OyAgICAgICAgICAgICAgICAgLyogQWNjb3VudGluZyBSZWFsIFVzZXIgSUQg
Ki8NCi0gICAgICAgX191MTYgICAgICAgICAgIGFjX2dpZDsgICAgICAgICAg
ICAgICAgIC8qIEFjY291bnRpbmcgUmVhbCBHcm91cCBJRCAqLw0KKyAgICAg
ICB1aWRfdCAgICAgICAgICAgYWNfdWlkOyAgICAgICAgICAgICAgICAgLyog
QWNjb3VudGluZyBSZWFsIFVzZXIgSUQgKi8NCisgICAgICAgZ2lkX3QgICAg
ICAgICAgIGFjX2dpZDsgICAgICAgICAgICAgICAgIC8qIEFjY291bnRpbmcg
UmVhbCBHcm91cCBJRCAqLw0KICAgICAgICBfX3UxNiAgICAgICAgICAgYWNf
dHR5OyAgICAgICAgICAgICAgICAgLyogQWNjb3VudGluZyBDb250cm9sIFRl
cm1pbmFsICovDQogICAgICAgIF9fdTMyICAgICAgICAgICBhY19idGltZTsg
ICAgICAgICAgICAgICAvKiBBY2NvdW50aW5nIFByb2Nlc3MgQ3JlYXRpb24g
VGltZSAqLw0KICAgICAgICBjb21wX3QgICAgICAgICAgYWNfdXRpbWU7ICAg
ICAgICAgICAgICAgLyogQWNjb3VudGluZyBVc2VyIFRpbWUgKi8NCg==

---317189467-1092686189-1078423941=:872--
