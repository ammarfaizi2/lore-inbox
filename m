Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbUDSSX5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 14:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbUDSSX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 14:23:57 -0400
Received: from stgeorges-1-81-56-1-93.fbx.proxad.net ([81.56.1.93]:46476 "EHLO
	garfield") by vger.kernel.org with ESMTP id S261638AbUDSSXz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 14:23:55 -0400
Message-ID: <4084192E.1040708@free.fr>
Date: Mon, 19 Apr 2004 20:23:42 +0200
From: Fabian Fenaut <fabian.fenaut@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: French/France, fr-FR, en
MIME-Version: 1.0
To: sensors@Stimpy.netroedge.com
CC: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: Sensors (W83627HF) in Tyan S2882
References: <1082387882.4083edaa52780@imp.gcu.info>	<200404191600.i3JG0ElX089970@zone3.gcu-squad.org>	<20040419190133.351d1401.khali@linux-fr.org>	<40840A18.8070907@free.fr> <20040419195034.24664469.khali@linux-fr.org>
In-Reply-To: <20040419195034.24664469.khali@linux-fr.org>
Content-Type: multipart/mixed;
 boundary="------------010602040503050104030707"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010602040503050104030707
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jean Delvare wrote:
>> Ok, so I suppose this is the appropriate patch :
> 
> Except that it doesn't apply, yes ;)
> 
> I suspect that your email client is converting tabs to spaces.

Sorry, see attachment.

--
Fabian

--------------010602040503050104030707
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

--- drivers/i2c/chips/Kconfig.orig	2004-04-19 19:05:53.000000000 +0200
+++ drivers/i2c/chips/Kconfig	2004-04-19 19:10:15.000000000 +0200
@@ -163,7 +163,7 @@
 	select I2C_SENSOR
 	help
 	  If you say yes here you get support for the Winbond W8378x series
-	  of sensor chips: the W83781D, W83782D, W83783S and W83682HF,
+	  of sensor chips: the W83781D, W83782D, W83783S and W83627HF,
 	  and the similar Asus AS99127F.
 	  
 	  This driver can also be built as a module.  If so, the module

--------------010602040503050104030707--

