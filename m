Return-Path: <linux-kernel-owner+w=401wt.eu-S1751611AbXALE6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611AbXALE6m (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 23:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbXALE6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 23:58:42 -0500
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:20211 "HELO
	smtp106.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751606AbXALE6m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 23:58:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=bZdgNeLsZ4opW/uMi7Xep+uSWjYbLdJKBExLCFQMigm+GHX0ie20pHWWf4/ikhOd0Rq1dCCxZ/w/lCiVFpmHGjtYeFfLAcFaARCxhNpS688YHYW/LVpQxVNjJjOkWS8zrLSwDSFE1YJJYQLOC9AdD9OxnD4l2jF3Sf0bCjog30Q=  ;
X-YMail-OSG: FetTwQ8VM1lzKaZO4Cpe0r.yweazoIdck3zkTesQe4CEgvwgbhulMpmGJo_YB6N.07YHObn6cXMlnjNhjxxVsX4j7FaMpzg0YTzGGBN0H8Hxg5w3mlT_nQIfFiv2QJgpZBCr090Q_Xztnn8-
Message-ID: <45A71565.2030908@yahoo.com.au>
Date: Fri, 12 Jan 2007 15:58:13 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Linus Torvalds <torvalds@osdl.org>, Bill Davidsen <davidsen@tmr.com>,
       Andrew Morton <akpm@osdl.org>, Hua Zhong <hzhong@gmail.com>,
       Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, mjt@tls.msk.ru
Subject: Re: O_DIRECT question
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>  <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org>  <6d6a94c50701102150w4c3b46d0w6981267e2b873d37@mail.gmail.com>  <20070110220603.f3685385.akpm@osdl.org>  <6d6a94c50701102245g6afe6aacxfcb2136baee5cbfa@mail.gmail.com>  <20070110225720.7a46e702.akpm@osdl.org>  <45A5E1B2.2050908@yahoo.com.au> <6d6a94c50701102354l7ab41a3bp4761566204f1d992@mail.gmail.com> <45A5F157.9030001@yahoo.com.au> <45A6F70E.1050902@tmr.com> <45A70EF9.40408@yahoo.com.au> <Pine.LNX.4.64.0701112044070.3594@woody.osdl.org> <45A714F8.6020600@yahoo.com.au>
In-Reply-To: <45A714F8.6020600@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Linus Torvalds wrote:

>> Very basic issue: the perfect is the enemy of the good. Claiming that 
>> there is a "proper solution" is usually a total red herring. Quite 
>> often there isn't, and the "paper over" is actually not papering over, 
>> it's quite possibly the best solution there is.
> 
> 
> Yeah *smallish* higher order allocations are fine, and we use them all the
> time for things like stacks or networking.
> 
> But Aubrey (who somehow got removed from the cc list) wants to do order 9
> allocations from userspace in his nommu environment. I'm just trying to be
> realistic when I say that this isn't going to be robust and a userspace
> solution is needed.

Oh, and also: I don't disagree with that limiting pagecache to some %
might be useful for other reasons.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
