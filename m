Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758209AbWK0Nul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758209AbWK0Nul (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 08:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758214AbWK0Nul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 08:50:41 -0500
Received: from mgw-ext11.nokia.com ([131.228.20.170]:4787 "EHLO
	mgw-ext11.nokia.com") by vger.kernel.org with ESMTP
	id S1758209AbWK0Nuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 08:50:40 -0500
Message-ID: <456AEC16.3010009@indt.org.br>
Date: Mon, 27 Nov 2006 09:45:58 -0400
From: Anderson Briglia <anderson.briglia@indt.org.br>
User-Agent: Icedove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: ext Pierre Ossman <drzeus-list@drzeus.cx>
CC: "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       ext David Brownell <david-b@pacbell.net>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 3/5] [RFC] Add MMC Password Protection (lock/unlock) support
 V7: mmc_lock_unlock.diff
References: <4564640B.1070004@indt.org.br> <45680308.4040809@drzeus.cx>
In-Reply-To: <45680308.4040809@drzeus.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Nov 2006 13:41:57.0510 (UTC) FILETIME=[CEC19260:01C71229]
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ext Pierre Ossman wrote:
> Anderson Briglia wrote:
>> @@ -244,5 +244,13 @@ struct _mmc_csd {
>>  #define SD_BUS_WIDTH_1      0
>>  #define SD_BUS_WIDTH_4      2
>>
>> +/*
>> + * MMC_LOCK_UNLOCK modes
>> + */
>> +#define MMC_LOCK_MODE_ERASE    (1<<3)
>> +#define MMC_LOCK_MODE_UNLOCK    (0<<2)
>> +#define MMC_LOCK_MODE_CLR_PWD    (1<<1)
>> +#define MMC_LOCK_MODE_SET_PWD    (1<<0)
>> +
>>  #endif  /* MMC_MMC_PROTOCOL_H */
>>
> 
> This definition makes them look like bits, which is not how they are used.

How can I improve this? Defining using integers directly?

> 
> Rgds
> 

