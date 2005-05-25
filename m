Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbVEYTDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbVEYTDB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 15:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbVEYS4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 14:56:41 -0400
Received: from colin.muc.de ([193.149.48.1]:3590 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S262367AbVEYSvx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 14:51:53 -0400
Date: 25 May 2005 20:51:50 +0200
Date: Wed, 25 May 2005 20:51:50 +0200
From: Andi Kleen <ak@muc.de>
To: YhLu <YhLu@tyan.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050525185150.GU86087@muc.de>
References: <3174569B9743D511922F00A0C943142309F815C1@TYANWEB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3174569B9743D511922F00A0C943142309F815C1@TYANWEB>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2005 at 11:10:55AM -0700, YhLu wrote:
> Andi,
> 
> the 2.6.12-rc5 is broken in nvidia Ck804 Opteron MB.
> 
> the Core id seems to be right now.
> 
> the core 0 of node 1 can not be started and hang there.

Hmm, I tested it on a simulator only. It worked there.
Will try to double check on a real DC machine, although it is 
difficult for some other reasons.

-Andi



> 
> YH
> 
> CPU 0(2) -> Node 0 -> Core 0
> enabled ExtINT on CPU#0
> ENABLING IO-APIC IRQs
> Using IO-APIC 4
> ...changing IO-APIC physical APIC ID to 4 ... ok.
> Using IO-APIC 5
> ...changing IO-APIC physical APIC ID to 5 ... ok.
> Using IO-APIC 6
> ...changing IO-APIC physical APIC ID to 6 ... ok.
> Using IO-APIC 7
> ...changing IO-APIC physical APIC ID to 7 ... ok.
> Synchronizing Arb IDs.
> testing the IO APIC.......................
> 
> 
> 
> 
> .................................... done.
> Using local APIC timer interrupts.
> Detected 12.564 MHz APIC timer.
> Booting processor 1/1 rip 6000 rsp ffff81007ff07f58
> Initializing CPU#1
> masked ExtINT on CPU#1
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 1024K (64 bytes/line)
> CPU 1(2) -> Node 0 -> Core 1
>  stepping 00
> CPU 1: Syncing TSC to CPU 0.
> Booting processor 2/2 rip 6000 rsp ffff81013ff11f58
> Initializing CPU#2
> masked ExtINT on CPU#2
