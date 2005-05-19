Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVESRoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVESRoE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 13:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVESRoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 13:44:03 -0400
Received: from ns1.lanforge.com ([66.165.47.210]:54238 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S261194AbVESRmP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 13:42:15 -0400
Message-ID: <428CCFA7.6010206@candelatech.com>
Date: Thu, 19 May 2005 10:40:55 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.7) Gecko/20050417 Fedora/1.7.7-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortel.com>
CC: Arjan van de Ven <arjan@infradead.org>, linux-os@analogic.com,
       Adrian Bunk <bunk@stusta.de>, Kyle Moffett <mrmacman_g4@mac.com>,
       "Gilbert, John" <JGG@dolby.com>, linux-kernel@vger.kernel.org
Subject: Re: Illegal use of reserved word in system.h
References: <2692A548B75777458914AC89297DD7DA08B0866F@bronze.dolby.net>	 <20050518195337.GX5112@stusta.de>	 <6EA08D88-7C67-48ED-A9EF-FEAAB92D8B8F@mac.com>	 <20050519112840.GE5112@stusta.de>	 <Pine.LNX.4.61.0505190734110.29439@chaos.analogic.com> <1116505655.6027.45.camel@laptopd505.fenrus.org> <428CCD19.6030909@candelatech.com> <428CCE87.2010308@nortel.com>
In-Reply-To: <428CCE87.2010308@nortel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> Ben Greear wrote:
> 
>> It can be helpful to know what HZ you are running at, for instance if 
>> you care
>> very much about the (average) precision of a select/poll timeout.
> 
> 
> If you move the binary to a different system (or upgrade the kernel, for 
> that matter) the assumptions can be totally wrong.
> 
> This should be checked at runtime, not compile time.

If course...that is why I like the idea of some system call or standard API
to get the information.

Ben

> 
> Chris
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

