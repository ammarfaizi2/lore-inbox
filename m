Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131612AbRAESIz>; Fri, 5 Jan 2001 13:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131624AbRAESIp>; Fri, 5 Jan 2001 13:08:45 -0500
Received: from mercury.nildram.co.uk ([195.112.4.37]:60173 "EHLO
	mercury.nildram.co.uk") by vger.kernel.org with ESMTP
	id <S131612AbRAESIb>; Fri, 5 Jan 2001 13:08:31 -0500
Message-Id: <200101051808.f05I8Ll01898@mercury.nildram.co.uk>
From: "Per Jessen" <per.jessen@enidan.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Fri, 05 Jan 2001 18:08:55 
Reply-To: "Per Jessen" <per.jessen@enidan.com>
X-Mailer: PMMail 98 Professional (2.01.1600) For Windows 95 (4.0.1111)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: How to Power off with ACPI/APM?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2001 10:33:06 +0100, J . A . Magallon wrote:

>
>On 2001.01.05 Dominik Kubla wrote:
>> On Fri, Jan 05, 2001 at 10:18:46AM +0100, J . A . Magallon wrote:
>> > 
>> > Silly question, but have you realized that you don't have to enable
>> > SMP in kernel to do multithreading ?
>> > 
>> 
>> That depends on your definition: If you really want to run multiple
>> threads simultaneously (as opposed to concurrent i guess) i imagine
>> you will either need more than one CPU or one of those new beasties
>> which support multiple threads in parallel on their various execution
>> units...
>> 
>
>Nope. You can run multiple threads "simultaneously" on an uniprocessor,
>so simultaneous as the rest of the processes the cpu is running.
>Of course the efficiency of multi-threading drops on an uni-processor
>if your threads only do hard math work and no IO, but a thread can
>be crunchin numbers at the same time one other is waiting for IO even
>on a one cpu box. Think on an app that does read-process-write in loop.
>Two parallel threads on an uniprocessor can overlap IO and process
>and be more efficient than a non-threaded version.

Uh, I guess it is partially a matter of interpretation, but IMHO you
cannot have concurrent processing on a uni-processor (one instruction
stream). One thread at a time will be executing (ie. active on the processor), 
and only one. 
You can however easily do multi-processing/multi-threading on a uni-
processor.


regards,
Per Jessen, Principal Engineer, ENIDAN Technologies
http://www.enidan.com - home of the J1 serial console.





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
