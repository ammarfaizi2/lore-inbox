Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265912AbUAKP0t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 10:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265914AbUAKP0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 10:26:49 -0500
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:22289 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S265912AbUAKP0r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 10:26:47 -0500
Date: Sun, 11 Jan 2004 16:28:39 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>
Subject: [PATCH 2.4] i2c cleanups, third wave (8/8)
Message-Id: <20040111162839.5324314b.khali@linux-fr.org>
In-Reply-To: <20040111144214.7a6a4e59.khali@linux-fr.org>
References: <20040111144214.7a6a4e59.khali@linux-fr.org>
Reply-To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This last patch fixes missing spaces in an error message in i2c-core.c.
Original patch by Kyösti Mälkki.

Thanks!

--- linux-2.4.25-pre4-k7/drivers/i2c/i2c-core.c	Sun Jan 11 10:33:12 2004
+++ linux-2.4.25-pre4-k8/drivers/i2c/i2c-core.c	Sun Jan 11 13:51:11 2004
@@ -359,8 +359,8 @@
 						       "unregistering driver "
 						       "`%s', the client at "
 						       "address %02x of "
-						       "adapter `%s' could not"
-						       "be detached; driver"
+						       "adapter `%s' could not "
+						       "be detached; driver "
 						       "not unloaded!",
 						       driver->name,
 						       client->addr,



-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
