Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262067AbTCVJVs>; Sat, 22 Mar 2003 04:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262074AbTCVJVs>; Sat, 22 Mar 2003 04:21:48 -0500
Received: from newglider.melbpc.org.au ([203.12.152.9]:37644 "EHLO
	relay9.melbpc.org.au") by vger.kernel.org with ESMTP
	id <S262067AbTCVJVr>; Sat, 22 Mar 2003 04:21:47 -0500
Message-ID: <3E7C2BA0.4040100@melbpc.org.au>
Date: Sat, 22 Mar 2003 20:23:44 +1100
From: Tim Josling <tej@melbpc.org.au>
Organization: Melbourne PC User Group
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Philip.Blundell@pobox.com, linux-parport@torque.net
Subject: Re: [PATCH] to drivers/parport/ieee1284_ops.c to fix timing dependent
 hang
References: <3E782567.3020008@melbpc.org.au> <1048278154.6017.2.camel@ixodes.goop.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.3.4(snapshot 20020706) (relay9)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy,

Good to know someone has read my email.

According to my reading of the code, it should only happen in polled 
mode, but I have only one week of experience looking at kernel source.

So it should be a work-around, assuming interrupts work on the parallel 
port on your system :-). It is an very vexing problem, as I'm sure you know.

By the way, LJ1100s tend to get page feeding problems about the time the 
warranty runs out, but HP has a free kit you can order to fix the problem.

Tim Josling

Jeremy Fitzhardinge wrote:
> On Wed, 2003-03-19 at 00:08, Tim Josling wrote:
> 
>>I have an HP1100 printer and since I upgraded to a faster CPU the 
>>printer has started hanging. The problem persisteed across 2.0 2.2 and 
>>2.4 kernel versions. I am running Red Hat Linux 8.0 on a Compaq Armada E500.
>>
>>The problem occurs intermittently. The symptom is that the 'buffer 
>>contains data' light stays on on the printer, but data transfer stops.
> 
> 
> Ah, so that's why that happens.  I've been getting the same thing with
> my LJ1100.
> 
> Is this just in polled mode?  Does using interrupts constitute a
> work-around for the hang?
> 
> 	J
> 
> 
> 


