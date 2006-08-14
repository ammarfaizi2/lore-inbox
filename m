Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751900AbWHNG5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbWHNG5z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 02:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbWHNG5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 02:57:55 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:52215 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751900AbWHNG5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 02:57:54 -0400
Message-ID: <44E015D5.8040301@de.ibm.com>
Date: Mon, 14 Aug 2006 08:19:01 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: michael@ellerman.id.au
CC: Anton Blanchard <anton@samba.org>, Thomas Klein <tklein@de.ibm.com>,
       netdev <netdev@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ppc <linuxppc-dev@ozlabs.org>,
       Christoph Raisch <raisch@de.ibm.com>, Marcus Eder <meder@de.ibm.com>
Subject: Re: [PATCH 4/6] ehea: header files
References: <44D99F56.7010201@de.ibm.com> <20060811214020.GG479@krispykreme> <1155525611.7807.4.camel@localhost.localdomain>
In-Reply-To: <1155525611.7807.4.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman wrote:
> On Sat, 2006-08-12 at 07:40 +1000, Anton Blanchard wrote:
>> Hi,
>>
>>>  drivers/net/ehea/ehea.h    |  452 
>>> +#define EHEA_DRIVER_NAME	"IBM eHEA"
>> You are using this for ethtool get_drvinfo. Im not sure if it should
>> match the module name, and I worry about having a space in the name. Any
>> ideas on what we should be doing here?
> 
> I believe it must match the module name. It also might be nice to call
> it "DRV_NAME" like most other network drivers do.
> 
> cheers
> 


We rename EHEA_DRIVER_NAME to DRV_NAME (and EHEA_DRIVER_VERSION
to DRV_VERSION) and assign "ehea" to it

Jan-Bernd
