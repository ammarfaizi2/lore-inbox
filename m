Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266669AbUBLWfy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 17:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266655AbUBLWfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 17:35:53 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:420 "HELO mail.iinet.net.au")
	by vger.kernel.org with SMTP id S266669AbUBLWfp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 17:35:45 -0500
Message-ID: <402BFF39.2070701@cyberone.com.au>
Date: Fri, 13 Feb 2004 09:33:29 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Haverkamp <markh@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, Christine Moore <cem@osdl.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: 2.6.3-rc2-mm1
References: <20040212015710.3b0dee67.akpm@osdl.org>	 <402B6251.2060909@cyberone.com.au> <1076600437.22976.3.camel@markh1.pdx.osdl.net>
In-Reply-To: <1076600437.22976.3.camel@markh1.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mark Haverkamp wrote:

>On Thu, 2004-02-12 at 03:24, Nick Piggin wrote:
>
>>Andrew Morton wrote:
>>
>>
>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3-rc2/2.6.3-rc2-mm1/
>>>
>>>
>>>
>>Nether this nor the previous one boots on the NUMAQ at osdl.
>>Not sure which is the last -mm that did. 2.6.3-rc2 boots.
>>
>>I turned early_printk on and nothing. It stops at
>>Loading linux..............
>>
>
>I saw this behavior with the last mm kernel on my 8-way with
>CONFIG_HIGHMEM64G.  The problem went away when I backed out the
>highmem-equals-user-friendliness.patch
>
>

It boots with this patch backed out. Thanks Mark.

