Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266498AbUIYNi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266498AbUIYNi2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 09:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269324AbUIYNi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 09:38:28 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:51072 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266498AbUIYNi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 09:38:27 -0400
Message-ID: <415574CF.9050505@yahoo.com.au>
Date: Sat, 25 Sep 2004 23:38:23 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: ncunningham@linuxmail.org
CC: Kevin Fenzi <kevin@scrye.com>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc2-mm1 swsusp bug report.
References: <20040924021956.98FB5A315A@voldemort.scrye.com>	 <20040924143714.GA826@openzaurus.ucw.cz>	 <20040924210958.A3C5AA2073@voldemort.scrye.com>	 <1096069216.3591.16.camel@desktop.cunninghams>	 <20040925014546.200828E71E@voldemort.scrye.com>	 <1096113235.5937.3.camel@desktop.cunninghams>	 <415562FE.3080709@yahoo.com.au> <1096117005.5937.21.camel@desktop.cunninghams>
In-Reply-To: <1096117005.5937.21.camel@desktop.cunninghams>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:
> Hi.
> 
> On Sat, 2004-09-25 at 22:22, Nick Piggin wrote:
> 

>>
>>Well, by this stage it looks like memory is already pretty well shrunk
>>as much as it is going to be, which means that even a pretty capable
>>defragmenter won't be able to do anything.
> 
> 
> Surely it would be able to rearrange pages to get a contiguous megabyte?

For lots of stuff it is just infeasable. Just about all kernel memory,
for example.

But yeah, regardless, really the best thing is not to use such large
allocations at all.
