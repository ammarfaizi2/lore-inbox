Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbVC3Bbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbVC3Bbh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 20:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbVC3Bbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 20:31:33 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:25182 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261472AbVC3Bbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 20:31:31 -0500
Message-ID: <424A0172.2010609@yahoo.com.au>
Date: Wed, 30 Mar 2005 11:31:30 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Industry db benchmark result on recent 2.6 kernels
References: <200503300046.j2U0keg03321@unix-os.sc.intel.com> <Pine.LNX.4.58.0503291656060.6036@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503291656060.6036@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 29 Mar 2005, Chen, Kenneth W wrote:
> 
>>Linus Torvalds wrote on Tuesday, March 29, 2005 4:00 PM
>>
>>>The fact that it seems to fluctuate pretty wildly makes me wonder
>>>how stable the numbers are.
>>
>>I can't resist myself from bragging. The high point in the fluctuation
>>might be because someone is working hard trying to make 2.6 kernel run
>>faster.  Hint hint hint .....  ;-)
> 
> 
> Heh. How do you explain the low-point? If there's somebody out there 
> working hard on making it run slower, I want to whack the guy ;)
> 

If it is doing a lot of mapping/unmapping (or fork/exit), then that
might explain why 2.6.11 is worse.

Fortunately there are more patches to improve this on the way.

Kernel profiles would be useful if possible.

