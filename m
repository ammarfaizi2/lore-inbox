Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271705AbRHQRgJ>; Fri, 17 Aug 2001 13:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271709AbRHQRf7>; Fri, 17 Aug 2001 13:35:59 -0400
Received: from mail6.svr.pol.co.uk ([195.92.193.212]:33810 "EHLO
	mail6.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S271705AbRHQRfx>; Fri, 17 Aug 2001 13:35:53 -0400
Message-ID: <3B7D5603.8080805@humboldt.co.uk>
Date: Fri, 17 Aug 2001 18:36:03 +0100
From: Adrian Cox <adrian@humboldt.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2+) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Encrypted Swap
In-Reply-To: <Pine.LNX.3.95.1010817130849.2216A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> 
> ** At this instant, you just killed everything in RAM with precharge **

I've done a bit more reading. The documentation I have here suggests the 
precharge doesn't erase all of memory.  Precharge copies from the sense 
amplifiers back into the current row. The erasure is a result of the 
sense amplifiers losing their contents faster than the memory cells, but 
even so only one of the 2^12 rows gets erased.
-- 
Adrian Cox   http://www.humboldt.co.uk/

