Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265637AbSJSReJ>; Sat, 19 Oct 2002 13:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265638AbSJSReJ>; Sat, 19 Oct 2002 13:34:09 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:25351 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265637AbSJSReB>; Sat, 19 Oct 2002 13:34:01 -0400
Date: Sat, 19 Oct 2002 13:39:16 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Dave Olien <dmo@osdl.org>
cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.43 disk repartitioning problems
In-Reply-To: <20021018151724.A6207@acpi.pdx.osdl.net>
Message-ID: <Pine.LNX.3.96.1021019133657.28500A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2002, Dave Olien wrote:

> Hmm.  
> 
> The disks I'm working with aren't mounted and are not being used for
> swap.  There are no applications holding any partitions open.
> At the time I'm modifying a disk's partition tables, there are no users
> of any partitions on that disk.
> 
> I experimented removing and adding partitions in 2.4.18, and repeating
> those experiemnts in 2.5.43.  The two versions of OS definately
> behave differently.  

Okay, just wanted to clarify, since the stable 2.4 kernels do hold the
partition table once they use it. Of course recent ones only use the first
one in any case, but hopefully that's going to be fixed (or may have in
2.5.43-mm2, don't remember).

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

