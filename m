Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751734AbWEPKJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbWEPKJh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 06:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbWEPKJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 06:09:37 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:32189 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751707AbWEPKJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 06:09:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=AQZqaqnp11nH37YjU6NGWdSwJfhH1XzNzIKHFSgpHCjKmyAS/oTPJF+05313SCdTh9xOrGszW50mrZEz9cp35lMKS26+q0mUdwLDvbI1ackoDktV8UJIp+Uw+JvhSvKv5OhmXcIq/QPaWh1QGeFSdiUmk0oN2E53Go1k3fmQlGA=  ;
Message-ID: <4469A4DA.1040305@yahoo.com.au>
Date: Tue, 16 May 2006 20:09:30 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Antti Salmela <asalmela@iki.fi>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG at mm/vmscan.c:428 (2.6.17-rc4-git2, Dualcore AMD
 x86-64)
References: <20060515082508.GA6950@asalmela.iki.fi> <44683F05.5050709@yahoo.com.au> <20060515135926.GA13151@asalmela.iki.fi>
In-Reply-To: <20060515135926.GA13151@asalmela.iki.fi>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antti Salmela wrote:
> On Mon, May 15, 2006 at 06:42:45PM +1000, Nick Piggin wrote:
> 
>>Either you have an active page on the inactive list, or your hardware has
>>flipped a bit in page->flags. I was going to say the latter is more likely,
>>however -- AFAIKS, the first oops should cause that page to be lost from the
>>LRU list, so the second oops shouldn't happen if the flip a single bad bit,
>>and should be pretty unlikely if it is a random error.
> 
> 
> Thanks, I thought I had run memtest86 long enough when I bought the
> system, but now it found one stuck bit almost immediately. 
> 

No problem. Thanks anyway for testing and reporting.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
