Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130485AbREHJIn>; Tue, 8 May 2001 05:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130487AbREHJId>; Tue, 8 May 2001 05:08:33 -0400
Received: from inet.kpn.net ([194.151.95.4]:8872 "EHLO inet.kpn.net")
	by vger.kernel.org with ESMTP id <S130485AbREHJIR>;
	Tue, 8 May 2001 05:08:17 -0400
Message-ID: <000701c0d79e$667dd0e0$a10616c2@nmcgv>
From: "Ben Castricum" <benc@inet.kpn.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.5-pre1 Unresolved symbol in module ide-mod.o
Date: Tue, 8 May 2001 11:07:38 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After a clean compile the module ide-mod.o seems to be missing a symbol,
this problem didn't exist in 2.4.4

root@spike:~# depmod -ae 2.4.5-pre1
depmod: *** Unresolved symbols in
/lib/modules/2.4.5-pre1/kernel/drivers/ide/ide-mod.o
depmod:         invalidate_device_R25a4b0b2

Complete config is available at http://spike.i-lan.nl/.config

Hope this helps,
Ben

