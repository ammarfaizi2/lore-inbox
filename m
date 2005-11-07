Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbVKGBnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbVKGBnT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 20:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbVKGBnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 20:43:18 -0500
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:11639 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932399AbVKGBnS (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 6 Nov 2005 20:43:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=oTg3eDr9Vka3jRdibPqWm5ckbfz0Ia19WxertTqpa2C3RpalaqNii4zHuI5fz4eu5QWKRqK7jmW+IjoM+rOAMVZuIxGEZFvV99WIe2Gs0gSNEUbj32YRsaHbOsz0uSLsriszkHQArGXwJlAiLUTtovpxj3HDLYKgpOG9a+48zoY=  ;
Message-ID: <436EB1B6.60004@yahoo.com.au>
Date: Mon, 07 Nov 2005 12:45:26 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: [patch 5/14] mm: set_page_refs opt
References: <436DBAC3.7090902@yahoo.com.au> <436DBCBC.5000906@yahoo.com.au> <436DBCE2.4050502@yahoo.com.au> <436DBD11.8010600@yahoo.com.au> <436DBD31.8060801@yahoo.com.au> <436DBD82.2070500@yahoo.com.au> <20051107014031.GB9170@infradead.org>
In-Reply-To: <20051107014031.GB9170@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Sun, Nov 06, 2005 at 07:23:30PM +1100, Nick Piggin wrote:
> 
>>5/14
>>
>>-- 
>>SUSE Labs, Novell Inc.
>>
> 
> 
>>Inline set_page_refs. Remove mm/internal.h
> 
> 
> So why don't you keep the inline function in mm/internal.h?  this isn't
> really stuff we want driver writers to use every.
> 
> 

There are plenty of things in the linux/ headers which driver
writers shouldn't use.

Although I think your idea is a good one, and one has to start
somewhere. I'll make that change, thanks.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
