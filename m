Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291608AbSBTCu2>; Tue, 19 Feb 2002 21:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291614AbSBTCuT>; Tue, 19 Feb 2002 21:50:19 -0500
Received: from toole.uol.com.br ([200.231.206.186]:48352 "EHLO
	toole.uol.com.br") by vger.kernel.org with ESMTP id <S291608AbSBTCuN>;
	Tue, 19 Feb 2002 21:50:13 -0500
Date: Tue, 19 Feb 2002 23:50:06 -0300 (BRT)
From: Jean Paul Sartre <sartre@linuxbr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: sclin@sis.com.tw, <faith@valinux.com>
Subject: A simple patch for SIS (documentation and kbuild)
Message-ID: <Pine.LNX.4.40.0202192343420.13176-200000@sartre.linuxbr.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-434367213-1014173406=:13176"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-434367213-1014173406=:13176
Content-Type: TEXT/PLAIN; charset=US-ASCII

	Hello, all.

	As I've spoken with Alan Cox and Christoph Pittracher, there's a
problem with the dependency. I do not know who takes care of the
documentation stuff and kbuild procedures, but here they are.

	(okay. Building FB_SIS as module and DRM_SIS as builtin completely
*breaks* dependencies, so I did this to enforce them both as modules or
both as builtin)

	The patch is very simple, adds the Config.in 'if' and the
CONFIG_DRM_SIS description in Documentation/Configure.help.

	Thanks,
	Cesar Suga <sartre@linuxbr.com>



--8323328-434367213-1014173406=:13176
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="sis-patch-2.4.18-rc2-ac1.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.40.0202192350060.13176@sartre.linuxbr.com>
Content-Description: 
Content-Disposition: attachment; filename="sis-patch-2.4.18-rc2-ac1.diff"

LS0tIGxpbnV4L2RyaXZlcnMvY2hhci9kcm0vQ29uZmlnLmluCVR1ZSBGZWIg
MTkgMjM6MzI6NTYgMjAwMg0KKysrIGxpbnV4L2RyaXZlcnMvY2hhci9kcm0v
Q29uZmlnLmluCVR1ZSBGZWIgMTkgMjM6MzI6NDYgMjAwMg0KQEAgLTEyLDQg
KzEyLDYgQEANCiBkZXBfdHJpc3RhdGUgJyAgSW50ZWwgSTgxMCcgQ09ORklH
X0RSTV9JODEwICRDT05GSUdfQUdQDQogZGVwX3RyaXN0YXRlICcgIEludGVs
IDgzME0nIENPTkZJR19EUk1fSTgzMCAkQ09ORklHX0FHUA0KIGRlcF90cmlz
dGF0ZSAnICBNYXRyb3ggZzIwMC9nNDAwJyBDT05GSUdfRFJNX01HQSAkQ09O
RklHX0FHUA0KLWRlcF90cmlzdGF0ZSAnICBTaVMnIENPTkZJR19EUk1fU0lT
ICRDT05GSUdfQUdQDQoraWYgWyAiJENPTkZJR19GQl9TSVMiID0gInkiIC1v
ICIkQ09ORklHX0ZCX1NJUyIgPSAibSIgXTsgdGhlbg0KKyAgZGVwX3RyaXN0
YXRlICcgIFNpUycgQ09ORklHX0RSTV9TSVMgJENPTkZJR19BR1AgJENPTkZJ
R19GQl9TSVMNCitmaQ0KDQotLS0gbGludXgvRG9jdW1lbnRhdGlvbi9Db25m
aWd1cmUuaGVscAlUdWUgRmViIDE5IDIzOjM5OjQ0IDIwMDINCisrKyBsaW51
eC9Eb2N1bWVudGF0aW9uL0NvbmZpZ3VyZS5oZWxwCVR1ZSBGZWIgMTkgMjM6
Mzg6NDggMjAwMg0KQEAgLTE3MTY2LDYgKzE3MTY2LDEyIEBADQogICBjYXJk
LiAgSWYgTSBpcyBzZWxlY3RlZCwgdGhlIG1vZHVsZSB3aWxsIGJlIGNhbGxl
ZCBtZ2Euby4gIEFHUA0KICAgc3VwcG9ydCBpcyByZXF1aXJlZCBmb3IgdGhp
cyBkcml2ZXIgdG8gd29yay4NCiANCitTaVMgMzAwLzU0MC82MzANCitDT05G
SUdfRFJNX1NJUw0KKyAgQ2hvb3NlIHRoaXMgb3B0aW9uIGlmIHlvdSBoYXZl
IGEgU0lTIDMwMCwgNTQwIG9yIDYzMCBncmFwaGljcyBjYXJkLg0KKyAgSWYg
TSBpcyBzZWxlY3RlZCwgdGhlIG1vZHVsZSB3aWxsIGJlIGNhbGxlZCBzaXMu
by4gIEFHUCBzdXBwb3J0IGlzDQorICByZXF1aXJlZCBmb3IgdGhpcyBkcml2
ZXIgdG8gd29yay4NCisNCiAzZGZ4IEJhbnNoZWUvVm9vZG9vMysNCiBDT05G
SUdfRFJNNDBfVERGWA0KICAgQ2hvb3NlIHRoaXMgb3B0aW9uIGlmIHlvdSBo
YXZlIGEgM2RmeCBCYW5zaGVlIG9yIFZvb2RvbzMgKG9yIGxhdGVyKSwNCg==
--8323328-434367213-1014173406=:13176--
