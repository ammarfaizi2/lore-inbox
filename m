Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317887AbSGKUEP>; Thu, 11 Jul 2002 16:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317888AbSGKUEO>; Thu, 11 Jul 2002 16:04:14 -0400
Received: from mail7.svr.pol.co.uk ([195.92.193.21]:46152 "EHLO
	mail7.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S317887AbSGKUEN>; Thu, 11 Jul 2002 16:04:13 -0400
Posted-Date: Thu, 11 Jul 2002 20:06:51 GMT
Date: Thu, 11 Jul 2002 21:06:50 +0100 (BST)
From: Riley Williams <rhw@InfraDead.Org>
Reply-To: Riley Williams <rhw@InfraDead.Org>
To: Tom Rini <trini@kernel.crashing.org>
cc: Justin Hibbits <jrh29@po.cwru.edu>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Michael Elizabeth Chastain <mec@shout.net>
Subject: Re: Patch for Menuconfig script
In-Reply-To: <20020708181838.GL695@opus.bloom.county>
Message-ID: <Pine.LNX.4.21.0207112100010.9595-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom.

>>>>> This is just a patch to the Menuconfig script (can be easily adapted
>>>>> to the other ones) that allows you to configure the kernel without
>>>>> the requirement of bash (I tested it with ksh, in POSIX-only mode).  
>>>>> Feel free to flame me :P
>>>>
>>>> Does it also work in the case where the current shell is csh or tcsh
>>>> (for example)?
>>>
>>> Er.. why wouldn't it?
>>> $ head -1 scripts/Menuconfig 
>>> #! /bin/sh
>>>
>>> So this removes the /bin/sh is not bash test, yes?
>>
>>  Q> # ls -l /bin/sh | tr -s '\t' ' '
>>  Q> lrwxrwxrwx 1 root root 4 May 7 1999 /bin/sh -> tcsh
>>  Q> #
>>
>> You tell me - the above is from one of the systems I regularly use,
>> which does not even have bash installed...
> 
> So does tcsh work as a POSIX-sh when invoked as /bin/sh ?

You tell me - what exactly defines "a POSIX-sh" ???

All I know is, the system in question does the job it's intended to, and
that's about all the operators care about.

Probably of more interest is this: Prior to your tweaks, the Menuconfig
script just reported that one was trying to run it under the wrong
shell. What happens when one tries to run your modified version under
those conditions? There are only two valid answers:

 1. It runs successfully.

 2. It reports that it can't run under that shell.

You're the one proposing the patch, so you're the one who needs to
answer that question.

Best wishes from Riley.

