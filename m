Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262996AbUEBMBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262996AbUEBMBp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 08:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbUEBMBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 08:01:45 -0400
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:1797 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S262996AbUEBMBm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 08:01:42 -0400
Date: Sun, 2 May 2004 14:01:58 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: fabian.fenaut@free.fr, sensors@Stimpy.netroedge.com,
       linux-kernel@vger.kernel.org
Subject: Re: Sensors (W83627HF) in Tyan S2882
Message-Id: <20040502140158.5fc16ca3.khali@linux-fr.org>
In-Reply-To: <20040502054229.GD31886@kroah.com>
References: <1082387882.4083edaa52780@imp.gcu.info>
	<200404191600.i3JG0ElX089970@zone3.gcu-squad.org>
	<20040419190133.351d1401.khali@linux-fr.org>
	<40840A18.8070907@free.fr>
	<20040419195034.24664469.khali@linux-fr.org>
	<4084192E.1040708@free.fr>
	<20040419204911.50cea556.khali@linux-fr.org>
	<40842F22.40009@free.fr>
	<20040502054229.GD31886@kroah.com>
Reply-To: sensors@stimpy.netroedge.com
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For some reason this patch doesn't apply at all.  Care to rediff
> against the next -mm release and resend it to me?

Actually the patch wasn't as perfect as I first thought, there were
still indentation issues. I had to rework it a bit so that it would
apply. Here is my modified version.

Thanks.

--- linux-2.6.5/drivers/i2c/chips/Kconfig	2004-04-19 21:21:19.000000000 +0200
+++ edit/drivers/i2c/chips/Kconfig	2004-04-19 21:21:53.000000000 +0200
@@ -163,7 +163,7 @@
 	select I2C_SENSOR
 	help
 	  If you say yes here you get support for the Winbond W8378x series
-	  of sensor chips: the W83781D, W83782D, W83783S and W83682HF,
+	  of sensor chips: the W83781D, W83782D, W83783S and W83627HF,
 	  and the similar Asus AS99127F.
 	  
 	  This driver can also be built as a module.  If so, the module



-- 
Jean Delvare
http://khali.linux-fr.org/
