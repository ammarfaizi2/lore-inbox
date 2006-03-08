Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751469AbWCHJD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbWCHJD1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 04:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbWCHJD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 04:03:27 -0500
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:51108 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751469AbWCHJD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 04:03:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=1J9vIk9HuRejviGMHJFOj6D63E7uyzr3rAZ4fxh0rqMNMrdAFChygVX2tNi4vcmNTBDjje/EK0YPOxY4bU2lng/C+P+IZ3hc25haCTdHUbsgVg3/oAm1cFdFUfxK2z6ezFeGNSVf+al7AwAfTxSqLr2y1nfG9giFygIyfTWtnls=  ;
Message-ID: <440E9DBE.209@yahoo.com.au>
Date: Wed, 08 Mar 2006 20:02:54 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: 76306.1226@compuserve.com, torvalds@osdl.org, lee.schermerhorn@hp.com,
       michaelc@cs.wisc.edu, jesper.juhl@gmail.com,
       linux-kernel@vger.kernel.org, James.Bottomley@steeleye.com
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
References: <200603080129_MC3-1-BA15-47C9@compuserve.com>	<440E969B.2080301@yahoo.com.au> <20060308004659.163b6e29.akpm@osdl.org>
In-Reply-To: <20060308004659.163b6e29.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 

>>It isn't Andrew's job to make sure a patch gets to the right place
>>until it is safely in -mm, and even then he's not always going to
>>know the severity and importance unless he's told.
> 
> 
> Is too!
> 

OK, partially. As this case illustrates, everybody makes mistakes and
you obviously can't go back and verify you got all the patches because.

The guy who hits the bug and/or writes the patch can easily see it is
still not merged and shout.

> 
>>If it was a patch to "restore" a regression in behaviour, CCs should
>>at least have gone to the author of the patch that broke it, and the
>>subsystem maintainers / list / etc as well.
> 
> 
> I actually merged Lee's patch into -mm, copied James on it and then I
> dropped it when I saw that it spat rejects against an updated version of
> James's tree, assuming that it had been merged.
> 
> Often I'll check that a patch reverts successfully from the upstream tree
> before dropping it, but for an obvious one like that I guess I didn't
> bother, and assumed that James had taken it.  Only he hadn't - instead he'd
> gone and merged something else, hence the rejects.   Oh well.
> 

You do a great job, but "push the work out to the end nodes", right?
That's how we get this network to scale. It is trivial for people to
verify their important patches have propogated as the release approaches.

(A little harder for part-timers who aren't in the loop about exactly
when the release will happen, thanks to our -ridiculous-count release
system, but still easy compared with your having to double check
everything).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
