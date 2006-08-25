Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbWHYLbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWHYLbP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 07:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWHYLbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 07:31:15 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:40267 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751090AbWHYLbO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 07:31:14 -0400
Message-ID: <44EEE02F.3030109@sw.ru>
Date: Fri, 25 Aug 2006 15:34:07 +0400
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
Subject: Re: [Devel] [PATCH 1/6] BC: kconfig
References: <44EC31FB.2050002@sw.ru>  <44EC35A3.7070308@sw.ru> <1156370698.12011.55.camel@localhost.localdomain>
In-Reply-To: <1156370698.12011.55.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> On Wed, 2006-08-23 at 15:01 +0400, Kirill Korotaev wrote:
> 
>>--- ./arch/sparc64/Kconfig.arkcfg	2006-07-17 17:01:11.000000000 +0400
>>+++ ./arch/sparc64/Kconfig	2006-08-10 17:56:36.000000000 +0400
>>@@ -432,3 +432,5 @@ source "security/Kconfig"
>> source "crypto/Kconfig"
>> 
>> source "lib/Kconfig"
>>+
>>+source "kernel/bc/Kconfig"
> 
> ...
> 
>>--- ./arch/sparc64/Kconfig.arkcfg	2006-07-17 17:01:11.000000000 +0400
>>+++ ./arch/sparc64/Kconfig	2006-08-10 17:56:36.000000000 +0400
>>@@ -432,3 +432,5 @@ source "security/Kconfig"
>> source "crypto/Kconfig"
>> 
>> source "lib/Kconfig"
>>+
>>+source "kernel/bc/Kconfig"
> 
> 
> Is it just me, or do these patches look a little funky?  Looks like it
> is trying to patch the same thing into the same file, twice.  Also, the
> patches look to be -p0 instead of -p1.  
> 
> I'm having a few problems applying them.
Oh, it's my fault. I pasted text twice :/

Kirill
