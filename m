Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbVJFHJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbVJFHJl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 03:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbVJFHJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 03:09:41 -0400
Received: from xproxy.gmail.com ([66.249.82.200]:36398 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750745AbVJFHJl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 03:09:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=sVofNLK6yl2n66s3aikBUJL/8jHanY6CuoH7utrWjA9FEH4hdmvXRCASkIcu2IQFkyzAZ6gtpq6gAmizbrXbAyuckWqWD7PmO5C/GIGsREC6IuNaGkfj0JzZsWc/VIoUC8bOPlY7AXlueD4pZMb3xM+nWZFQcIjBAqMCi3FQedc=
Message-ID: <4344F820.6010701@gmail.com>
Date: Thu, 06 Oct 2005 10:10:40 +0000
From: Alon Bar-Lev <alon.barlev@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lorenzo Colitti <lorenzo@colitti.com>
CC: Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <ncunningham@cyclades.com>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [swsusp] separate snapshot functionality to separate file
References: <200510032339.08217.rjw@sisk.pl> <20051003231715.GA17458@elf.ucw.cz> <200510041711.13408.rjw@sisk.pl> <20051004205334.GC18481@elf.ucw.cz> <1128465272.6611.75.camel@localhost> <20051005084141.GB22034@elf.ucw.cz> <434443D9.3010501@colitti.com> <20051005224418.GA22781@elf.ucw.cz> <4344599B.7060308@colitti.com> <20051005225727.GE22781@elf.ucw.cz> <20051005230045.GA22906@elf.ucw.cz> <43445F51.7090403@colitti.com>
In-Reply-To: <43445F51.7090403@colitti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lorenzo Colitti wrote:
> Pavel Machek wrote:
> 
>> "Cool, so you have done 100% of work and now it is stable, fast and
>> tested. You only need to do 200% more work to get it merged".
>>
>> Merging into kernel is not easy, sorry.
> > 
> It works, it's fast, it's stable, and it does what users want. That's a 
> strong combination. It would be really good if you could work together 
> to merge it.
> 
> 
> Cheers,
> Lorenzo
> 

Hello,

I've read this thread...
And I want to join this request...

It might be that suspend2 is not the best solution, but 
maybe if you merge it and then work together in order to 
maximize the use of user space at next version, it will be 
slower process but at least the interfaces suspend2 provides 
will be available to users.

I understand the wish to minimize kernel mode usage... But 
first you should support a decent suspend disk/suspend ram 
support in Linux without forcing the user to hack his 
configuration.

At my culture we say: "The enemy of the good is the best"...

Best Regards,
Alon Bar-Lev.
