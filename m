Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbUDST5m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 15:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbUDST5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 15:57:42 -0400
Received: from stgeorges-1-81-56-1-93.fbx.proxad.net ([81.56.1.93]:56716 "EHLO
	garfield") by vger.kernel.org with ESMTP id S261802AbUDST5l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 15:57:41 -0400
Message-ID: <40842F22.40009@free.fr>
Date: Mon, 19 Apr 2004 21:57:22 +0200
From: Fabian Fenaut <fabian.fenaut@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: French/France, fr-FR, en
MIME-Version: 1.0
To: sensors@stimpy.netroedge.com
CC: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: Sensors (W83627HF) in Tyan S2882
References: <1082387882.4083edaa52780@imp.gcu.info>	<200404191600.i3JG0ElX089970@zone3.gcu-squad.org>	<20040419190133.351d1401.khali@linux-fr.org>	<40840A18.8070907@free.fr>	<20040419195034.24664469.khali@linux-fr.org>	<4084192E.1040708@free.fr> <20040419204911.50cea556.khali@linux-fr.org>
In-Reply-To: <20040419204911.50cea556.khali@linux-fr.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare wrote:
>>> Except that it doesn't apply, yes ;)
>>> 
>>> I suspect that your email client is converting tabs to spaces.
>> 
>> Sorry, see attachment.
> 
> 
> I forgot to tell you... Patches are prefered in such a form that
> patch -p1 from inside the linux directory works. Yours don't. I don't
> think Greg will like it. That said, I don't think Greg likes patches
> as attachements anyway ;)


Ok, same player shoot again...


--- linux-2.6.5/drivers/i2c/chips/Kconfig	2004-04-19 21:21:19.000000000 
+0200
+++ edit/drivers/i2c/chips/Kconfig	2004-04-19 21:21:53.000000000 +0200
@@ -163,7 +163,7 @@
  	select I2C_SENSOR
  	help
  	  If you say yes here you get support for the Winbond W8378x series
-	  of sensor chips: the W83781D, W83782D, W83783S and W83682HF,
+	  of sensor chips: the W83781D, W83782D, W83783S and W83627HF,
  	  and the similar Asus AS99127F.
  	
  	  This driver can also be built as a module.  If so, the module

