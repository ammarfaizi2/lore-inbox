Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbUCBBoQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 20:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbUCBBoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 20:44:16 -0500
Received: from ktown.kde.org ([131.246.103.200]:27270 "EHLO dot.kde.org")
	by vger.kernel.org with ESMTP id S261533AbUCBBoP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 20:44:15 -0500
Date: Tue, 2 Mar 2004 02:39:10 +0100 (CET)
From: Bernhard Rosenkraenzer <bero@arklinux.org>
X-X-Sender: bero@dot.kde.org
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] 2.6.4-rc1-mm1 SND_FM801_TEA575X Kconfig error
Message-ID: <Pine.LNX.4.58.0403020237530.6219@dot.kde.org>
X-Legal-Notice: We do not accept spam. Violations will be prosecuted.
X-Subliminal-Message: Upgrade your system to Ark Linux today! http://www.arklinux.org/
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="658386544-526816557-1078191550=:6219"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--658386544-526816557-1078191550=:6219
Content-Type: TEXT/PLAIN; charset=US-ASCII

Kconfig names the option CONFIG_SND_FM801_TEA575X, but the makefiles don't 
check for the resulting CONFIG_CONFIG_SND_FM801_TEA575X -- trivial fix 
attached.

LLaP
bero

-- 
Ark Linux - Linux for the masses
http://www.arklinux.org/

Redistribution and processing of this message is subject to
http://www.arklinux.org/terms.php
--658386544-526816557-1078191550=:6219
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="2.6.4-rc1-mm1-tea575x.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0403020239100.6219@dot.kde.org>
Content-Description: fix
Content-Disposition: attachment; filename="2.6.4-rc1-mm1-tea575x.patch"

LS0tIGxpbnV4LTIuNi4zL3NvdW5kL3BjaS9LY29uZmlnLmFyawkyMDA0LTAz
LTAyIDAyOjQ1OjU4LjAwMDAwMDAwMCArMDEwMA0KKysrIGxpbnV4LTIuNi4z
L3NvdW5kL3BjaS9LY29uZmlnCTIwMDQtMDMtMDIgMDI6NDY6MDMuMDAwMDAw
MDAwICswMTAwDQpAQCAtMTYwLDcgKzE2MCw3IEBADQogCWhlbHANCiAJICBT
YXkgJ1knIG9yICdNJyB0byBpbmNsdWRlIHN1cHBvcnQgZm9yIEZvcnRlTWVk
aWEgRk04MDEgYmFzZWQgc291bmRjYXJkcy4NCiANCi1jb25maWcgQ09ORklH
X1NORF9GTTgwMV9URUE1NzVYDQorY29uZmlnIFNORF9GTTgwMV9URUE1NzVY
DQogCXRyaXN0YXRlICJGb3J0ZU1lZGlhIEZNODAxICsgVEVBNTc1NyB0dW5l
ciINCiAJZGVwZW5kcyBvbiBTTkRfRk04MDENCiAgICAgICAgIHNlbGVjdCBD
T05GSUdfVklERU9fREVWDQo=

--658386544-526816557-1078191550=:6219--
