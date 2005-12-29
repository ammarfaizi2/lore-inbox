Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964988AbVL2DNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbVL2DNl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 22:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964989AbVL2DNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 22:13:41 -0500
Received: from smtp103.plus.mail.mud.yahoo.com ([68.142.206.236]:63832 "HELO
	smtp103.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964988AbVL2DNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 22:13:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=BrVlyRH/NIMzT8tDX3v9K1Ty699TJT4CNT7BAKruhRWKjckrjQ0TqCRdnSw7BKqNdsDtA9OAXS3AS1vFYLNCuu0sV0OTkrKp6aGa7nD4huYIBchN+rKYaW/HTjoNtbZ2jhCLbH4YYKdj0R0Hzrenb4aLpvWWR/k06PqgDQm4PF4=  ;
Message-ID: <43B3545D.3010508@yahoo.com.au>
Date: Thu, 29 Dec 2005 14:13:33 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
CC: Paolo Ornati <ornati@fastwebnet.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [SCHED] Totally WRONG prority calculation with specific test-case
 (since 2.6.10-bk12)
References: <20051227190918.65c2abac@localhost>	<20051227224846.6edcff88@localhost>	<43B1D551.5050503@bigpond.net.au> <20051228112058.2c0c1137@localhost> <43B29540.1030904@bigpond.net.au>
In-Reply-To: <43B29540.1030904@bigpond.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Paolo Ornati wrote:

>>     1) nicksched: perfect! This is the behaviour I want.
>>
...
>>
>> transcode get recognized for what it is, and I/O bounded processes
>> don't even notice that it is running :)
> 
> 
> Interesting.  This one's more or less a dead scheduler and hasn't had 
> any development work done on it for some time.  I just keep porting the 
> original version to new kernels.
> 

It isn't a dead scheduler any more than any of the other out of tree
schedulers are (which isn't saying much, unfortunately).

I've probably got a small number of cleanups and microoptimisations
relative to what you have (I can't remember exactly what you sucked up)
... but other than that there hasn't been much development work done for
some time because there is not much wrong with it.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
