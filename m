Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964997AbWH2OeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964997AbWH2OeJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 10:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964995AbWH2OeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 10:34:09 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:62227 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964999AbWH2OeG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 10:34:06 -0400
Message-ID: <44F4511D.7000903@sw.ru>
Date: Tue, 29 Aug 2006 18:37:17 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: devel@openvz.org
CC: Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>, Greg KH <greg@kroah.com>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       Matt Helsley <matthltc@us.ibm.com>, Rohit Seth <rohitseth@google.com>,
       Oleg Nesterov <oleg@tv-sign.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Devel] [PATCH 6/6] BC: kernel memory accounting (marks)
References: <44EC31FB.2050002@sw.ru>  <44EC371F.7080205@sw.ru> <1156374231.12011.61.camel@localhost.localdomain>
In-Reply-To: <1156374231.12011.61.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> On Wed, 2006-08-23 at 15:08 +0400, Kirill Korotaev wrote:
> 
>> include/asm-i386/thread_info.h   |    4 ++--
>> include/asm-ia64/pgalloc.h       |   24 +++++++++++++++++-------
>> include/asm-x86_64/pgalloc.h     |   12 ++++++++----
>> include/asm-x86_64/thread_info.h |    5 +++-- 
> 
> 
> Do you think we need to cover a few more architectures before
> considering merging this, or should we just fix them up as we need them?
I think doing a part of job is usually bad as it never gets fixed fully then :/

> I'm working on a patch to unify as many of the alloc_thread_info()
> functions as I can.  That should at least give you one place to modify
> and track the thread_info allocations.  I've only compiled for x86_64
> and i386, but I'm working on more.  A preliminary version is attached.
Oh, I think such code unification is nice!
Would be perferct if all of them could be merged to some generic
function. Please, keep me on CC!

Thanks,
Kirill

