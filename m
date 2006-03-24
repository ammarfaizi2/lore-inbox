Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWCXTba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWCXTba (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 14:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWCXTba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 14:31:30 -0500
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:44891 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964802AbWCXTb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 14:31:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=OCW1VKxB/vld3ZJvWJ8DYtwtwY/gKBO507K9vhRv4bxvHi0JZ6B9vruE96ttoKv+vFw0OB0xCiLq4hatzhCHSsGOTLnchOCoaKDf2+NoNznhUsn/3LIryC5PLs/2NJpPL/c8EdcM57uHdSK2Ev9ecQtT5oCtI0wBCfEO+3B+cnM=  ;
Message-ID: <4424398F.2040300@yahoo.com.au>
Date: Sat, 25 Mar 2006 05:25:19 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Stone Wang <pwstone@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH][5/8] proc: export mlocked pages info through "/proc/meminfo:
 Wired"
References: <bc56f2f0603200537i7b2492a6p@mail.gmail.com>  <441FEFC7.5030109@yahoo.com.au> <bc56f2f0603210733vc3ce132p@mail.gmail.com> <442098B6.5000607@yahoo.com.au> <Pine.LNX.4.63.0603241133550.30426@cuia.boston.redhat.com> <442420A2.80807@yahoo.com.au> <Pine.LNX.4.63.0603241319130.30426@cuia.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.63.0603241319130.30426@cuia.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Sat, 25 Mar 2006, Nick Piggin wrote:
> 
>>Rik van Riel wrote:
>>
>>>On Wed, 22 Mar 2006, Nick Piggin wrote:
>>>
>>>
>>>>Why would you want to ever do something like that though? I don't think
>>>>you should use this name "just in case", unless you have some really good
>>>>potential usage in mind.
>>>
>>>ramfs
>>
>>Why would ramfs want its pages in this wired list? (I'm not so
>>familiar with it but I can't think of a reason).
> 
> 
> Because ramfs pages cannot be paged out, which makes them locked
> into memory the same way mlocked pages are.
> 

I don't understand why they need to be on any list though,
that isn't an internal ramfs specific structure (ie. not
the just-in-case wired list).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
