Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263834AbUE1TvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263834AbUE1TvR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 15:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263826AbUE1TvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 15:51:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21918 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263847AbUE1TsT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 15:48:19 -0400
Message-ID: <40B79774.50405@pobox.com>
Date: Fri, 28 May 2004 15:48:04 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Patrick Finnegan <pat@computer-refuge.org>, linux-kernel@vger.kernel.org,
       rth@twiddle.net
Subject: Re: [PATCH] Alpha compile error on 2.6.7-rc1
References: <200405281405.30638.pat@computer-refuge.org> <20040528191104.GA2370@holomorphy.com>
In-Reply-To: <20040528191104.GA2370@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Fri, May 28, 2004 at 02:05:30PM -0500, Patrick Finnegan wrote:
> 
>>Machine is a 21164A Alpha (164LX motherboard).  The error is:
>>  CC      arch/alpha/mm/init.o
>>arch/alpha/mm/init.c: In function `show_mem':
>>arch/alpha/mm/init.c:120: structure has no member named `count'
>>make[1]: *** [arch/alpha/mm/init.o] Error 1
>>make: *** [arch/alpha/mm] Error 2
>>Patch is below.
>>Alpha: Fixup arch/alpha/mm/init.c to match struct page changes 
> 
> 
> Might be a better idea to use page_count(&mem_map[i]).

which is what current -BK does...

	Jeff



