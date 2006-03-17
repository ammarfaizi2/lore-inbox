Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbWCQAm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWCQAm5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 19:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWCQAm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 19:42:57 -0500
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:4741 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751342AbWCQAm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 19:42:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=A7nzTku05V5j0xFMK4csAXVKMYGyr82MW7zEmNsPe1QZzMjOKfV0OLXmHDcnWfeOzfwYqCM5oasVXSioLfeWedpzm1W4taCwzKLxCIhShz1EpzptakgEgH+Ujp2b9YUZRfHMbHJ9LEzspFYhNxVdZtjcMEP3kFYfrvQijBNjMmg=  ;
Message-ID: <441A05D2.7070803@yahoo.com.au>
Date: Fri, 17 Mar 2006 11:41:54 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jonathan Corbet <corbet@lwn.net>, akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: Re: RFC: radix tree safety
References: <20060316171320.1572.qmail@lwn.net>
In-Reply-To: <20060316171320.1572.qmail@lwn.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>How about making the code self-documenting and more useful at the same
>>time: put RADIX_TREE_TAGS in radix-tree.h, and call it RADIX_TREE_MAX_TAGS
> 
> 
> I like that idea - how's the following?  I also took the liberty of
> making the tag arguments be unsigned, since that is clearly the way they
> are intended to be used.
>

Looks really good. Andrew will you pick it up?

> jon
> 
> 
> Documentation changes to help radix tree users avoid overrunning the
> tags array.  RADIX_TREE_TAGS moves to linux/radix-tree.h and is now
> known as RADIX_TREE_MAX_TAGS (Nick Piggin's idea).  Tag parameters are
> changed to unsigned, and some comments are updated.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

...

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
