Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265661AbTAFAyP>; Sun, 5 Jan 2003 19:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265667AbTAFAyP>; Sun, 5 Jan 2003 19:54:15 -0500
Received: from franka.aracnet.com ([216.99.193.44]:54427 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265661AbTAFAyO>; Sun, 5 Jan 2003 19:54:14 -0500
Date: Sun, 05 Jan 2003 16:59:05 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Paul Rolland <rol@as2917.net>, "'Randy.Dunlap'" <rddunlap@osdl.org>
cc: "'Andrew S. Johnson'" <andy@asjohnson.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.5.54 + ACPI] Slow [Was: Re: [2.5.53] So sloowwwww......]
Message-ID: <173080000.1041814744@titus>
In-Reply-To: <013701c2b4f2$3f3e0670$2101a8c0@witbe>
References: <013701c2b4f2$3f3e0670$2101a8c0@witbe>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> | | acpi= kernel parameters, I tried :
>> | |  - acpi=no-idle
>> |
>> | This one (above) is the correct syntax.
>> | Looking at the code, it only takes effect if you are using
>> only 1 CPU.
>>
>> Sorry, I was looking at old source code.
>> apm=no-idle isn't in 2.5.54.
>
> Too bad...
> Does this mean there is no easy way to have ACPI running correctly
> on my machine ?
> If anyone knows ACPI code, please tell me if you want me to run
> some specific code to understand what's going on...

I've seen this in multiple different places, and it seems to be a royal
pain in the butt. Could you log this in Bugzilla (bugme.osdl.org) so
we can track it and get it fixed? I started to log it myself, but realised
I don't really have the required information, or the data to reproduce it.
Bugs logged under Power Mangement / ACPI will automatically go to the ACPI
maintainer ...

Oh, and if you could dump /proc/interrupts, that might help ... last time
I recall some conversation about it generating millions of interrupts,
though that might be fixed by now ...

Thanks,

M

