Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262394AbUBXSeR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 13:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbUBXSdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 13:33:05 -0500
Received: from ktown.kde.org ([131.246.103.200]:6377 "EHLO dot.kde.org")
	by vger.kernel.org with ESMTP id S262394AbUBXSbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 13:31:55 -0500
Date: Tue, 24 Feb 2004 19:27:52 +0100 (CET)
From: Bernhard Rosenkraenzer <bero@arklinux.org>
X-X-Sender: bero@dot.kde.org
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] 2.6.3-mm3 CONFIG_SND_MIXART doesn't compile
Message-ID: <Pine.LNX.4.58.0402241926310.21500@dot.kde.org>
X-Legal-Notice: We do not accept spam. Violations will be prosecuted.
X-Subliminal-Message: Upgrade your system to Ark Linux today! http://www.arklinux.org/
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="658386544-1035134426-1077647272=:21500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--658386544-1035134426-1077647272=:21500
Content-Type: TEXT/PLAIN; charset=US-ASCII

mixart.h uses tasklet_struct without including linux/interrupt.h -- fix 
attached.

LLaP
bero

-- 
Ark Linux - Linux for the masses
http://www.arklinux.org/

Redistribution and processing of this message is subject to
http://www.arklinux.org/terms.php
--658386544-1035134426-1077647272=:21500
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="linux-2.6.3mm3-compile.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0402241927520.21500@dot.kde.org>
Content-Description: Fix compile
Content-Disposition: attachment; filename="linux-2.6.3mm3-compile.patch"

LS0tIGxpbnV4LTIuNi4zL3NvdW5kL3BjaS9taXhhcnQvbWl4YXJ0LmguYXJr
CTIwMDQtMDItMjQgMTc6MjY6NDcuMDAwMDAwMDAwICswMTAwDQorKysgbGlu
dXgtMi42LjMvc291bmQvcGNpL21peGFydC9taXhhcnQuaAkyMDA0LTAyLTI0
IDE3OjI2OjU5LjAwMDAwMDAwMCArMDEwMA0KQEAgLTIzLDYgKzIzLDcgQEAN
CiAjaWZuZGVmIF9fU09VTkRfTUlYQVJUX0gNCiAjZGVmaW5lIF9fU09VTkRf
TUlYQVJUX0gNCiANCisjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+DQog
I2luY2x1ZGUgPHNvdW5kL3BjbS5oPg0KIA0KICNkZWZpbmUgTUlYQVJUX0RS
SVZFUl9WRVJTSU9OCTB4MDAwMTAwCS8qIDAuMS4wICovDQo=

--658386544-1035134426-1077647272=:21500--
