Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbWEMTEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbWEMTEd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 15:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbWEMTEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 15:04:33 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:27879 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S932496AbWEMTEc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 15:04:32 -0400
Message-ID: <44662BED.5030000@myri.com>
Date: Sat, 13 May 2006 20:56:45 +0200
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
       "Andrew J. Gallatin" <gallatin@myri.com>
Subject: Re: [PATCH 6/6] myri10ge - Kconfig and Makefile
References: <446259A0.8050504@myri.com> <44625E9B.3090509@myri.com> <20060513185157.GC6931@stusta.de>
In-Reply-To: <20060513185157.GC6931@stusta.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Wed, May 10, 2006 at 11:43:55PM +0200, Brice Goglin wrote:
>   
>> ...
>> --- linux-mm/drivers/net/Makefile.old	2006-04-08 04:49:53.000000000 -0700
>> +++ linux-mm/drivers/net/Makefile	2006-04-21 08:10:27.000000000 -0700
>> @@ -192,6 +192,7 @@ obj-$(CONFIG_R8169) += r8169.o
>>  obj-$(CONFIG_AMD8111_ETH) += amd8111e.o
>>  obj-$(CONFIG_IBMVETH) += ibmveth.o
>>  obj-$(CONFIG_S2IO) += s2io.o
>> +obj-$(CONFIG_MYRI10GE) += myri10ge/
>>  obj-$(CONFIG_SMC91X) += smc91x.o
>>  obj-$(CONFIG_SMC911X) += smc911x.o
>>  obj-$(CONFIG_DM9000) += dm9000.o
>> --- /dev/null	2006-04-21 00:45:09.064430000 -0700
>> +++ linux-mm/drivers/net/myri10ge/Makefile	2006-04-21 08:14:21.000000000 -0700
>> @@ -0,0 +1,5 @@
>> +#
>> +# Makefile for the Myricom Myri-10G ethernet driver
>> +#
>> +
>> +obj-$(CONFIG_MYRI10GE) += myri10ge.o
>>     
>
> If the driver consists of one source file, why does it need an own 
> subdir?
>
> cu
> Adrian
>   


We also have 2 header files. But, I am fine with putting our 3 files in
drivers/net/ instead.

Brice

