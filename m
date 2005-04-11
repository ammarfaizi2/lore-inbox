Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbVDKGg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbVDKGg5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 02:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbVDKGg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 02:36:56 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:20321 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261705AbVDKGgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 02:36:51 -0400
Message-ID: <425A1AF6.2010909@yahoo.com.au>
Date: Mon, 11 Apr 2005 16:36:38 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Claudio Martins <ctpm@rnl.ist.utl.pt>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: Processes stuck on D state on Dual Opteron
References: <200504050316.20644.ctpm@rnl.ist.utl.pt> <200504100328.53762.ctpm@rnl.ist.utl.pt> <20050409194746.69cfa230.akpm@osdl.org> <200504110138.51872.ctpm@rnl.ist.utl.pt>
In-Reply-To: <200504110138.51872.ctpm@rnl.ist.utl.pt>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Claudio Martins wrote:
> On Sunday 10 April 2005 03:47, Andrew Morton wrote:
> 
>>Suggest you boot with `nmi_watchdog=0' to prevent the nmi watchdog from
>>cutting in during long sysrq traces.
>>
>>Also, capture the `sysrq-m' output so we can see if the thing is out of
>>memory.
> 
> 
>   Hi Andrew,
> 
>   Thanks for the tip. I booted with nmi_watchdog=0 and was able to get a full 
> sysrq-t as well as a sysrq-m. Since it might be a little too big for the 
> list, I've put it on a text file at:
> 
>  http://193.136.132.235/dl145/dump1-2.6.12-rc2.txt
> 
>  I also made a run with the mempool-can-fail patch from Nick Piggin. With this 
> I got some nice memory allocation errors from the md threads when the trouble 
> started. The dump (with sysrq-t and sysrq-m included) is at:
> 
>  http://193.136.132.235/dl145/dump2-2.6.12-rc2-nick1.txt
> 
>  Let me know if you find it more convenient to send the dumps by mail or 
> something. Hope this helps.
> 

Itried to get these just now, but couldn't.

Would you gzip them and send them to me privately?

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

