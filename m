Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316199AbSIGPEs>; Sat, 7 Sep 2002 11:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316842AbSIGPEs>; Sat, 7 Sep 2002 11:04:48 -0400
Received: from smtpout.mac.com ([204.179.120.89]:52702 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S316199AbSIGPEq>;
	Sat, 7 Sep 2002 11:04:46 -0400
Date: Sat, 7 Sep 2002 16:16:44 +0200
Subject: Re: [PATCH] POSIX message queues
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: Ingo Molnar <mingo@elte.hu>, Amos Waterland <apw@us.ibm.com>,
       golbi@mat.uni.torun.pl, linux-kernel@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
From: pwaechtler@mac.com
In-Reply-To: <20020906100406.C35@toy.ucw.cz>
Message-Id: <6FC8546C-C26C-11D6-87AD-00039387C942@mac.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag den, 6. September 2002, um 12:04, schrieb Pavel Machek:

> Hi!
>
>>> That is the fundamental problem with a userspace shared memory
>>> implementation: write permissions on a message queue should grant
>>> mq_send(), but write permissions on shared memory grant a lot more 
>>> than
>>> just that.
>>
>> is it really a problem? As long as the read and write queues are 
>> separated
>> per sender, all that can happen is that a sender is allowed to read his
>> own messages - that is not an exciting capability.
>
> Imagine something that writes data into the que then erases the data and
> gets rid of setuid.
>
Well, I can imagine that - but what do you mean by that?
Do you mean: replacing the data with shellcode, manipulating the length 
field
for provoking buffer overflows?

