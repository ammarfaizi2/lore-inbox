Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265874AbUEUPSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265874AbUEUPSz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 11:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265846AbUEUPSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 11:18:55 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:58576 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S265891AbUEUPSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 11:18:52 -0400
Date: Fri, 21 May 2004 11:19:44 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2.6-mm] Make i386 boot not so chatty
In-Reply-To: <20040521121021.GA23750@redhat.com>
Message-ID: <Pine.LNX.4.58.0405211115080.2864@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0405210032160.2864@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0405210101200.2864@montezuma.fsmlabs.com>
 <20040521121021.GA23750@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 May 2004, Dave Jones wrote:

> On Fri, May 21, 2004 at 01:06:23AM -0400, Zwane Mwaikambo wrote:
>
>  > Processor #0 5:2 APIC version 16
>  > Processor #3 5:2 APIC version 16
>  > Processor #4 5:2 APIC version 16
>
> I'd argue these are of little value as long as they work.
> (and we printk a different message iirc if they are unknown to us)
>
>  > Enabling APIC mode:  Flat.  Using 2 I/O APICs
>
> ditto

Agreed those were rather pointless, i initially thought i'd print out a
bit of BIOS information.

>
>  > Processors: 3
>
> a 3-way? cute.
>
>  > Built 1 zonelists
>
> useful ?
>
>  > kernel profiling enabled
>
> feh. if we cared, we could check /proc/profile or
> look for oprofilefs
>
>  > PID hash table entries: 1024 (order 10: 8192 bytes)
>
> kern_debug ?
>
>  > Calibrating delay loop... 254.97 BogoMIPS
>
> yawn

I hear people start to scream and organise lynch mobs if they can't see
their BogoMIPS line..

>  > POSIX conformance testing by UNIFIX
>
> I thought this got nuked already
>
>  > Calibrating delay loop... 266.24 BogoMIPS
>  > Calibrating delay loop... 265.21 BogoMIPS
>  > Total of 3 processors activated (786.43 BogoMIPS).
>
> Maybe just keep the last line ? kern_boring the others.

Yeah, but i wanted to leave the BogoMIPS line there for UP boxen too.
