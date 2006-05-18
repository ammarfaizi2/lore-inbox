Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWERXgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWERXgk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 19:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWERXgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 19:36:40 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:13991 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1751080AbWERXgj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 19:36:39 -0400
Message-ID: <446D04F5.3080802@myri.com>
Date: Fri, 19 May 2006 01:36:21 +0200
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: netdev@vger.kernel.org, gallatin@myri.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] myri10ge - Driver header files
References: <20060517220218.GA13411@myri.com>	<20060517220434.GC13411@myri.com> <20060517152817.58a6d8bc.rdunlap@xenotime.net>
In-Reply-To: <20060517152817.58a6d8bc.rdunlap@xenotime.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
>> [PATCH 2/4] myri10ge - Driver header files
>>
>>  myri10ge_mcp.h            |  205 ++++++++++++++++++++++++++++++++++++++++++++++
>>  myri10ge_mcp_gen_header.h |   58 +++++++++++++
>>     
>
> Please use "diffstat -p 1 -w 70" is documented in
> Documentation/SubmittingPatches.
>   

Ok, will do.

>> +/* 16 Bytes */
>>     
> What is 16 bytes here?
>   
>> +struct mcp_slot {
>> +	u16 checksum;
>> +	u16 length;
>> +};
>>     

Looks like I have problems to compute the size of this type.

Thanks,
Brice

