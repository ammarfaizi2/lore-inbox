Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316897AbSIIKDi>; Mon, 9 Sep 2002 06:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316935AbSIIKDW>; Mon, 9 Sep 2002 06:03:22 -0400
Received: from smtpout.mac.com ([204.179.120.86]:4058 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S316897AbSIIKCn>;
	Mon, 9 Sep 2002 06:02:43 -0400
Message-Id: <200209091007.g89A7RVw025733@smtp-relay01.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 9/10 sound/oss/dmasound/dmasound.h
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.33/sound/oss/dmasound/dmasound.h	Sat Apr 20 18:25:19 2002
+++ linux-2.5-cli-oss/sound/oss/dmasound/dmasound.h	Mon Sep  9 01:27:04 2002
@@ -166,6 +166,7 @@
     int treble;
     int gain;
     int minDev;		/* minor device number currently open */
+    spinlock_t lock;
 };
 
 extern struct sound_settings dmasound;

