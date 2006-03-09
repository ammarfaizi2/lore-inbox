Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751537AbWCIW5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbWCIW5j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 17:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751636AbWCIW5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 17:57:39 -0500
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:5565 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751517AbWCIW5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 17:57:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=b3y1uB7bvu//8mQQaCkGviP5EF9/SDFglOhs/vYfOHl8+A9zfY7Hhx2iMIgQixUPGPpVL1anb/hx1lzD5iHWrpo73Rax6UER+nSEszJc4GVIg5S+CdIxgWmv+VLUTF+W4NuwXYFK+BxRn2onWPAXlDA5AuIV6pcUk/2qDaMEJ3s=  ;
Message-ID: <4410B2D7.4090806@yahoo.com.au>
Date: Fri, 10 Mar 2006 09:57:27 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
CC: Ingo Molnar <mingo@elte.hu>, Heiko Carstens <heiko.carstens@de.ibm.com>,
       Steven Rostedt <rostedt@goodmis.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rt20, "bad page state", jackd
References: <1141846564.5262.20.camel@cmn3.stanford.edu>	 <20060309084746.GB9408@osiris.boeblingen.de.ibm.com> <1141938488.22708.28.camel@cmn3.stanford.edu>
In-Reply-To: <1141938488.22708.28.camel@cmn3.stanford.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fernando Lopez-Lezcano wrote:

> In my case it is completely repeatable. 
> Boot, start jackd, stop jackd -> problem appears. 
> 
> This does not happen on all computers so it would seem to me it is
> related to the sound drivers. I'll try to see if there is a correlation
> with the sound card being used. 
> 
> Is there anything else I could do to try to help resolve this?

Can you test with the latest mainline -git snapshot, or is it only
the -rt tree that causes the warnings?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
