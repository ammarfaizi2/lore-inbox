Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263383AbTCNRB2>; Fri, 14 Mar 2003 12:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263394AbTCNRB2>; Fri, 14 Mar 2003 12:01:28 -0500
Received: from [80.190.48.67] ([80.190.48.67]:64518 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id <S263383AbTCNRB1> convert rfc822-to-8bit; Fri, 14 Mar 2003 12:01:27 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.21pre5aa1
Date: Fri, 14 Mar 2003 18:10:54 +0100
User-Agent: KMail/1.4.3
References: <20030314090825.GB1375@dualathlon.random> <200303141437.11589.m.c.p@wolk-project.de>
In-Reply-To: <200303141437.11589.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200303141810.54234.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 March 2003 14:39, Marc-Christian Petersen wrote:

Hi Andrea,

> > Only in 2.4.21pre5aa1: 22_sched-deadlock-mmdrop-1
> > 	Backport from 2.5 (in a more icache friendy way) an anti-deadlock
> > 	fix for the o1 scheduler that can otherwise send a cross IPI with
> > 	irq disabled.

> I get _tons_ of these messages:
>
> Initializing RT netlink socket
> rq->prev_mm was c025b0e0 set to c025b0e0 - swapper
> dffddf4c c0115786 c023b1a0 c025b0e0 c025b0e0 dffdc24e dffddfbc dffce02c
>        dffdc000 00000000 dffdc000 dffddfbc c0105000 0008e000 c01072bd
> 00000700 c0125d00 c02916a8 dffddfbc c0105000 0008e000 00000002 c01e0018
> ....

I am going to rip out 22_sched-deadlock-mmdrop-1 because I dunno how to fix 
this. The trace is annoying ;)

ciao, Marc


