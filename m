Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262646AbREOGM5>; Tue, 15 May 2001 02:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262647AbREOGMq>; Tue, 15 May 2001 02:12:46 -0400
Received: from po4.wam.umd.edu ([128.8.10.166]:5539 "EHLO po4.wam.umd.edu")
	by vger.kernel.org with ESMTP id <S262646AbREOGM0>;
	Tue, 15 May 2001 02:12:26 -0400
Date: Tue, 15 May 2001 02:12:23 -0400 (EDT)
From: Jeremy Hunt Manson <jmanson@wam.umd.edu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] for sb_card.c in kernel 2.4.2
Message-ID: <Pine.GSO.4.21.0105150156160.14349-300000@rac5.wam.umd.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-989907143=:14349"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-851401618-989907143=:14349
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hi folks.  I've never posted a kernel patch before, so I don't know if I
got it right.  I followed the instructions in the FAQ...  I'm not
subscribed, so if you could follow up to jmanson@wam.umd.edu, I would
appreciate it.

This patch adds support for my sound card, which was an OEM version of
the SB AWE32 PnP (Got it from Dell).  It is pretty boring.  I made it for
2.4.2, but none of the patches since then seem to have added this support,
so here it is.

I would appreciate it if it could find its way into the kernel, as
hand-modifying the code after every patch I get from now on would be a
pain.  And I am sure that there are a lot of mystified circa-1996 Dell
owners out there...

Thanks!

					Jeremy Manson
					jmanson@wam.umd.edu

---559023410-851401618-989907143=:14349
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=README
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.21.0105150212230.14349@rac5.wam.umd.edu>
Content-Description: 
Content-Disposition: attachment; filename=README

QWRkcyBzdXBwb3J0IGZvciBDcmVhdGl2ZSBTQiBBV0UzMiBQblAgKENUTDAw
NDUpDQo=
---559023410-851401618-989907143=:14349
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.21.0105150212231.14349@rac5.wam.umd.edu>
Content-Description: 
Content-Disposition: attachment; filename=patch

ZGlmZiAtdSAtLXJlY3Vyc2l2ZSAtLW5ldy1maWxlIHYyLjQuMi9saW51eC9k
cml2ZXJzL3NvdW5kL3NiX2NhcmQuYyBsaW51eC9kcml2ZXJzL3NvdW5kL3Ni
X2NhcmQuYw0KLS0tIGxpbnV4LW9yaWcvZHJpdmVycy9zb3VuZC9zYl9jYXJk
LmMgIFR1ZSBNYXkgMTUgMDE6NTA6MzYgMjAwMQ0KKysrIGxpbnV4L2RyaXZl
cnMvc291bmQvc2JfY2FyZC5jICAgICAgIFR1ZSBNYXkgMTUgMDE6MzA6MTMg
MjAwMQ0KQEAgLTMzOCw2ICszMzgsMTEgQEANCiAgICAgICAgICAgICAgICBJ
U0FQTlBfVkVORE9SKCdDJywnVCcsJ0wnKSwgSVNBUE5QX0ZVTkNUSU9OKDB4
MDAzMSksDQogICAgICAgICAgICAgICAgMCwwLDAsMCwNCiAgICAgICAgICAg
ICAgICAwLDEsMSwtMX0sDQorICAgICAgIHsiQ3JlYXRpdmUgU0IgQVdFMzIg
UG5QIiwNCisgICAgICAgICAgICAgICBJU0FQTlBfVkVORE9SKCdDJywnVCcs
J0wnKSwgSVNBUE5QX0RFVklDRSgweDAwNDUpLA0KKyAgICAgICAgICAgICAg
IElTQVBOUF9WRU5ET1IoJ0MnLCdUJywnTCcpLCBJU0FQTlBfRlVOQ1RJT04o
MHgwMDMxKSwNCisgICAgICAgICAgICAgICAwLDAsMCwwLA0KKyAgICAgICAg
ICAgICAgIDAsMSwxLC0xfSwNCiAgICAgICAgeyJTb3VuZCBCbGFzdGVyIEFX
RSAzMiIsDQogICAgICAgICAgICAgICAgSVNBUE5QX1ZFTkRPUignQycsJ1Qn
LCdMJyksIElTQVBOUF9ERVZJQ0UoMHgwMDQ4KSwNCiAgICAgICAgICAgICAg
ICBJU0FQTlBfVkVORE9SKCdDJywnVCcsJ0wnKSwgSVNBUE5QX0ZVTkNUSU9O
KDB4MDAzMSksDQo=
---559023410-851401618-989907143=:14349--
