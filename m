Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136109AbREDIwD>; Fri, 4 May 2001 04:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135986AbREDIvz>; Fri, 4 May 2001 04:51:55 -0400
Received: from bosch82.ncsa.es ([194.224.235.82]:44811 "EHLO www.bosch.es")
	by vger.kernel.org with ESMTP id <S136066AbREDIvp>;
	Fri, 4 May 2001 04:51:45 -0400
Message-ID: <3AF24CA6.10807@juridicas.com>
Date: Fri, 04 May 2001 08:31:02 +0200
From: Jorge =?ISO-8859-1?Q?Ner=EDn?= <jnerin@juridicas.com>
Reply-To: comandante@zaralinux.com
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.14 i686; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: es-es, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux SMP <linux-smp@vger.kernel.org>
Subject: Re: Memory management issues with 2.4.4
In-Reply-To: <Pine.LNX.4.21.0105021625520.4127-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

> 
> On Wed, 2 May 2001, Jorge Nerin wrote:
> 
>> Short version:
>> Under very heavy thrashing (about four hours) the system either lockups 
>> or OOM handler kills a task even when there is swap space left.
> 
> 
> First of all, please try to reproduce the problem with 2.4.5-pre1. 
> 
> If it still happens with pre1, please show us the output of "cat
> /proc/slabinfo" when the kernel is about to trigger the OOM killer.
> 
> Thanks.
> 
Well, I have tried with 2.4.5-pre1 compiled form SMP, and the result has been that this morning when I wake up the system has the console black (is there any way to prevent cons.saver from blanking the screen) and the disks where quiet, so I SysRQ-Sync, Umount, powerOff and then, at the last command the console wake up and I have been saluted with:

Kernel BUG in sched.c:709!
Invalid operand: 0000
Dump copied by hand, but not yet filtered by ksymoops (I'm at work now).
kernel panic Aiee, killing interrupt handler!
In interrupt not syncing.

This afternoon when I return home I will feed the stack dump to ksymoops and post the results, I mail this now just to see if someone sees the ligth.

-- 
Jorge Nerin
<comandante@zaralinux.com>

