Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275436AbTHIXxh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 19:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275437AbTHIXxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 19:53:36 -0400
Received: from kde.informatik.uni-kl.de ([131.246.103.200]:33440 "EHLO
	dot.kde.org") by vger.kernel.org with ESMTP id S275436AbTHIXxY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 19:53:24 -0400
Date: Sun, 10 Aug 2003 01:42:57 +0200 (CEST)
From: Bernhard Rosenkraenzer <bero@arklinux.org>
X-X-Sender: bero@dot.kde.org
To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH] ia32 irq router detection bug in 2.4.22-rc1-ac1
Message-ID: <Pine.LNX.4.53.0308100136240.1011@dot.kde.org>
X-Legal-Notice: We do not accept spam. Violations will be prosecuted.
X-Subliminal-Message: Upgrade your system to Ark Linux today! http://www.arklinux.org/
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="658386544-1604970508-1060472577=:1105"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--658386544-1604970508-1060472577=:1105
Content-Type: TEXT/PLAIN; charset=US-ASCII

2.4.22-rc1-ac1 can misdetect irq routers because of a typo in the probing 
code.

Patch attached.

LLaP
bero

-- 
Ark Linux - Linux for the masses
http://www.arklinux.org/

Redistribution and processing of this message is subject to
http://www.arklinux.org/terms.php
--658386544-1604970508-1060472577=:1105
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="2.4.22-rc1-ac1-irq-fix.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.53.0308100142570.1105@dot.kde.org>
Content-Description: IRQ routing fix
Content-Disposition: attachment; filename="2.4.22-rc1-ac1-irq-fix.patch"

LS0tIGxpbnV4LTIuNC4yMS9hcmNoL2kzODYva2VybmVsL3BjaS1pcnEuYy5h
cmsJMjAwMy0wOC0wOSAxNzozODoxMC4wMDAwMDAwMDAgKzAyMDANCisrKyBs
aW51eC0yLjQuMjEvYXJjaC9pMzg2L2tlcm5lbC9wY2ktaXJxLmMJMjAwMy0w
OC0wOSAxNzozODo0My4wMDAwMDAwMDAgKzAyMDANCkBAIC04MTksNyArODE5
LDcgQEANCiAJCWlmIChydC0+cnRyX3ZlbmRvciA9PSBoLT52ZW5kb3IgJiYg
aC0+cHJvYmUociwgcGlycV9yb3V0ZXJfZGV2LCBydC0+cnRyX2RldmljZSkp
DQogCQkJYnJlYWs7DQogCQkvKiBGYWxsIGJhY2sgdG8gYSBkZXZpY2UgbWF0
Y2ggKi8NCi0JCWlmIChwaXJxX3JvdXRlcl9kZXYtPnZlbmRvciA9PSBwaXJx
X3JvdXRlcl9kZXYtPnZlbmRvciAmJiBoLT5wcm9iZShyLCBwaXJxX3JvdXRl
cl9kZXYsIHBpcnFfcm91dGVyX2Rldi0+ZGV2aWNlKSkNCisJCWlmIChwaXJx
X3JvdXRlcl9kZXYtPnZlbmRvciA9PSBoLT52ZW5kb3IgJiYgaC0+cHJvYmUo
ciwgcGlycV9yb3V0ZXJfZGV2LCBwaXJxX3JvdXRlcl9kZXYtPmRldmljZSkp
DQogCQkJYnJlYWs7DQogCX0NCiAJcHJpbnRrKEtFUk5fSU5GTyAiUENJOiBV
c2luZyBJUlEgcm91dGVyICVzIFslMDR4LyUwNHhdIGF0ICVzXG4iLA0K

--658386544-1604970508-1060472577=:1105--
