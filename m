Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWCMKrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWCMKrO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 05:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWCMKrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 05:47:13 -0500
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:55444 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932123AbWCMKrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 05:47:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=sySDQPjLs0BbfWqTyxsLqDuCNcwWodWNkGQr6f8mchQ0KCN+dTfWrTIgJUbGmkfR2OdFoWWtVnENAHnyWSWodL64usERABvsqD3o7rE1QTLdAw+yDWdGtFTdPktwYuQWZ6nNJh7bF7e9oukeT98T0QK1oo79rmcYX2V/zHH0Stw=  ;
Message-ID: <44154DAC.6050006@yahoo.com.au>
Date: Mon, 13 Mar 2006 21:47:08 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Petr Vandrovec <petr@vandrovec.name>, linux-kernel@vger.kernel.org,
       sam@ravenborg.org, kai@germaschewski.name
Subject: Re: [PATCH] Do not rebuild full kernel tree again and again...
References: <20060312172511.GA17936@vana.vc.cvut.cz> <20060312174250.GA1470@mars.ravnborg.org> <44150CD7.604@yahoo.com.au> <20060313091254.GA28231@mars.ravnborg.org>
In-Reply-To: <20060313091254.GA28231@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Mon, Mar 13, 2006 at 05:10:31PM +1100, Nick Piggin wrote:
> 
>>Sam Ravnborg wrote:
>>
>>
>>>This issue has been discussed with Paul D. Smith which also provided
>>>a patch similar to yours.
>>>The patch is in the kbuild queue for 2.6.17.
>>>But we also agreed to postpose this change in make until next stable
>>>release. So if you update your make to latest CVS version you will no
>>>longer see this misbehaviour.
>>>And when 2.6.17 opens up kbuild will be 'fixed' in mainline kernel.
>>>
>>
>>So what's going to be done about 2.6.16?
>>
>>I'm seeing this behaviour too in -rc6 and it is a bad regression
>>for a developer. I assume there will be some workaround?
> 
> I assume debian soon will update make to current version from CVS that
> has this behaviour removed.
> 

So long as it just requires a tools update then that's fine for me.
Thanks.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
