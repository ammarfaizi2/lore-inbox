Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280932AbRKOQna>; Thu, 15 Nov 2001 11:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280934AbRKOQnL>; Thu, 15 Nov 2001 11:43:11 -0500
Received: from jdi.jdimedia.nl ([212.204.192.51]:20649 "EHLO jdi.jdimedia.nl")
	by vger.kernel.org with ESMTP id <S280932AbRKOQnJ>;
	Thu, 15 Nov 2001 11:43:09 -0500
Date: Thu, 15 Nov 2001 17:41:52 +0100 (CET)
From: Igmar Palsenberg <i.palsenberg@jdimedia.nl>
X-X-Sender: <igmar@jdi.jdimedia.nl>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] broken ISDN chargehup
Message-ID: <Pine.LNX.4.33.0111151709060.23131-200000@jdi.jdimedia.nl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-858508352-1638626567-1005841161=:23131"
Content-ID: <Pine.LNX.4.33.0111151739580.23131@jdi.jdimedia.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---858508352-1638626567-1005841161=:23131
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.33.0111151739581.23131@jdi.jdimedia.nl>


Hi,

Applied patch fixes 2 problems :

- If chargeint was > 10, chargehup was activated
- If chargehup was activated, the next call to isdn_net_autohup()
  terminated the link

Both changes makes IPPP idle hangups functional again.



	Regards,


		Igmar


-- 

Igmar Palsenberg
JDI Media Solutions

Boulevard Heuvelink 102
6828 KT Arnhem
The Netherlands

mailto: i.palsenberg@jdimedia.nl
PGP/GPG key : http://www.jdimedia.nl/formulier/pgp/igmar

---858508352-1638626567-1005841161=:23131
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="linux-2.4.14-chargehup.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0111151719210.23131@jdi.jdimedia.nl>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="linux-2.4.14-chargehup.patch"

LS0tIGxpbnV4LTIuNC4xNC9kcml2ZXJzL2lzZG4vaXNkbl9uZXQuYy5vcmln
CVRodSBOb3YgMTUgMTU6MjE6NDkgMjAwMQ0KKysrIGxpbnV4LTIuNC4xNC9k
cml2ZXJzL2lzZG4vaXNkbl9uZXQuYwlUaHUgTm92IDE1IDE3OjAwOjQwIDIw
MDENCkBAIC0zNjksOCArMzY5LDYgQEANCiAJCQkJCQkJICAgICAgIGwtPm5h
bWUsIGwtPmNoYXJnZXRpbWUsIGwtPmNoYXJnZWludCk7DQogCQkJCQkJCWlz
ZG5fbmV0X2hhbmd1cCgmcC0+ZGV2KTsNCiAJCQkJCQl9DQotCQkJCQl9IGVs
c2UNCi0JCQkJCQlpc2RuX25ldF9oYW5ndXAoJnAtPmRldik7DQogCQkJCX0g
ZWxzZSBpZiAobC0+aHVwZmxhZ3MgJiBJU0ROX0lOSFVQKQ0KIAkJCQkJaXNk
bl9uZXRfaGFuZ3VwKCZwLT5kZXYpOw0KIAkJCX0NCkBAIC0yODcyLDcgKzI4
NzAsNyBAQA0KIAkJZWxzZQ0KIAkJCWxwLT5odXBmbGFncyAmPSB+SVNETl9J
TkhVUDsNCiAJCWlmIChjZmctPmNoYXJnZWludCA+IDEwKSB7DQotCQkJbHAt
Pmh1cGZsYWdzIHw9IElTRE5fQ0hBUkdFSFVQIHwgSVNETl9IQVZFQ0hBUkdF
IHwgSVNETl9NQU5DSEFSR0U7DQorCQkJbHAtPmh1cGZsYWdzIHw9IElTRE5f
SEFWRUNIQVJHRSB8IElTRE5fTUFOQ0hBUkdFOw0KIAkJCWxwLT5jaGFyZ2Vp
bnQgPSBjZmctPmNoYXJnZWludCAqIEhaOw0KIAkJfQ0KIAkJaWYgKGNmZy0+
cF9lbmNhcCAhPSBscC0+cF9lbmNhcCkgew0K
---858508352-1638626567-1005841161=:23131--
