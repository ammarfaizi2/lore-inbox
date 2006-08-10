Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161322AbWHJPGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161322AbWHJPGz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 11:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161320AbWHJPGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 11:06:54 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:36307 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1161322AbWHJPGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 11:06:53 -0400
Message-ID: <44DB4B8A.60006@de.ibm.com>
Date: Thu, 10 Aug 2006 17:06:50 +0200
From: Thomas Klein <osstklei@de.ibm.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Jan-Bernd Themann <ossthema@de.ibm.com>, netdev <netdev@vger.kernel.org>,
       linux-ppc <linuxppc-dev@ozlabs.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Marcus Eder <meder@de.ibm.com>, Christoph Raisch <raisch@de.ibm.com>,
       Thomas Klein <osstklei@de.ibm.com>
Subject: Re: [PATCH 5/6] ehea: makefile
References: <44D99F74.1000704@de.ibm.com> <20060809095047.GA11555@mars.ravnborg.org>
In-Reply-To: <20060809095047.GA11555@mars.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Wed, Aug 09, 2006 at 10:40:20AM +0200, Jan-Bernd Themann wrote:
>   
>> Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
>>
>>
>>  drivers/net/ehea/Makefile |    7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>>
>>
>> --- linux-2.6.18-rc4-orig/drivers/net/ehea/Makefile	1969-12-31 
>> 16:00:00.000000000 -0800
>> +++ kernel/drivers/net/ehea/Makefile	2006-08-08 23:59:38.083467216 -0700
>> @@ -0,0 +1,7 @@
>> +#
>> +# Makefile for the eHEA ethernet device driver for IBM eServer System p
>> +#
>> +
>> +ehea_mod-objs = ehea_main.o ehea_phyp.o ehea_qmr.o ehea_ethtool.o 
>> ehea_phyp.o
>> +obj-$(CONFIG_EHEA) += ehea_mod.o
>> +
>>     
>
> Using -objs is deprecated, please use ehea_mod-y.
> This needs to be documented and later warned upon which I will do soon.
>
> 	Sam
>   
Done. Will be included in next patch.

