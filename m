Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267481AbTBUOot>; Fri, 21 Feb 2003 09:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267482AbTBUOot>; Fri, 21 Feb 2003 09:44:49 -0500
Received: from hal-4.inet.it ([213.92.5.23]:27384 "EHLO hal-4.inet.it")
	by vger.kernel.org with ESMTP id <S267481AbTBUOos>;
	Fri, 21 Feb 2003 09:44:48 -0500
Content-Type: text/plain; charset=US-ASCII
From: javaman <javaman@katamail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.x, 2.4.x ...] very small
Date: Fri, 21 Feb 2003 15:25:17 +0100
X-Mailer: KMail [version 1.3.2]
Cc: torvalds@transmeta.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030221144448Z267481-29901+571@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A very small patch (my first patch :-) for Documentation/spinlocks.txt:
it replace "IFF" with "IF" ;-)

bye,
Paolo

--- Documentation/spinlocks.txt.orig	Fri Feb 21 15:02:01 2003
+++ Documentation/spinlocks.txt	Fri Feb 21 15:02:44 2003
@@ -136,7 +136,7 @@
 
 If you have a case where you have to protect a data structure across
 several CPU's and you want to use spinlocks you can potentially use
-cheaper versions of the spinlocks. IFF you know that the spinlocks are
+cheaper versions of the spinlocks. IF you know that the spinlocks are
 never used in interrupt handlers, you can use the non-irq versions:
 
 	spin_lock(&lock);

