Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282941AbRK0Usi>; Tue, 27 Nov 2001 15:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282945AbRK0Us3>; Tue, 27 Nov 2001 15:48:29 -0500
Received: from mail.gmx.de ([213.165.64.20]:62961 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S282941AbRK0UsJ>;
	Tue, 27 Nov 2001 15:48:09 -0500
From: Sebastian =?iso-8859-1?q?Dr=F6ge?= <sebastian.droege@gmx.de>
Reply-To: sebastian.droege@gmx.de
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre2 compile error in ide-scsi.o ide-scsi.c
Date: Tue, 27 Nov 2001 21:49:23 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Cc: torvalds@transmeta.com
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_BI8H1TTRVAEXF9TSA1TK"
Message-Id: <20011127204819Z282941-17408+21242@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_BI8H1TTRVAEXF9TSA1TK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

ok
I've corrected it myself I think
The patch is attached
Hopefully it doesn't break something :)
It's my first patch so please don't kill me
Bye

PS: sorry if/when you get this mail twice :(
My mail client is a bit confused today

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8A/xbvIHrJes3kVIRAoyxAJ4+XrCYXffS3P8zCmttT5WvkJ6w1QCdGpxK
nMof4o/n2VictCFrvZGRXeA=3D
=3D04xe
-----END PGP SIGNATURE-----

--------------Boundary-00=_BI8H1TTRVAEXF9TSA1TK
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patch"

LS0tIGxpbnV4L2RyaXZlcnMvc2NzaS9pZGUtc2NzaS5jCVR1ZSBOb3YgMjcgMjE6NDE6MzUgMjAw
MQorKysgbGludXgvZHJpdmVycy9zY3NpL2lkZS1zY3NpLmMub2xkCVR1ZSBOb3YgMjcgMjE6NDA6
MzggMjAwMQpAQCAtNzA3LDkgKzcwNyw5IEBACiAJCXByaW50ayAoImlkZS1zY3NpOiAlczogYnVp
bGRpbmcgRE1BIHRhYmxlLCAlZCBzZWdtZW50cywgJWRrQiB0b3RhbFxuIiwgZHJpdmUtPm5hbWUs
IHNlZ21lbnRzLCBwYy0+cmVxdWVzdF90cmFuc2ZlciA+PiAxMCk7CiAjZW5kaWYgLyogSURFU0NT
SV9ERUJVR19MT0cgKi8KIAkJd2hpbGUgKHNlZ21lbnRzLS0pIHsKLQkJCWJoLT5iaV9pb192ZWMt
PmJ2bF92ZWMtPmJ2X3BhZ2UgPSBzZy0+cGFnZTsKLQkJCWJoLT5iaV9pb192ZWMtPmJ2bF92ZWMt
PmJ2X2xlbiA9IHNnLT5sZW5ndGg7Ci0JCQliaC0+YmlfaW9fdmVjLT5idmxfdmVjLT5idl9vZmZz
ZXQgPSBzZy0+b2Zmc2V0OworCQkJYmgtPmJpX2lvX3ZlYy5idl9wYWdlID0gc2ctPnBhZ2U7CisJ
CQliaC0+YmlfaW9fdmVjLmJ2X2xlbiA9IHNnLT5sZW5ndGg7CisJCQliaC0+YmlfaW9fdmVjLmJ2
X29mZnNldCA9IHNnLT5vZmZzZXQ7CiAJCQliaCA9IGJoLT5iaV9uZXh0OwogCQkJc2crKzsKIAkJ
fQpAQCAtNzE5LDkgKzcxOSw5IEBACiAjaWYgSURFU0NTSV9ERUJVR19MT0cKIAkJcHJpbnRrICgi
aWRlLXNjc2k6ICVzOiBidWlsZGluZyBETUEgdGFibGUgZm9yIGEgc2luZ2xlIGJ1ZmZlciAoJWRr
QilcbiIsIGRyaXZlLT5uYW1lLCBwYy0+cmVxdWVzdF90cmFuc2ZlciA+PiAxMCk7CiAjZW5kaWYg
LyogSURFU0NTSV9ERUJVR19MT0cgKi8KLQkJYmgtPmJpX2lvX3ZlYy0+YnZsX3ZlYy0+YnZfcGFn
ZSA9IHZpcnRfdG9fcGFnZShwYy0+c2NzaV9jbWQtPnJlcXVlc3RfYnVmZmVyKTsKLQkJYmgtPmJp
X2lvX3ZlYy0+YnZsX3ZlYy0+YnZfbGVuID0gcGMtPnJlcXVlc3RfdHJhbnNmZXI7Ci0JCWJoLT5i
aV9pb192ZWMtPmJ2bF92ZWMtPmJ2X29mZnNldCA9ICh1bnNpZ25lZCBsb25nKSBwYy0+c2NzaV9j
bWQtPnJlcXVlc3RfYnVmZmVyICYgflBBR0VfTUFTSzsKKwkJYmgtPmJpX2lvX3ZlYy5idl9wYWdl
ID0gdmlydF90b19wYWdlKHBjLT5zY3NpX2NtZC0+cmVxdWVzdF9idWZmZXIpOworCQliaC0+Ymlf
aW9fdmVjLmJ2X2xlbiA9IHBjLT5yZXF1ZXN0X3RyYW5zZmVyOworCQliaC0+YmlfaW9fdmVjLmJ2
X29mZnNldCA9ICh1bnNpZ25lZCBsb25nKSBwYy0+c2NzaV9jbWQtPnJlcXVlc3RfYnVmZmVyICYg
flBBR0VfTUFTSzsKIAl9CiAJcmV0dXJuIGZpcnN0X2JoOwogfQo=

--------------Boundary-00=_BI8H1TTRVAEXF9TSA1TK--
