Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262563AbREVEYt>; Tue, 22 May 2001 00:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262564AbREVEYj>; Tue, 22 May 2001 00:24:39 -0400
Received: from h24-69-31-7.gv.shawcable.net ([24.69.31.7]:63502 "HELO
	bodnar42.dhs.org") by vger.kernel.org with SMTP id <S262563AbREVEYc>;
	Tue, 22 May 2001 00:24:32 -0400
Content-Type: Multipart/Mixed;
  charset="iso-8859-1";
  boundary="------------Boundary-00=_KWYPIP7EUG9D5S1232HA"
From: Me <bodnar42@bodnar42.dhs.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] include/linux/coda.h
Date: Mon, 21 May 2001 21:24:20 -0700
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01052121242000.31459@bodnar42.dhs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_KWYPIP7EUG9D5S1232HA
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

 Coda.h assumes that __KERNEL__ can only be defined if __linux__ is, which is 
painfully false. This allows the kernel compile to get farther on my token 
FreeBSD box.

-Ryan
--------------Boundary-00=_KWYPIP7EUG9D5S1232HA
Content-Type: text/x-c;
  charset="iso-8859-1";
  name="crosscompile.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="crosscompile.diff"

LS0tIGxpbnV4L2luY2x1ZGUvbGludXgvY29kYS5oCVdlZCBBcHIgMjUgMTY6MTg6NTQgMjAwMQor
KysgbGludXgvaW5jbHVkZS9saW51eC9jb2RhLmgJTW9uIE1heSAyMSAyMToxOToyMSAyMDAxCkBA
IC0xMDAsNiArMTAwLDEwIEBACiAKICNpZiBkZWZpbmVkKF9fbGludXhfXykKICNkZWZpbmUgY2Rl
dl90IHVfcXVhZF90CisjZWxzZQorI2RlZmluZSBjZGV2X3QgZGV2X3QKKyNlbmRpZgorCiAjaWZu
ZGVmIF9fS0VSTkVMX18KICNpZiAhZGVmaW5lZChfVVFVQURfVF8pICYmICghZGVmaW5lZChfX0dM
SUJDX18pIHx8IF9fR0xJQkNfXyA8IDIpCiAjZGVmaW5lIF9VUVVBRF9UXyAxCkBAIC0xMDgsOSAr
MTEyLDYgQEAKICNlbHNlIC8qX19LRVJORUxfXyAqLwogdHlwZWRlZiB1bnNpZ25lZCBsb25nIGxv
bmcgdV9xdWFkX3Q7CiAjZW5kaWYgLyogX19LRVJORUxfXyAqLwotI2Vsc2UKLSNkZWZpbmUgY2Rl
dl90IGRldl90Ci0jZW5kaWYKIAogI2lmZGVmIF9fQ1lHV0lOMzJfXwogc3RydWN0IHRpbWVzcGVj
IHsK

--------------Boundary-00=_KWYPIP7EUG9D5S1232HA--
