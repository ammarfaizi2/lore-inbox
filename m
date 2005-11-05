Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbVKDX6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbVKDX6T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 18:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbVKDX6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 18:58:19 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:34468 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751045AbVKDX6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 18:58:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ckmhLZHUOnhGZdwjm9KTEbyXLwTuMlheJ5X2XHt4fbJGlJLhTViWLMcDpIPj8s3a8fqDXY+EBTM3lXFgSG8UMzA2j7mjQtamCCAfpv05QjP1YtJ89z6v6YeEHQm06LkOMqB/0WFm+1j2mm7XMp8PBNXgLIFrUlbAM3ZjBcYsy6s=  ;
Message-ID: <436BF606.3020805@yahoo.com.au>
Date: Sat, 05 Nov 2005 11:00:06 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Rohit Seth <rohit.seth@intel.com>
CC: akpm@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Clean up of __alloc_pages
References: <20051028183326.A28611@unix-os.sc.intel.com>	 <4362DF80.3060802@yahoo.com.au>	 <1130792107.4853.24.camel@akash.sc.intel.com>	 <4366C188.5090607@yahoo.com.au> <1131128108.27563.11.camel@akash.sc.intel.com>
In-Reply-To: <1131128108.27563.11.camel@akash.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rohit Seth wrote:

> 
> Nick, sorry for not responding earlier.  
> 

That's OK.

> I agree that it is slight change in behavior from original.  I doubt
> though it will impact any one in any negative way (may be for some
> higher order allocations if at all). On a little positive side, less
> frequent calls to kswapd for some cases and clear up the code a little
> bit.
> 

I really don't want a change of behaviour going in with this,
especially not one which I would want to revert anyway. But
don't get hung up with it - when you post your latest patch
I will make a patch for the changes I would like to see for it
and synch things up.

> But I really don't want to get stuck here. The pcp traversal and
> flushing is where I want to go next.  
> 

Sure, hope it goes well!

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
