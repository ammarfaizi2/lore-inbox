Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262623AbRE3FqU>; Wed, 30 May 2001 01:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262616AbRE3FqK>; Wed, 30 May 2001 01:46:10 -0400
Received: from [203.143.19.4] ([203.143.19.4]:39442 "EHLO kitul.learn.ac.lk")
	by vger.kernel.org with ESMTP id <S262615AbRE3FqC>;
	Wed, 30 May 2001 01:46:02 -0400
Date: Wed, 30 May 2001 00:48:12 +0600 (LKT)
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: Scott Murray <scott@spiteful.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] compiler warning fix in opl3sa2.c
Message-ID: <Pine.LNX.4.21.0105300040080.308-100000@presario>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch fixes a compiler warning of opl3sa2.c.

Regards,

Anuradha

----------------------------------
http://www.bee.lk/people/anuradha/


diff -rua linux-2.4.5/drivers/sound/opl3sa2.c linux/drivers/sound/opl3sa2.c
--- linux-2.4.5/drivers/sound/opl3sa2.c	Tue May 29 23:42:11 2001
+++ linux/drivers/sound/opl3sa2.c	Wed May 30 00:34:00 2001
@@ -810,7 +810,7 @@
 struct isapnp_device_id isapnp_opl3sa2_list[] __initdata = {
 	{	ISAPNP_ANY_ID, ISAPNP_ANY_ID,
 		ISAPNP_VENDOR('Y','M','H'), ISAPNP_FUNCTION(0x0021),
-		NULL },
+		0 },
 	{0}
 };


