Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261733AbSLZBvF>; Wed, 25 Dec 2002 20:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261742AbSLZBvF>; Wed, 25 Dec 2002 20:51:05 -0500
Received: from [66.21.109.1] ([66.21.109.1]:49415 "EHLO
	mail.dynastytechnologies.net") by vger.kernel.org with ESMTP
	id <S261733AbSLZBvE> convert rfc822-to-8bit; Wed, 25 Dec 2002 20:51:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: Bubba <bp@dynastytech.com>
To: linux-kernel@vger.kernel.org
Subject: Re: CPU failures ... or something else ?
Date: Wed, 25 Dec 2002 20:02:24 -0600
User-Agent: KMail/1.4.3
References: <20021225175232.O6873-100000@mail.econolodgetulsa.com>
In-Reply-To: <20021225175232.O6873-100000@mail.econolodgetulsa.com>
Cc: Josh Brooks <user@mail.econolodgetulsa.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212252002.24898.bp@dynastytech.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

try turning off the Machine Check Exception in the kernel as it is just buggy 
on some machines, not necessarily a bug in the kernel, or without 
recompiling, use the kernel param "nomce"

On Wednesday 25 December 2002 19:53, Josh Brooks wrote:
> Hello,
>
> I have a dual p3 866 running 2.4 kernel that is crashing once every few
> days leaving this on the console:
>
>
> Message from syslogd@localhost at Tue Dec 24 11:30:31 2002 ...
> localhost kernel: CPU 1: Machine Check Exception: 0000000000000004
>
> Message from syslogd@localhost at Tue Dec 24 11:30:32 2002 ...
> localhost kernel: Bank 4: b200000000040151
>
> Message from syslogd@localhost at Tue Dec 24 11:30:32 2002 ...
> localhost kernel: Kernel panic: CPU context corrupt
>
>
>
> Word on the street is that this indicates hardware failure of some kind
> (cpu, bus, or memory).  My main question is, is that very surely the
> culprit, or is it also possible that all of the hardware is perfect and
> that a bug in the kernel code or some outside influence (remote exploit)
> is causing this crash ?
>
> Basically, I am ordering all new hardware to swap out, and I just want to
> know if there is some remote possibility that my hardware is actually just
> fine and this is some kind of software error ?
>
> ALSO, I have not been physically at the console when this has happened,
> and have not tried this yet, but whatever that thing is where you press
> ctrl-alt-printscreen and get to enter those post-crash commands - do you
> think that would work in this situation, or does the above error hard lock
> the system so you can't do those emergency measures ?
>
> thanks!
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
