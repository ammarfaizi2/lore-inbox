Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265656AbSJSNRO>; Sat, 19 Oct 2002 09:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265660AbSJSNRO>; Sat, 19 Oct 2002 09:17:14 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:44297 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S265656AbSJSNRM>; Sat, 19 Oct 2002 09:17:12 -0400
Date: Sat, 19 Oct 2002 15:22:29 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Adrian Bunk <bunk@fs.tum.de>
cc: Ivan Gyurdiev <ivg2@cornell.edu>, Adam Belay <ambx1@neo.rr.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Re: 2.5.44 - scripts/kconfig.tk error (xconfig fails)
In-Reply-To: <Pine.NEB.4.44.0210191128140.28761-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.LNX.4.44.0210191518130.8911-200000@serv>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811837-1935709570-1035033749=:8911"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811837-1935709570-1035033749=:8911
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,

On Sat, 19 Oct 2002, Adrian Bunk wrote:

> A dep_bool without a dependency is wrong. The following patch fixes it:

It's not the only error. 'comment' doesn't accept dependencies (correct
fix attached).
(No, we have no new syntax yet. *sigh*)

bye, Roman

---1463811837-1935709570-1035033749=:8911
Content-Type: TEXT/plain; name="pnp.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0210191522280.8911@serv>
Content-Description: 
Content-Disposition: attachment; filename="pnp.diff"

SW5kZXg6IGRyaXZlcnMvcG5wL0NvbmZpZy5pbg0KPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQ0KUkNTIGZpbGU6IC91c3Ivc3JjL2N2c3Jvb3QvbGludXgtMi41
L2RyaXZlcnMvcG5wL0NvbmZpZy5pbix2DQpyZXRyaWV2aW5nIHJldmlzaW9u
IDEuMS4xLjMNCmRpZmYgLXUgLXAgLXIxLjEuMS4zIENvbmZpZy5pbg0KLS0t
IGRyaXZlcnMvcG5wL0NvbmZpZy5pbgkxOSBPY3QgMjAwMiAxMTozNjoxNSAt
MDAwMAkxLjEuMS4zDQorKysgZHJpdmVycy9wbnAvQ29uZmlnLmluCTE5IE9j
dCAyMDAyIDEzOjAwOjEwIC0wMDAwDQpAQCAtNCwxNSArNCwxNyBAQA0KIG1h
aW5tZW51X29wdGlvbiBuZXh0X2NvbW1lbnQNCiBjb21tZW50ICdQbHVnIGFu
ZCBQbGF5IGNvbmZpZ3VyYXRpb24nDQogDQotZGVwX2Jvb2wgJ1BsdWcgYW5k
IFBsYXkgc3VwcG9ydCcgQ09ORklHX1BOUA0KK2Jvb2wgJ1BsdWcgYW5kIFBs
YXkgc3VwcG9ydCcgQ09ORklHX1BOUA0KIA0KLSAgIGRlcF9ib29sICcgIFBs
dWcgYW5kIFBsYXkgZGV2aWNlIG5hbWUgZGF0YWJhc2UnIENPTkZJR19QTlBf
TkFNRVMgJENPTkZJR19QTlANCi0gICBkZXBfYm9vbCAnICBQblAgRGVidWcg
TWVzc2FnZXMnIENPTkZJR19QTlBfREVCVUcgJENPTkZJR19QTlANCitpZiBb
ICIkQ09ORklHX1BOUCIgPSAieSIgXTsgdGhlbg0KKyAgIGJvb2wgJyAgUGx1
ZyBhbmQgUGxheSBkZXZpY2UgbmFtZSBkYXRhYmFzZScgQ09ORklHX1BOUF9O
QU1FUw0KKyAgIGJvb2wgJyAgUG5QIERlYnVnIE1lc3NhZ2VzJyBDT05GSUdf
UE5QX0RFQlVHDQogDQotY29tbWVudCAnUHJvdG9jb2xzJyAkQ09ORklHX1BO
UA0KKyAgIGNvbW1lbnQgJ1Byb3RvY29scycNCiANCi1pZiBbICIkQ09ORklH
X0VYUEVSSU1FTlRBTCIgPSAieSIgXTsgdGhlbg0KLSAgIGRlcF9ib29sICcg
IElTQSBQbHVnIGFuZCBQbGF5IHN1cHBvcnQgKEVYUEVSSU1FTlRBTCknIENP
TkZJR19JU0FQTlAgJENPTkZJR19QTlANCi0gICBkZXBfYm9vbCAnICBQbHVn
IGFuZCBQbGF5IEJJT1Mgc3VwcG9ydCAoRVhQRVJJTUVOVEFMKScgQ09ORklH
X1BOUEJJT1MgJENPTkZJR19QTlANCisgICBpZiBbICIkQ09ORklHX0VYUEVS
SU1FTlRBTCIgPSAieSIgXTsgdGhlbg0KKyAgICAgIGJvb2wgJyAgSVNBIFBs
dWcgYW5kIFBsYXkgc3VwcG9ydCAoRVhQRVJJTUVOVEFMKScgQ09ORklHX0lT
QVBOUA0KKyAgICAgIGJvb2wgJyAgUGx1ZyBhbmQgUGxheSBCSU9TIHN1cHBv
cnQgKEVYUEVSSU1FTlRBTCknIENPTkZJR19QTlBCSU9TDQorICAgZmkNCiBm
aQ0KIGVuZG1lbnUNCg==
---1463811837-1935709570-1035033749=:8911--
