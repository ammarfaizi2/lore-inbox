Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276718AbRJBVyT>; Tue, 2 Oct 2001 17:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276719AbRJBVyI>; Tue, 2 Oct 2001 17:54:08 -0400
Received: from ns02.newbridge.com ([192.75.23.75]:6044 "HELO
	ns02.newbridge.com") by vger.kernel.org with SMTP
	id <S276718AbRJBVxy>; Tue, 2 Oct 2001 17:53:54 -0400
From: Jerome Cornet <jerome.cornet@alcatel.com>
Organization: Alcatel Networks
To: linux-kernel@vger.kernel.org
Subject: [PATCH] SB driver, kernel 2.4.10
Date: Tue, 2 Oct 2001 17:52:05 -0400
X-Mailer: KMail [version 1.3.2]
Cc: Takashi Iwai <iwai@ww.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_T2ML9KNKSYTJU0TGLL85"
Message-Id: <iss.5826.3bba3705.d9786.1@kanata-mh1.ca.newbridge.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_T2ML9KNKSYTJU0TGLL85
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

    Hi there,

The PnP initialisation of my brand old SB AWE64 PnP was not supported by the 
current (2.4.10) kernel driver (I could initialise it by using isapnptools, 
but not directly by the pnp driver).

I patched sb_card.c so that the device ID of my board is known by the SB 
driver, thus allowing the isapnp initialisation by the driver directly.

I tested it on my computer, and I don't expect the patch to break anything 
(it's a no brainer fix)

Maybe you can consider applying it to the next release ?

Thank you,
 /Jerome

PS: please CC: me for the replies, I'm not subscribed to linux-kernel

--------------Boundary-00=_T2ML9KNKSYTJU0TGLL85
Content-Type: text/plain;
  charset="iso-8859-1";
  name="README"
Content-Transfer-Encoding: base64
Content-Description: The readme file
Content-Disposition: attachment; filename="README"

SmVyb21lIENvcm5ldCA8amNvcm5ldEBmcmVlLmZyPjogQWRkIGEgbmV3IGZsYXZvciBvZiBBV0U2
NCBQblAgdG8gdGhlIHNiIGRyaXZlcgo=

--------------Boundary-00=_T2ML9KNKSYTJU0TGLL85
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="linux-2.4.10-awe64.patch"
Content-Transfer-Encoding: base64
Content-Description: the patch itself
Content-Disposition: attachment; filename="linux-2.4.10-awe64.patch"

LS0tIGtlcm5lbC1zb3VyY2UtMi40LjEwL2RyaXZlcnMvc291bmQvc2JfY2FyZC5jCVR1ZSBTZXAg
MTggMTc6MTA6NDMgMjAwMQorKysgbGludXgvZHJpdmVycy9zb3VuZC9zYl9jYXJkLmMJVHVlIE9j
dCAgMiAxNzozNTowNiAyMDAxCkBAIC01Myw2ICs1Myw5IEBACiAgKgogICogMjgtMTAtMjAwMCBB
ZGRlZCBwbnBsZWdhY3kgc3VwcG9ydAogICogCURhbmllbCBDaHVyY2ggPGRjaHVyY2hAbWJocy5l
ZHU+CisgKgorICogMDEtMTAtMjAwMSBBZGRlZCBhIG5ldyBmbGF2b3Igb2YgQ3JlYXRpdmUgU0Ig
QVdFNjQgUG5QIChDVEwwMEU5KS4KKyAqICAgICAgSmVyb21lIENvcm5ldCA8amNvcm5ldEBmcmVl
LmZyPgogICovCiAKICNpbmNsdWRlIDxsaW51eC9jb25maWcuaD4KQEAgLTQzNSw2ICs0MzgsMTEg
QEAKIAkJMCwxLDEsLTF9LAogCXsiU291bmQgQmxhc3RlciBBV0UgNjQiLAogCQlJU0FQTlBfVkVO
RE9SKCdDJywnVCcsJ0wnKSwgSVNBUE5QX0RFVklDRSgweDAwRTQpLCAKKwkJSVNBUE5QX1ZFTkRP
UignQycsJ1QnLCdMJyksIElTQVBOUF9GVU5DVElPTigweDAwNDUpLAorCQkwLDAsMCwwLAorCQkw
LDEsMSwtMX0sCisJeyJTb3VuZCBCbGFzdGVyIEFXRSA2NCIsCisJCUlTQVBOUF9WRU5ET1IoJ0Mn
LCdUJywnTCcpLCBJU0FQTlBfREVWSUNFKDB4MDBFOSksIAogCQlJU0FQTlBfVkVORE9SKCdDJywn
VCcsJ0wnKSwgSVNBUE5QX0ZVTkNUSU9OKDB4MDA0NSksCiAJCTAsMCwwLDAsCiAJCTAsMSwxLC0x
fSwK

--------------Boundary-00=_T2ML9KNKSYTJU0TGLL85--
