Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWJHBj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWJHBj4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 21:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWJHBj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 21:39:56 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:34944 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750717AbWJHBjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 21:39:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=s0wLR5NDQzrrtCX/7x5r8Rriu3m3MiUIALwDIy1CDzg6AIpNovZkCyx/yfCVl/HaKoFf8gZXk5Q05FFs0CKHl6Hdvz/+RpWiIfr04L71J5fT9VP538JDsFEFDLnI8zpIi0xSdf+qzwzxILMtq9wIwtVm6MfcOtOn/FC7ecY79UQ=  ;
Message-ID: <452856E4.60705@yahoo.com.au>
Date: Sun, 08 Oct 2006 11:39:48 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060216 Debian/1.7.12-1.1ubuntu2
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 3/3] mm: add arch_alloc_page
References: <20061007105758.14024.70048.sendpatchset@linux.site>	<20061007105824.14024.85405.sendpatchset@linux.site> <20061007134345.0fa1d250.akpm@osdl.org>
In-Reply-To: <20061007134345.0fa1d250.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>On Sat,  7 Oct 2006 15:06:04 +0200 (CEST)
>Nick Piggin <npiggin@suse.de> wrote:
>
>
>>Add an arch_alloc_page to match arch_free_page.
>>
>
>umm.. why?
>

I had a future patch to more kernel_map_pages into it, but couldn't
decide if that's a generic kernel feature that is only implemented in
2 architectures, or an architecture speicifc feature. So I left it out.

But at least Martin wanted a hook here for his volatile pages patches,
so I thought I'd submit this patch anyway.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
