Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbWHLQhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbWHLQhI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 12:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbWHLQhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 12:37:08 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:27333 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S964881AbWHLQhG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 12:37:06 -0400
Message-ID: <44DE03B0.1060607@de.ibm.com>
Date: Sat, 12 Aug 2006 18:37:04 +0200
From: Thomas Klein <osstklei@de.ibm.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>, Jan-Bernd Themann <themann@de.ibm.com>
CC: Jan-Bernd Themann <ossthema@de.ibm.com>, netdev <netdev@vger.kernel.org>,
       linux-ppc <linuxppc-dev@ozlabs.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Marcus Eder <meder@de.ibm.com>, Christoph Raisch <raisch@de.ibm.com>,
       Thomas Klein <tklein@de.ibm.com>
Subject: Re: [PATCH 3/6] ehea: queue management
References: <44D99F38.8010306@de.ibm.com> <20060811215225.GH479@krispykreme>
In-Reply-To: <20060811215225.GH479@krispykreme>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard wrote:
> Hi,
>
>   
>> --- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea_ethtool.c	1969-12-31 
>>     
>
>   
>> +static void netdev_get_pauseparam(struct net_device *dev,
>> +				  struct ethtool_pauseparam *pauseparam)
>> +{
>> +	printk("get pauseparam\n");
>> +}
>>     
>
> There are a number of stubbed out ethtool functions like this. Best not
> to implement them and allow the upper layers to return a correct error.
>
> Anton
>   
I agree, stubbs were removed.

Thomas

