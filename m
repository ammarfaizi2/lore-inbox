Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751021AbWHUL0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbWHUL0h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 07:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbWHUL0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 07:26:36 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:23160 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751021AbWHUL0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 07:26:36 -0400
Message-ID: <44E99904.80205@sw.ru>
Date: Mon, 21 Aug 2006 15:29:08 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: rohitseth@google.com
CC: Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC: kernel	memory	accounting	(core)
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>	<1155754029.9274.21.camel@localhost.localdomain>	<1155755729.22595.101.camel@galaxy.corp.google.com>	<1155758369.9274.26.camel@localhost.localdomain>	<1155774274.15195.3.camel@localhost.localdomain>	<1155824788.9274.32.camel@localhost.localdomain>	<1155835003.14617.45.camel@galaxy.corp.google.com>	<1155835401.9274.64.camel@localhost.localdomain>	<1155836198.14617.61.camel@galaxy.corp.google.com>	<44E58059.6020605@sw.ru> <1155922680.23242.7.camel@galaxy.corp.google.com>
In-Reply-To: <1155922680.23242.7.camel@galaxy.corp.google.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>in case of anon_vma, page->mapping can be the same
>>for 2 pages beloning to different containers.
>>
> 
> 
> In your experience, have you seen processes belonging to different
> containers sharing the same anon_vma?  On a more general note, could you
> please point me to a place that has the list of requirements for which
> we are designing this solution.
> 
> 
>>>>nor is it ambiguous in any way.  It is very strict,
>>>>and very straightforward.
>>>
>>>What additional ambiguity you have when inode or task structures have
>>>the required information.
>>
>>inodes can belong to multiple containers and so do the pages.
>>
> 
> 
> I'm still thinking that inodes should belong to one container (or may be
> have it configurable based on some flag).
this is not true for OpenVZ nor Linux-VServer.

Thanks,
Kirill
