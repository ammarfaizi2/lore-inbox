Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267516AbSKQPsa>; Sun, 17 Nov 2002 10:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267517AbSKQPsa>; Sun, 17 Nov 2002 10:48:30 -0500
Received: from 015.atlasinternet.net ([212.9.93.15]:13764 "EHLO
	antoli.gallimedina.net") by vger.kernel.org with ESMTP
	id <S267516AbSKQPs3>; Sun, 17 Nov 2002 10:48:29 -0500
Date: Sun, 17 Nov 2002 16:55:22 +0100
From: Ricardo Galli <gallir@uib.es>
Message-Id: <200211171549.gAHFnSrE021923@mnm.uib.es>
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
X-UIDL: PLS!!d??!!J%,"!I'""!
Content-Type: text/plain; charset=US-ASCII
Organization: UIB
Subject: PATCH: Recognize Tualatin cache size in 2.4.x
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,
	please attach this patch to recognise the Tualatin processors' 
cache. 

I think this has been already discussed in the list, and DaveJ 
also applied it in his tree and/or 2.5.x. It is documented by
Intel.

Regards

--
  ricardo galli    GPG id C8114D34

--- /usr/src/linux-2.4.20-rc1/arch/i386/kernel/setup.c	2002-11-05 2002-11-17 16:46:32.000000000 +0100
+++ /usr/src/linux-2.4.20-rc1a/arch/i386/kernel/setup.c	2002-11-05 00:52:25.000000000 +0100
@@ -2215,6 +2215,7 @@
 	{ 0x7B, LVL_2,      512 },
 	{ 0x7C, LVL_2,      1024 },
 	{ 0x82, LVL_2,      256 },
+	{ 0x83, LVL_2,      512 },
 	{ 0x84, LVL_2,      1024 },
 	{ 0x85, LVL_2,      2048 },
 	{ 0x00, 0, 0}


