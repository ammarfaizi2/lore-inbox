Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280848AbRKOOpF>; Thu, 15 Nov 2001 09:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280863AbRKOOoz>; Thu, 15 Nov 2001 09:44:55 -0500
Received: from jdi.jdimedia.nl ([212.204.192.51]:38312 "EHLO jdi.jdimedia.nl")
	by vger.kernel.org with ESMTP id <S280848AbRKOOop>;
	Thu, 15 Nov 2001 09:44:45 -0500
Date: Thu, 15 Nov 2001 15:43:28 +0100 (CET)
From: Igmar Palsenberg <i.palsenberg@jdimedia.nl>
X-X-Sender: <igmar@jdi.jdimedia.nl>
To: <linux-kernel@vger.kernel.org>
Subject: ISDN chargehup
Message-ID: <Pine.LNX.4.33.0111151531300.22458-200000@jdi.jdimedia.nl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-858508352-1178905614-1005835408=:22458"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---858508352-1178905614-1005835408=:22458
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hi,

ISDN chargehup control is broken :

[root@fw /root]# isdnctrl chargehup ippp0
Charge-Hangup for ippp0 is on
[root@fw /root]# isdnctrl chargehup ippp0 off
Charge-Hangup for ippp0 is off
[root@fw /root]# isdnctrl chargehup ippp0
Charge-Hangup for ippp0 is on

With fix applied :

[root@fw /root]# isdnctrl chargehup ippp0
Charge-Hangup for ippp0 is on
[root@fw /root]# isdnctrl chargehup ippp0 off
Charge-Hangup for ippp0 is off
[root@fw /root]# isdnctrl chargehup ippp0
Charge-Hangup for ippp0 is off


Fix is attached.



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

---858508352-1178905614-1005835408=:22458
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="linux-2.4.14-chargehup.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0111151543280.22458@jdi.jdimedia.nl>
Content-Description: 
Content-Disposition: attachment; filename="linux-2.4.14-chargehup.patch"

LS0tIGxpbnV4LTIuNC4xNC9kcml2ZXJzL2lzZG4vaXNkbl9uZXQuYy5vcmln
CVRodSBOb3YgMTUgMTU6MjE6NDkgMjAwMQ0KKysrIGxpbnV4LTIuNC4xNC9k
cml2ZXJzL2lzZG4vaXNkbl9uZXQuYwlUaHUgTm92IDE1IDE1OjIyOjEzIDIw
MDENCkBAIC0yODcyLDcgKzI4NzIsNyBAQA0KIAkJZWxzZQ0KIAkJCWxwLT5o
dXBmbGFncyAmPSB+SVNETl9JTkhVUDsNCiAJCWlmIChjZmctPmNoYXJnZWlu
dCA+IDEwKSB7DQotCQkJbHAtPmh1cGZsYWdzIHw9IElTRE5fQ0hBUkdFSFVQ
IHwgSVNETl9IQVZFQ0hBUkdFIHwgSVNETl9NQU5DSEFSR0U7DQorCQkJbHAt
Pmh1cGZsYWdzIHw9IElTRE5fSEFWRUNIQVJHRSB8IElTRE5fTUFOQ0hBUkdF
Ow0KIAkJCWxwLT5jaGFyZ2VpbnQgPSBjZmctPmNoYXJnZWludCAqIEhaOw0K
IAkJfQ0KIAkJaWYgKGNmZy0+cF9lbmNhcCAhPSBscC0+cF9lbmNhcCkgew0K

---858508352-1178905614-1005835408=:22458--
