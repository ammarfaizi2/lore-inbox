Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263199AbUD2D6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbUD2D6p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 23:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263174AbUD2D5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 23:57:52 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:58013 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263173AbUD2D5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 23:57:44 -0400
Message-ID: <40907AF2.2020501@yahoo.com.au>
Date: Thu, 29 Apr 2004 13:48:02 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Marc Singer <elf@buici.com>
CC: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       brettspamacct@fastclick.com, linux-kernel@vger.kernel.org,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
References: <409021D3.4060305@fastclick.com> <20040428170106.122fd94e.akpm@osdl.org> <409047E6.5000505@pobox.com> <40904A84.2030307@yahoo.com.au> <20040429005801.GA21978@buici.com>
In-Reply-To: <20040429005801.GA21978@buici.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Singer wrote:
> On Thu, Apr 29, 2004 at 10:21:24AM +1000, Nick Piggin wrote:
> 
>>Anyway, I have a small set of VM patches which attempt to improve
>>this sort of behaviour if anyone is brave enough to try them.
>>Against -mm kernels only I'm afraid (the objrmap work causes some
>>porting difficulty).
> 
> 
> Is this the same patch you wanted me to try?  
> 
>   Remember, the embedded system where NFS IO was pushing my
>   application out of memory.  Setting swappiness to zero was a
>   temporary fix.
> 
> 

Yes this is the same patch I wanted you to try. Yes I
remember your problem!

Didn't anyone come up with a patch for you to test the
stale PTE theory? If so, what where the results?

