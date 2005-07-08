Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262718AbVGHR27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262718AbVGHR27 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 13:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262724AbVGHR27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 13:28:59 -0400
Received: from alog0552.analogic.com ([208.224.223.89]:35808 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262718AbVGHR26
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 13:28:58 -0400
Date: Fri, 8 Jul 2005 13:27:33 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Adnan Khaleel <Adnan.Khaleel@newisys.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Instruction Tracing for Linux
In-Reply-To: <DC392CA07E5A5746837A411B4CA2B713010D7790@sekhmet.ad.newisys.com>
Message-ID: <Pine.LNX.4.61.0507081318480.16726@chaos.analogic.com>
References: <DC392CA07E5A5746837A411B4CA2B713010D7790@sekhmet.ad.newisys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please read:
http://www.adapti.com/instruction-trace.html

It's part of an advertisement, but will tell you the problems
you will have with a "software solution". Basically, software
can't do it. Also, even hardware won't give you the real
picture because there is too much going on inside the CPUs
that you can't see. However a hardware/software solution
can produce some useful information but it's not very accurate.


On Fri, 8 Jul 2005, Adnan Khaleel wrote:

> Hi there,
>
> I'm a hardware designer and I'm interested in collecting dynamic execution traces in Linux. I've looked at several trace toolkits available for Linux currently but none of them offer the level of detail that I need. Ideally I would like to be able to record the instructions being executed on an SMP system along with markers for system or user space in addition to process id. I need these traces in order to evaluate the data sharing, coherence traffic etc in larger SMP systems. I've tried several other approaches to collecting execution traces namely via machine emulators etc but so far I've been dogged with the problem of trying to get any OS up and running stably on a multiprocessor configuration.
>
> Is there a Linux kernel patch that will let me do this? I have considered using User Mode Linux but I'm not sure if this is the correct approach either - if any of you think that this is the easier path, I'd be interested in exploring this more. Other things that have crossed my mind is to use a gdb or the kernel debugger interface in order to collect the instructions but I'm not sure if this would be the correct path. Also I do require the tool/patch to be  stable enough so that I can run commercial benchmarks on it reliably.
>
> I understand that recording every executed instruction can considerably slow down the application and may be considerably different from the freely running application but nevertheless I think that some trace is better than no trace and this is where I am at the moment.
>
> If any of you have had experiences in profiling the kernel etc by collecting actual kernel instructions executed, I'd be interested in seeing if that may be extended for my purpose.
>
> Thanks
>
> Adnan
>
> PS: I'm not subscribed to this mailing list so I'd appreciated if you would cc me on the responses.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
