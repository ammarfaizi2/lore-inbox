Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWF2Mm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWF2Mm4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 08:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWF2Mm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 08:42:56 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:63374 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750791AbWF2Mmy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 08:42:54 -0400
Message-ID: <44A3CAC9.7080003@watson.ibm.com>
Date: Thu, 29 Jun 2006 08:42:49 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jay Lan <jlan@engr.sgi.com>
CC: Andrew Morton <akpm@osdl.org>, balbir@in.ibm.com, csturtiv@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in taskstats
References: <44892610.6040001@watson.ibm.com>	<20060609010057.e454a14f.akpm@osdl.org>	<448952C2.1060708@in.ibm.com>	<20060609042129.ae97018c.akpm@osdl.org>	<4489EE7C.3080007@watson.ibm.com>	<449999D1.7000403@engr.sgi.com>	<44999A98.8030406@engr.sgi.com>	<44999F5A.2080809@watson.ibm.com>	<4499D7CD.1020303@engr.sgi.com>	<449C2181.6000007@watson.ibm.com>	<20060623141926.b28a5fc0.akpm@osdl.org>	<449C6620.1020203@engr.sgi.com>	<20060623164743.c894c314.akpm@osdl.org>	<449CAA78.4080902@watson.ibm.com>	<20060623213912.96056b02.akpm@osdl.org>	<449CD4B3.8020300@watson.ibm.com>	<44A01A50.1050403@sgi.com>	<20060626105548.edef4c64.akpm@osdl.org>	<44A020CD.30903@watson.ibm.com>	<20060626111249.7aece36e.akpm@osdl.org>	<44A026ED.8080903@sgi.com>	<20060626113959.839d72bc.akpm@osdl.org>	<44A2F50D.8030306@engr.sgi.com> <20060628145341.529a61ab.akpm@osdl.org> <44A2FC72.9090407@engr.sgi.com>
In-Reply-To: <44A2FC72.9090407@engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan wrote:

>Andrew Morton wrote:
>  
>
>>>The ENOBUFS i experienced in my testing would start to happen
>>>when exit rate at around 14000 exits/sec. While our fields confirmed
>>>that a 1000 threads exit/sec was a real, i have no reason to be
>>>concerned of 14000 exits/sec rate. ;)
>>>   
>>>      
>>>
>>1000 exits/sec/CPU can happen.  How many CPUs did that machine have?
>> 
>>    
>>
>
>The test machine was a 2 CPU IA64.
>  
>
Increasing the receive buffer size for the netlink socket may help.

--Shailabh


