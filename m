Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266737AbUGLGaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266737AbUGLGaR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 02:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266741AbUGLGaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 02:30:17 -0400
Received: from delta.ds3.agh.edu.pl ([149.156.124.3]:18447 "EHLO
	pluto.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S266737AbUGLGaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 02:30:10 -0400
From: =?iso-8859-2?q?Pawe=B3_Sikora?= <pluto@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] `unknown symbol' in sound/oss/kahlua.ko needs unknown symbol udelay
Date: Mon, 12 Jul 2004 08:30:11 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_z/i8AlddfxXYw3G"
Message-Id: <200407120830.11565.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_z/i8AlddfxXYw3G
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)

--Boundary-00=_z/i8AlddfxXYw3G
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="kahlua.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="kahlua.patch"

--- linux-2.6.8-rc1/sound/oss/kahlua.c.orig	2004-07-11 19:35:29.000000000 +0200
+++ linux-2.6.8-rc1/sound/oss/kahlua.c	2004-07-12 08:21:15.783990896 +0200
@@ -28,6 +28,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/pci.h>

--Boundary-00=_z/i8AlddfxXYw3G--
