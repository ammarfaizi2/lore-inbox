Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbUEEDYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbUEEDYm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 23:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbUEEDYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 23:24:42 -0400
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:28251 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261680AbUEEDYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 23:24:39 -0400
Message-ID: <40985E73.6000901@yahoo.com.au>
Date: Wed, 05 May 2004 13:24:35 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Andrew Morton <akpm@osdl.org>, sgoel01@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [VM PATCH 2.6.6-rc3-bk5] Dirty balancing in the presence of mapped
 pages
References: <20040505002029.11785.qmail@web12821.mail.yahoo.com>	<20040504180345.099926ec.akpm@osdl.org>	<40984E89.6070501@yahoo.com.au> <20040504195753.0a9e4a54.akpm@osdl.org> <40985C91.9080809@yahoo.com.au>
In-Reply-To: <40985C91.9080809@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Andrew Morton wrote:
> 
>> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>>

>>> It doesn't do the wakeup_bdflush thing, but that sounds
>>> like a good idea. What does wakeup_bdflush(-1) mean?
>>
>>
>>
>> It appears that it will cause pdflush to write out down to
>> dirty_background_ratio.
>>
> 
> Yeah. So wakeup_bdflush(0) would be more consistent?
> 

No. Sorry, next time I'll actually read the code :|
