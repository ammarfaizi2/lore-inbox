Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbUAUUor (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 15:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264142AbUAUUor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 15:44:47 -0500
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:9746 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S263850AbUAUUop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 15:44:45 -0500
Date: Wed, 21 Jan 2004 21:47:05 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com,
       rusty@rustcorp.com.au
Subject: Re: [PATCH] i2c driver fixes for 2.6.1
Message-Id: <20040121214705.12a0a4a9.khali@linux-fr.org>
In-Reply-To: <20040120220750.GA3944@kroah.com>
References: <10745567571488@kroah.com>
	<1074556757661@kroah.com>
	<20040120230322.24cbe005.khali@linux-fr.org>
	<20040120220750.GA3944@kroah.com>
Reply-To: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Or just send me a patch, backing out your change, I'll apply that :)

Here you are. Sorry again for the noise.

--------------------------------

Undo a recent change to the i2c documentation. The change belongs to
2.7.

--- linux-2.6.2-rc1/Documentation/i2c/porting-clients.orig	Wed Jan 21 21:41:04 2004
+++ linux-2.6.2-rc1/Documentation/i2c/porting-clients	Wed Jan 21 21:41:12 2004
@@ -92,10 +92,7 @@
   i2c_get_clientdata(client) instead.
 
 * [Interface] Init function should not print anything. Make sure
-  there is a MODULE_LICENSE() line. MODULE_PARM() is replaced
-  by module_param(). Note that module_param has a third parameter,
-  that you should set to 0 by default. See include/linux/moduleparam.h
-  for details.
+  there is a MODULE_LICENSE() line.
 
 Coding policy:
 


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
