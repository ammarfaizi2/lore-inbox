Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271605AbTGRKe2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 06:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271617AbTGRKe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 06:34:27 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:17674 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S271605AbTGRKeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 06:34:24 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200307181049.h6IAnFi00440@devserv.devel.redhat.com>
Subject: Re: new raid server crashed - no idea why!
To: raz@macs.hw.ac.uk (Ross Macintyre)
Date: Fri, 18 Jul 2003 06:49:15 -0400 (EDT)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org,
       linux-megaraid-devel@dell.com, salvini@macs.hw.ac.uk,
       donald@macs.hw.ac.uk
In-Reply-To: <SIMEON.10307181006.C@pcraz.macs.hw.ac.uk> from "Ross Macintyre" at Gor 18, 2003 10:37:06 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > guess fro the traces and the fact the dual athlons are infamously 
> > sensitive about ram
> 
> Could you be a bit more specific about this please?

I have a near endless series of dual athlon bug reporta that go

	It crashes randomly
	Run memtest86
	It says lots of bad things

In paticular if you have more than two banks of RAM on dual athlon boards it
almost always has to be registered DIMM.

> swap the memory about and run memtest86 on the problem machine's memory 
> in the other machine. (I am assuming here that the machine needs to be 
> shut down to run memtest86?)

Only if its another identical dual athlon and then you'd be better
running the other one and testing the one with the problem.

> to have it crashing on me, but before I test the memory, I want to have 
> looked at all the other possibilities first.
> Any more suggestions?

Until you've checked the memory - not really.
