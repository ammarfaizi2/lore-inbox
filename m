Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271385AbTG2K0w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 06:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271393AbTG2K0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 06:26:52 -0400
Received: from kde.informatik.uni-kl.de ([131.246.103.200]:57502 "EHLO
	dot.kde.org") by vger.kernel.org with ESMTP id S271385AbTG2K0v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 06:26:51 -0400
Date: Tue, 29 Jul 2003 12:18:16 +0200 (CEST)
From: Bernhard Rosenkraenzer <bero@arklinux.org>
X-X-Sender: bero@dot.kde.org
To: linux-kernel@vger.kernel.org
Subject: [PATCH] [2.6] Make com20020_cs module compile
Message-ID: <Pine.LNX.4.53.0307291217580.29995@dot.kde.org>
X-Legal-Notice: We do not accept spam. Violations will be prosecuted.
X-Subliminal-Message: Upgrade your system to Ark Linux today! http://www.arklinux.org/
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="658386544-686579945-1059473856=:29995"
Content-ID: <Pine.LNX.4.53.0307291217581.29995@dot.kde.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--658386544-686579945-1059473856=:29995
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.53.0307291217582.29995@dot.kde.org>

com20020_cs was missed out on the hw.open_close_ll -> hw.owner change.
Patch was diffed against 2.6.0-test2-mm1, but should apply to 
2.6.0-test2 vanilla as well.

LLaP
bero

-- 
Ark Linux - Linux for the masses
http://www.arklinux.org/

Redistribution and processing of this message is subject to
http://www.arklinux.org/terms.php
--658386544-686579945-1059473856=:29995
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="2.6.0-test2-fix-compile.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.53.0307291217360.29995@dot.kde.org>
Content-Description: fix build
Content-Disposition: ATTACHMENT; FILENAME="2.6.0-test2-fix-compile.patch"

LS0tIGxpbnV4LTIuNi4wLXRlc3QyL2RyaXZlcnMvbmV0L3BjbWNpYS9jb20y
MDAyMF9jcy5jLmFyawkyMDAzLTA3LTI5IDEyOjA1OjI1LjAwMDAwMDAwMCAr
MDIwMA0KKysrIGxpbnV4LTIuNi4wLXRlc3QyL2RyaXZlcnMvbmV0L3BjbWNp
YS9jb20yMDAyMF9jcy5jCTIwMDMtMDctMjkgMTI6MDU6NDIuMDAwMDAwMDAw
ICswMjAwDQpAQCAtMjM3LDcgKzIzNyw3IEBADQogICAgIGxwLT5iYWNrcGxh
bmUgPSBiYWNrcGxhbmU7DQogICAgIGxwLT5jbG9ja3AgPSBjbG9ja3A7DQog
ICAgIGxwLT5jbG9ja20gPSBjbG9ja20gJiAzOw0KLSAgICBscC0+aHcub3Bl
bl9jbG9zZV9sbCA9IGNvbTIwMDIwY3Nfb3Blbl9jbG9zZTsNCisgICAgbHAt
Pmh3Lm93bmVyID0gVEhJU19NT0RVTEU7DQogDQogICAgIGxpbmstPmlycS5J
bnN0YW5jZSA9IGluZm8tPmRldiA9IGRldjsNCiAgICAgbGluay0+cHJpdiA9
IGluZm87DQo=

--658386544-686579945-1059473856=:29995--
