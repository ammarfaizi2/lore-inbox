Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751458AbWCXSQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbWCXSQh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 13:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWCXSQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 13:16:36 -0500
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:56716 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751458AbWCXSQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 13:16:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=yL18KDFV6s+SNWr2RTXf0JcbVNqIzLrWNGulag5B/EpB37FN7T+4/36iO/uCvnaoN3brbkGv0bqVKsI/MIhuqqHGxSREcxjyG594zsVNFaZejFZ+FVGl5IZU0xTRNSTaKSsgTYjMwOjfRqC9uVnqcG5n0UcwH7JHVfJ4xS7Oj3g=  ;
Message-ID: <442420A2.80807@yahoo.com.au>
Date: Sat, 25 Mar 2006 03:38:58 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Stone Wang <pwstone@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH][5/8] proc: export mlocked pages info through "/proc/meminfo:
 Wired"
References: <bc56f2f0603200537i7b2492a6p@mail.gmail.com>  <441FEFC7.5030109@yahoo.com.au> <bc56f2f0603210733vc3ce132p@mail.gmail.com> <442098B6.5000607@yahoo.com.au> <Pine.LNX.4.63.0603241133550.30426@cuia.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.63.0603241133550.30426@cuia.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Wed, 22 Mar 2006, Nick Piggin wrote:
> 
> 
>>Why would you want to ever do something like that though? I don't think 
>>you should use this name "just in case", unless you have some really 
>>good potential usage in mind.
> 
> 
> ramfs
> 

Why would ramfs want its pages in this wired list? (I'm not so
familiar with it but I can't think of a reason).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
