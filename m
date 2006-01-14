Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWANSDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWANSDB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 13:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWANSDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 13:03:01 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:16028 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750745AbWANSDA (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sat, 14 Jan 2006 13:03:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=SXOL+WFNrWUSmdHl9fzlCvi41QUSysbvVQlS0pH0uZ1WpPXYazOYzgxztxM4WWJaAB5LruRkBP3641FZvNNOWMRfkZPgi5Z1J8hY+oT69NlYKA4/QL3h/yrqrIBoAP16XnS35dSoR5VNsKygYP6XMyC82SaTD5d43b0kgG/pMIM=  ;
Message-ID: <43C93CCA.9080503@yahoo.com.au>
Date: Sun, 15 Jan 2006 05:02:50 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: [patch] mm: cleanup bootmem
References: <43C8F198.3010609@yahoo.com.au> <Pine.LNX.4.64.0601140949460.13339@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601140949460.13339@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 14 Jan 2006, Nick Piggin wrote:
> 
>>Objections?
> 
> 
> The whole point of the pre-batching was that apparently the non-batched 
> bootmem code took ages to boot in simulation with lots of memory. I think 
> it was the ia64 people who used simulation a lot. So..
> 
> 		Linus
> 

Changelog doesn't mention it: a226f6c899799fe2c4919daa0767ac579c88f7bd

Or... what do you mean by pre-batching? (maybe I'm confused and you're
talking about my prefetching change or something)

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
