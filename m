Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424902AbWLCA2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424902AbWLCA2N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 19:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424900AbWLCA2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 19:28:13 -0500
Received: from smtp.osdl.org ([65.172.181.25]:9446 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1424898AbWLCA2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 19:28:12 -0500
Message-ID: <4572194F.8060309@osdl.org>
Date: Sat, 02 Dec 2006 16:24:47 -0800
From: Stephen Hemminger <shemminger@osdl.org>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Francois Romieu <romieu@fr.zoreil.com>
CC: Steve Wise <swise@opengridcomputing.com>, rdreier@cisco.com,
       netdev@vger.kernel.org, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH  v2 00/13] 2.6.20 Chelsio T3 RDMA Driver
References: <20061202224917.27014.15424.stgit@dell3.ogc.int> <20061202231329.GA10719@electric-eye.fr.zoreil.com>
In-Reply-To: <20061202231329.GA10719@electric-eye.fr.zoreil.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:
> Steve Wise <swise@opengridcomputing.com> :
> [...]
>   
>> Version 2 changes:
>>
>> - Make code sparse endian clean
>> - Use IDRs for mapping QP and CQ IDs to structure pointers instead of arrays
>> - Clean up confusing bitfields
>> - Use random32() instead of local random function
>> - Use krefs to track endpoint reference counts
>> - Misc nits
>>
>> -----
>>
>> The following series implements the Chelsio T3 iWARP/RDMA Driver to
>> be considered for inclusion in 2.6.20.  It depends on the Chelsio T3
>> Ethernet Driver which is also under review now for 2.6.20. See:
>>     
>
> I understood that Stephen expressed some doubts regarding the inclusion
> of TOE enabled features.
>
> Was his point addressed ?
>
>   

My comments were about different hardware.
