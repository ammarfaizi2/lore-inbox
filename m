Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266448AbRGCGuk>; Tue, 3 Jul 2001 02:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266449AbRGCGub>; Tue, 3 Jul 2001 02:50:31 -0400
Received: from wh58-709.st.Uni-Magdeburg.DE ([141.44.198.79]:8196 "HELO
	wh58-709.st.uni-magdeburg.de") by vger.kernel.org with SMTP
	id <S266448AbRGCGuX>; Tue, 3 Jul 2001 02:50:23 -0400
Date: Tue, 3 Jul 2001 08:50:32 +0200 (CEST)
From: Erik Meusel <erik@wh58-709.st.uni-magdeburg.de>
To: <linux-kernel@vger.kernel.org>
Subject: include/asm-i386/checksum.h
Message-ID: <Pine.LNX.4.33.0107030840070.15954-200000@wh58-709.st.uni-magdeburg.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="747458502-829697308-994143032=:15954"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--747458502-829697308-994143032=:15954
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,

compiling the new 2.4.5 kernel with GCC 3.0 came with several errors and
warnings. One of the most ugly warnings was:

include/asm/checksum.h: warning: multi-line string literals are deprecated

The diff to version 2.4.5 of it is attached.

Regards,
Erik Meusel

P.S.: would it be possible to patch the menuconfig in that way, that it
does look in the whole include-path for the <ncurses.h> and relating
files? they aren't in /usr/include/ in my system and I'm tired of patching
linux/scripts/lxdialog/Makefile all the time. :)

--747458502-829697308-994143032=:15954
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="checksum.h.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0107030850320.15954@wh58-709.st.uni-magdeburg.de>
Content-Description: 
Content-Disposition: attachment; filename="checksum.h.diff"

LS0tIGluY2x1ZGUvYXNtLWkzODYvY2hlY2tzdW0uaAlUdWUgRmViICAxIDA4
OjQxOjE0IDIwMDANCisrKyAvc2NyYXRjaC9iYWNrdXAvc3JjL2xpbnV4L2lu
Y2x1ZGUvYXNtL2NoZWNrc3VtLmgJVHVlIEp1bCAgMyAwODozNToyNyAyMDAx
DQpAQCAtNzIsMTggKzcyLDE4IEBADQotCV9fYXNtX18gX192b2xhdGlsZV9f
KCINCi0JICAgIG1vdmwgKCUxKSwgJTANCi0JICAgIHN1YmwgJDQsICUyDQot
CSAgICBqYmUgMmYNCi0JICAgIGFkZGwgNCglMSksICUwDQotCSAgICBhZGNs
IDgoJTEpLCAlMA0KLQkgICAgYWRjbCAxMiglMSksICUwDQotMToJICAgIGFk
Y2wgMTYoJTEpLCAlMA0KLQkgICAgbGVhIDQoJTEpLCAlMQ0KLQkgICAgZGVj
bCAlMg0KLQkgICAgam5lCTFiDQotCSAgICBhZGNsICQwLCAlMA0KLQkgICAg
bW92bCAlMCwgJTINCi0JICAgIHNocmwgJDE2LCAlMA0KLQkgICAgYWRkdyAl
dzIsICV3MA0KLQkgICAgYWRjbCAkMCwgJTANCi0JICAgIG5vdGwgJTANCi0y
Og0KKwlfX2FzbV9fIF9fdm9sYXRpbGVfXygiXA0KKwkgICAgbW92bCAoJTEp
LCAlMCBcDQorCSAgICBzdWJsICQ0LCAlMiBcDQorCSAgICBqYmUgMmYgXA0K
KwkgICAgYWRkbCA0KCUxKSwgJTAgXA0KKwkgICAgYWRjbCA4KCUxKSwgJTAg
XA0KKwkgICAgYWRjbCAxMiglMSksICUwIFwNCisxOgkgICAgYWRjbCAxNigl
MSksICUwIFwNCisJICAgIGxlYSA0KCUxKSwgJTEgXA0KKwkgICAgZGVjbCAl
MiBcDQorCSAgICBqbmUJMWIgXA0KKwkgICAgYWRjbCAkMCwgJTAgXA0KKwkg
ICAgbW92bCAlMCwgJTIgXA0KKwkgICAgc2hybCAkMTYsICUwIFwNCisJICAg
IGFkZHcgJXcyLCAldzAgXA0KKwkgICAgYWRjbCAkMCwgJTAgXA0KKwkgICAg
bm90bCAlMCBcDQorMjogXA0KQEAgLTEwNSwzICsxMDUsMyBAQA0KLQlfX2Fz
bV9fKCINCi0JCWFkZGwgJTEsICUwDQotCQlhZGNsICQweGZmZmYsICUwDQor
CV9fYXNtX18oIlwNCisJCWFkZGwgJTEsICUwIFwNCisJCWFkY2wgJDB4ZmZm
ZiwgJTAgXA0KQEAgLTEyMSw1ICsxMjEsNSBAQA0KLSAgICBfX2FzbV9fKCIN
Ci0JYWRkbCAlMSwgJTANCi0JYWRjbCAlMiwgJTANCi0JYWRjbCAlMywgJTAN
Ci0JYWRjbCAkMCwgJTANCisgICAgX19hc21fXygiXA0KKwlhZGRsICUxLCAl
MCBcDQorCWFkY2wgJTIsICUwIFwNCisJYWRjbCAlMywgJTAgXA0KKwlhZGNs
ICQwLCAlMCBcDQpAQCAtMTYxLDEyICsxNjEsMTIgQEANCi0JX19hc21fXygi
DQotCQlhZGRsIDAoJTEpLCAlMA0KLQkJYWRjbCA0KCUxKSwgJTANCi0JCWFk
Y2wgOCglMSksICUwDQotCQlhZGNsIDEyKCUxKSwgJTANCi0JCWFkY2wgMCgl
MiksICUwDQotCQlhZGNsIDQoJTIpLCAlMA0KLQkJYWRjbCA4KCUyKSwgJTAN
Ci0JCWFkY2wgMTIoJTIpLCAlMA0KLQkJYWRjbCAlMywgJTANCi0JCWFkY2wg
JTQsICUwDQotCQlhZGNsICQwLCAlMA0KKwlfX2FzbV9fKCJcDQorCQlhZGRs
IDAoJTEpLCAlMCBcDQorCQlhZGNsIDQoJTEpLCAlMCBcDQorCQlhZGNsIDgo
JTEpLCAlMCBcDQorCQlhZGNsIDEyKCUxKSwgJTAgXA0KKwkJYWRjbCAwKCUy
KSwgJTAgXA0KKwkJYWRjbCA0KCUyKSwgJTAgXA0KKwkJYWRjbCA4KCUyKSwg
JTAgXA0KKwkJYWRjbCAxMiglMiksICUwIFwNCisJCWFkY2wgJTMsICUwIFwN
CisJCWFkY2wgJTQsICUwIFwNCisJCWFkY2wgJDAsICUwIFwNCg==
--747458502-829697308-994143032=:15954--
