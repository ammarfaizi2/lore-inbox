Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265510AbSIWLuC>; Mon, 23 Sep 2002 07:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265592AbSIWLuB>; Mon, 23 Sep 2002 07:50:01 -0400
Received: from smtpout.mac.com ([204.179.120.89]:21963 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S265510AbSIWLuB>;
	Mon, 23 Sep 2002 07:50:01 -0400
Date: Mon, 23 Sep 2002 13:55:10 +0200
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org,
       ingo Molnar <mingo@redhat.com>
To: Bill Davidsen <davidsen@tmr.com>
From: Peter Waechtler <pwaechtler@mac.com>
In-Reply-To: <Pine.LNX.3.96.1020923055128.11375A-100000@gatekeeper.tmr.com>
Message-Id: <4FBEDDB0-CEEB-11D6-8873-00039387C942@mac.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag den, 23. September 2002, um 12:05, schrieb Bill Davidsen:

> On Sun, 22 Sep 2002, Larry McVoy wrote:
>
>> On Sun, Sep 22, 2002 at 08:55:39PM +0200, Peter Waechtler wrote:
>>> AIX and Irix deploy M:N - I guess for a good reason: it's more
>>> flexible and combine both approaches with easy runtime tuning if
>>> the app happens to run on SMP (the uncommon case).
>>
>> No, AIX and IRIX do it that way because their processes are so bloated
>> that it would be unthinkable to do a 1:1 model.
>
> And BSD? And Solaris?

Don't know. I don't have access to all those Unices. I could try FreeBSD.

According to http://www.kegel.com/c10k.html  Sun is moving to 1:1
and FreeBSD still believes in M:N

MacOSX 10.1 does not support PROCESS_SHARED locks, tried that 5 minutes 
ago.

