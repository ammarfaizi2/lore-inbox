Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbVHaXGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbVHaXGw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 19:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbVHaXGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 19:06:51 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:26810 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S964911AbVHaXGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 19:06:51 -0400
Message-ID: <431637EF.10803@nortel.com>
Date: Wed, 31 Aug 2005 17:06:23 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
CC: joe.korty@ccur.com, akpm@osdl.org, george@mvista.com, johnstul@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: FW: [RFC] A more general timeout specification
References: <F989B1573A3A644BAB3920FBECA4D25A042B0187@orsmsx407>
In-Reply-To: <F989B1573A3A644BAB3920FBECA4D25A042B0187@orsmsx407>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Aug 2005 23:06:24.0996 (UTC) FILETIME=[9C391240:01C5AE80]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perez-Gonzalez, Inaky wrote:

>>I can get the first sleep.  Suppose I oversleep by X nanoseconds.  I
>>wake, and get an opaque timeout back.  How do I ask for the new wake
>>time to be "endtime + INTERVAL"?
> 
> 
> endtime.ts += INTERVAL
> [we all know opaque is relative too] 

Heh. Okay, then what are the rules about what I'm allowed to do with 
endtime?  Joe mentioned there was a bit in there somewhere to denote 
absolute time.

> Or better, use itimers :)

I as actually thinking in terms of implementing itimers on top of your 
new API.

Chris

