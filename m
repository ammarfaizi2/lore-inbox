Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUDSQB1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 12:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbUDSQB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 12:01:26 -0400
Received: from smtp.ncy.finance-net.fr ([62.161.220.65]:23308 "EHLO
	smtp.ncy.finance-net.fr") by vger.kernel.org with ESMTP
	id S261321AbUDSQA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 12:00:29 -0400
Date: Mon, 19 Apr 2004 17:59:56 +0200
From: Fabian Fenaut <fabian.fenaut@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20040312 Debian/1.4.1-0jds1
X-Accept-Language: fr
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
CC: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Sensors (W83627HF) in Tyan S2882
References: <1082387882.4083edaa52780@imp.gcu.info>
In-Reply-To: <1082387882.4083edaa52780@imp.gcu.info>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Message-Id: <S261321AbUDSQA3/20040419160029Z+1531@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare a écrit le 19.04.2004 17:18:
> Hi Fabian,
> 
>>diff -Nru drivers/i2c/chips/Kconfig.orig drivers/i2c/chips/Kconfig
>>--- drivers/i2c/chips/Kconfig.orig      Fri Apr 16 11:12:17 2004
>>+++ drivers/i2c/chips/Kconfig   Mon Apr 19 15:23:48 2004
>>@@ -158,7 +158,7 @@
>>           will be called via686a.
>>
>> config SENSORS_W83781D
>>-       tristate "Winbond W83781D, W83782D, W83783S, W83627HF, Asus AS99127F"
>>+       tristate "Winbond W83781D, W83782D, W83783S, W83682HF, Asus AS99127F"
>>         depends on I2C && EXPERIMENTAL
>>         select I2C_SENSOR
>>         help
> 
> 
> Nice catching. However the fix is not correct. "W83627HF" is the correct
> name and "W83682HF" is the typo.

You sure ? Looks like W83627HF is handled by the 2nd one, no ?

