Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbWAZTAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbWAZTAJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 14:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbWAZTAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 14:00:08 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:5750 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S964803AbWAZTAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 14:00:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Tf1f7c2fo08YPC0DF2HZ9vI6PFPkZ/bqsDsbQSPxX7BmT3/JPCcbHnae6T3gC3BiG1CnyRAUK4thObV31UvPMWnMFyOQf4LwpMC+DUJklwNRntejJuhQYw5juapfuZPjxW93jqgE84UTzkJsaX3bs0wIGTbAjoogBJbrJ1lIgyY=  ;
Message-ID: <43D91C33.7050401@yahoo.com.au>
Date: Fri, 27 Jan 2006 06:00:03 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Howard Chu <hyc@symas.com>, Lee Revell <rlrevell@joe-job.com>,
       Christopher Friesen <cfriesen@nortel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hancockr@shaw.ca
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
References: <20060124225919.GC12566@suse.de>  <20060124232142.GB6174@inferi.kami.home> <20060125090240.GA12651@suse.de>  <20060125121125.GH5465@suse.de> <43D78262.2050809@symas.com>  <43D7BA0F.5010907@nortel.com>  <43D7C2F0.5020108@symas.com> <1138223212.3087.16.camel@mindpipe> <43D7F863.3080207@symas.com> <43D88E55.7010506@yahoo.com.au> <43D8DB90.7070601@symas.com> <43D8E298.3020402@yahoo.com.au> <43D8E96B.3070606@symas.com> <43D8EFF7.3070203@yahoo.com.au> <43D8FC76.2050906@symas.com> <Pine.LNX.4.61.0601261231460.9298@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0601261231460.9298@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> 
> To fix the current problem, you can substitute usleep(0); It will
> give the CPU to somebody if it's computable, then give it back to
> you. It seems to work in every case that sched_yield() has
> mucked up (perhaps 20 to 30 here).
> 

That sounds like a terrible hack.

What cases has sched_yield mucked up for you, and why do you
think the problem is sched_yield mucking up? Can you solve it
using mutexes?

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
