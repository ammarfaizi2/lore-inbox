Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263324AbUDPP2i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 11:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263304AbUDPPZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 11:25:59 -0400
Received: from tag.witbe.net ([81.88.96.48]:18701 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S263364AbUDPPWi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 11:22:38 -0400
Message-Id: <200404161522.i3GFMa118998@tag.witbe.net>
Reply-To: <rol@as2917.net>
From: "Paul Rolland" <rol@as2917.net>
To: <linux-kernel@vger.kernel.org>
Cc: <rol@as2917.net>
Subject: [2.6.5] agp_backend_initialize() failed
Date: Fri, 16 Apr 2004 17:22:34 +0200
Organization: AS2917
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQjxqRMT/HMRxuETYSLU8vjoTUfpA==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I juste realized that my messages log contains :

Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected SiS 648 chipset
agpgart: Maximum main memory to use for agp memory: 1430M
agpgart: unable to determine aperture size.
agpgart: agp_backend_initialize() failed.
agpgart-sis: probe of 0000:00:00.0 failed with error -22

Before, I had :

Mar 23 22:09:12 donald kernel: Linux agpgart interface v0.100 (c) Dave Jones
Mar 23 22:09:12 donald kernel: agpgart: Detected SiS 648 chipset
Mar 23 22:09:12 donald kernel: agpgart: Maximum main memory to use for agp
memo
ry: 1430M
Mar 23 22:09:12 donald kernel: agpgart: AGP aperture is 256M @ 0xd0000000
Mar 23 22:09:12 donald kernel: [drm] Initialized radeon 1.9.0 20020828 on
minor
 0

with kernel 2.6.4 :

Mar 23 22:09:10 donald kernel: Linux version 2.6.4 (root@donald.as2917.net)
(gc
c version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #2 Tue Mar 23 22:02:26 CET
20
04

Any hint ? I can't remember reading anything about that in lkml...

Regards,
Paul
rol@as2917.net



