Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262770AbVDHJag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262770AbVDHJag (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 05:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbVDHJag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 05:30:36 -0400
Received: from mail14.messagelabs.com ([212.125.75.19]:2009 "HELO
	mail14.messagelabs.com") by vger.kernel.org with SMTP
	id S262770AbVDHJaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 05:30:19 -0400
X-VirusChecked: Checked
X-Env-Sender: chris.elston@radstone.co.uk
X-Msg-Ref: server-16.tower-14.messagelabs.com!1112952613!0!1
X-StarScan-Version: 5.4.11; banners=radstone.co.uk,-,-
X-Originating-IP: [193.130.116.242]
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C53C1D.BC3EAFE8"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: [PATCH 2.6.12-rc2 2/2] ppc32: add rtc hooks in PPC7D platform file
Date: Fri, 8 Apr 2005 10:31:25 +0100
Message-ID: <F38DEABE0E171746B133C1ABBD142D9703691AF2@radmail.Radstone.Local>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.12-rc2 2/2] ppc32: add rtc hooks in PPC7D platform file
Thread-Index: AcU8HbyOfFtWUZxITbqLQ7hm22kmmw==
From: "Chris Elston" <chris.elston@radstone.co.uk>
To: <akpm@osdl.org>
Cc: <linuxppc-embedded@ozlabs.org>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C53C1D.BC3EAFE8
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

This=20patch=20adds=20the=20hooks=20into=20the=20PPC7D=20platforms=20file=20=
to
support=20the=20DS1337=20RTC=20device=20as=20the=20clock=20device=20for=20=
the=20
PPC7D=20board.

Signed-off-by:=20Chris=20Elston=20<chris.elston@radstone.co.uk>

________________________________________________________________________
This=20e-mail=20has=20been=20scanned=20for=20all=20viruses=20by=20Star.=20=
The
service=20is=20powered=20by=20MessageLabs.=20For=20more=20information=20on=
=20a=20proactive
anti-virus=20service=20working=20around=20the=20clock,=20around=20the=20gl=
obe,=20visit:
http://www.star.net.uk
________________________________________________________________________
------_=_NextPart_001_01C53C1D.BC3EAFE8
Content-Type: application/octet-stream;
	name="ppc7d_rtc_hooks.patch"
Content-Transfer-Encoding: base64
Content-Description: ppc7d_rtc_hooks.patch
Content-Disposition: attachment;
	filename="ppc7d_rtc_hooks.patch"

LS0tIGxpbnV4LTIuNi4xMi1yYzIvYXJjaC9wcGMvcGxhdGZvcm1zL3JhZHN0b25lX3BwYzdkLmMJ
MjAwNS0wNC0wNyAxMjozMTo0My4wMDAwMDAwMDAgKzAxMDAKKysrIGxpbnV4LTIuNi4xMi1yYzIt
Y2RlL2FyY2gvcHBjL3BsYXRmb3Jtcy9yYWRzdG9uZV9wcGM3ZC5jCTIwMDUtMDQtMDcgMTI6Mjg6
NTEuMDAwMDAwMDAwICswMTAwCkBAIC02OCw2ICs2OCw3IEBACiAjZGVmaW5lIFBQQzdEX1JTVF9Q
SU4JCQkxNyAJLyogR1BQMTcgKi8KIAogZXh0ZXJuIHUzMiBtdjY0MzYwX2lycV9iYXNlOworZXh0
ZXJuIHNwaW5sb2NrX3QgcnRjX2xvY2s7CiAKIHN0YXRpYyBzdHJ1Y3QgbXY2NHg2MF9oYW5kbGUg
Ymg7CiBzdGF0aWMgaW50IHBwYzdkX2hhc19hbG1hOwpAQCAtNzUsNiArNzYsMTEgQEAKIGV4dGVy
biB2b2lkIGdlbjU1MF9wcm9ncmVzcyhjaGFyICosIHVuc2lnbmVkIHNob3J0KTsKIGV4dGVybiB2
b2lkIGdlbjU1MF9pbml0KGludCwgc3RydWN0IHVhcnRfcG9ydCAqKTsKIAorLyogRklYTUUgLSBt
b3ZlIHRvIGggZmlsZSAqLworZXh0ZXJuIGludCBkczEzMzdfZG9fY29tbWFuZChpbnQgaWQsIGlu
dCBjbWQsIHZvaWQgKmFyZyk7CisjZGVmaW5lIERTMTMzN19HRVRfREFURSAgICAgICAgIDAKKyNk
ZWZpbmUgRFMxMzM3X1NFVF9EQVRFICAgICAgICAgMQorCiAvKiByZXNpZHVhbCBkYXRhICovCiB1
bnNpZ25lZCBjaGFyIF9fcmVzW3NpemVvZihiZF90KV07CiAKQEAgLTEyMzYsNiArMTI0OCwzOCBA
QAogCXByaW50ayhLRVJOX0lORk8gIlJhZHN0b25lIFRlY2hub2xvZ3kgUFBDN0RcbiIpOwogCWlm
IChwcGNfbWQucHJvZ3Jlc3MpCiAJCXBwY19tZC5wcm9ncmVzcygicHBjN2Rfc2V0dXBfYXJjaDog
ZXhpdCIsIDApOworCit9CisKKy8qIFJlYWwgVGltZSBDbG9jayBzdXBwb3J0LgorICogUFBDN0Qg
aGFzIGEgRFMxMzM3IGFjY2Vzc2VkIGJ5IEkyQy4KKyAqLworc3RhdGljIHVsb25nIHBwYzdkX2dl
dF9ydGNfdGltZSh2b2lkKQoreworICAgICAgICBzdHJ1Y3QgcnRjX3RpbWUgdG07CisgICAgICAg
IGludCByZXN1bHQ7CisKKyAgICAgICAgc3Bpbl9sb2NrKCZydGNfbG9jayk7CisgICAgICAgIHJl
c3VsdCA9IGRzMTMzN19kb19jb21tYW5kKDAsIERTMTMzN19HRVRfREFURSwgJnRtKTsKKyAgICAg
ICAgc3Bpbl91bmxvY2soJnJ0Y19sb2NrKTsKKworICAgICAgICBpZiAocmVzdWx0ID09IDApCisg
ICAgICAgICAgICAgICAgcmVzdWx0ID0gbWt0aW1lKHRtLnRtX3llYXIsIHRtLnRtX21vbiwgdG0u
dG1fbWRheSwgdG0udG1faG91ciwgdG0udG1fbWluLCB0bS50bV9zZWMpOworCisgICAgICAgIHJl
dHVybiByZXN1bHQ7Cit9CisKK3N0YXRpYyBpbnQgcHBjN2Rfc2V0X3J0Y190aW1lKHVuc2lnbmVk
IGxvbmcgbm93dGltZSkKK3sKKyAgICAgICAgc3RydWN0IHJ0Y190aW1lIHRtOworICAgICAgICBp
bnQgcmVzdWx0OworCisgICAgICAgIHNwaW5fbG9jaygmcnRjX2xvY2spOworICAgICAgICB0b190
bShub3d0aW1lLCAmdG0pOworICAgICAgICByZXN1bHQgPSBkczEzMzdfZG9fY29tbWFuZCgwLCBE
UzEzMzdfU0VUX0RBVEUsICZ0bSk7CisgICAgICAgIHNwaW5fdW5sb2NrKCZydGNfbG9jayk7CisK
KyAgICAgICAgcmV0dXJuIHJlc3VsdDsKIH0KIAogLyogVGhpcyBrZXJuZWwgY29tbWFuZCBsaW5l
IHBhcmFtZXRlciBjYW4gYmUgdXNlZCB0byBoYXZlIHRoZSB0YXJnZXQKQEAgLTEyOTMsNiArMTMz
NywxMCBAQAogCWRhdGE4IHw9IDB4MDc7CiAJb3V0YihkYXRhOCwgUFBDN0RfQ1BMRF9MRURTKTsK
IAorICAgICAgICAvKiBIb29rIHVwIFJUQy4gV2UgY291bGRuJ3QgZG8gdGhpcyBlYXJsaWVyIGJl
Y2F1c2Ugd2UgbmVlZCB0aGUgSTJDIHN1YnN5c3RlbSAqLworICAgICAgICBwcGNfbWQuc2V0X3J0
Y190aW1lID0gcHBjN2Rfc2V0X3J0Y190aW1lOworICAgICAgICBwcGNfbWQuZ2V0X3J0Y190aW1l
ID0gcHBjN2RfZ2V0X3J0Y190aW1lOworCiAJcHJfZGVidWcoIiVzOiBleGl0XG4iLCBfX0ZVTkNU
SU9OX18pOwogfQogCg==

------_=_NextPart_001_01C53C1D.BC3EAFE8--
