Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbTEVD34 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 23:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbTEVD34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 23:29:56 -0400
Received: from main.gmane.org ([80.91.224.249]:28606 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262254AbTEVD3z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 23:29:55 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kevin Puetz <puetzk@puetzk.org>
Subject: Re: 2.5.69-mm7 build problem in sound/oss/cs46xx.c
Date: Wed, 21 May 2003 22:33:15 -0500
Message-ID: <bahgaf$71t$1@main.gmane.org>
References: <20030519012336.44d0083a.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: KNode/0.7.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

looks like a janitor change gone awry, easy fix though

--- sound/oss/cs46xx.c.bak      2003-05-21 22:29:20.000000000 -0500
+++ sound/oss/cs46xx.c  2003-05-21 22:29:25.000000000 -0500
@@ -946,8 +946,8 @@

 struct InitStruct
 {
-    u32 long off;
-    u32 long val;
+    u32 off;
+    u32 val;
 } InitArray[] = { {0x00000040, 0x3fc0000f},
                   {0x0000004c, 0x04800000},




