Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280473AbRJaUOA>; Wed, 31 Oct 2001 15:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280480AbRJaUNp>; Wed, 31 Oct 2001 15:13:45 -0500
Received: from amc.isi.edu ([128.9.160.102]:9989 "EHLO amc.isi.edu")
	by vger.kernel.org with ESMTP id <S280479AbRJaUN0>;
	Wed, 31 Oct 2001 15:13:26 -0500
Date: Wed, 31 Oct 2001 12:13:58 -0800 (PST)
From: Yu-Shun Wang <yushunwa@isi.edu>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: (resend, forgot subject :-) ipip.c patch & questions
Message-ID: <20011031121232.G2335-200000@amc.isi.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="0-338746007-1004558811=:2335"
Content-ID: <20011031120703.Q2335@amc.isi.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--0-338746007-1004558811=:2335
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <20011031120703.B2335@amc.isi.edu>

Hi,
	Some questions about ipip.c in 2.4.*:

	The following commands don't work anymore:

	   % ip tunnel add mode ipip .... (without giving a name)
	     (assume this creates tunl5)
	   % ip tunnel change tunl5 ....
	   ! ioctl error !

	   This happened on ipip.c version 1.42 and 1.46. The attached
	   patch fixed it in 1.46. Please modify the patch as you
	   see fits since I am not very familar with kernel mod.

	The other question is, is iproute2 considered part of the
	core Linux commands like ifconfig, route, etc.? It'd
	seem kind of stange that it wasn't. Or is there any plan
	to integrate the functionality of "ip" command into the likes
	of ifconfig?

	Thanks,

	yushun.

____________________________________________________________________________
Yu-Shun Wang <yushunwa@isi.edu>               Information Sciences Institute
                                           University of Southern California

--0-338746007-1004558811=:2335
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="ipip.c.patch72"
Content-Transfer-Encoding: BASE64
Content-ID: <20011031120651.O2335@amc.isi.edu>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="ipip.c.patch72"

LS0tIGlwaXAuYy43LjItcGF0Y2hlZAlXZWQgT2N0IDMxIDEwOjA0OjQ2IDIw
MDENCisrKyBpcGlwLmMuNy4yCVdlZCBPY3QgMzEgMDk6NTk6NTkgMjAwMQ0K
QEAgLTI1Niw3ICsyNTYsNiBAQA0KIAkJaWYgKGk9PTEwMCkNCiAJCQlnb3Rv
IGZhaWxlZDsNCiAJCW1lbWNweShwYXJtcy0+bmFtZSwgZGV2LT5uYW1lLCBJ
Rk5BTVNJWik7DQotCQlzdHJjcHkobnQtPnBhcm1zLm5hbWUsIGRldi0+bmFt
ZSk7DQogCX0NCiAJaWYgKHJlZ2lzdGVyX25ldGRldmljZShkZXYpIDwgMCkN
CiAJCWdvdG8gZmFpbGVkOw0K
--0-338746007-1004558811=:2335--
