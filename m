Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263541AbUCTVSY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 16:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263543AbUCTVSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 16:18:24 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:31194 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S263541AbUCTVSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 16:18:23 -0500
Date: Sat, 20 Mar 2004 13:17:56 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>
cc: markw@osdl.org, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm2
Message-ID: <2701550000.1079817475@[10.10.2.4]>
In-Reply-To: <405BC760.9090107@cyberone.com.au>
References: <20040314172809.31bd72f7.akpm@osdl.org>	<200403181737.i2IHbCE09261@mail.osdl.org>	<20040318100615.7f2943ea.akpm@osdl.org>	<20040318192707.GV22234@suse.de>	<20040318191530.34e04cb2.akpm@osdl.org>	<20040318194150.4de65049.akpm@osdl.org>	<20040319183906.I8594@osdlab.pdx.osdl.net>	<20040319185026.56db3bf7.akpm@osdl.org>	<20040319185345.A4610@osdlab.pdx.osdl.net>	<405BC003.6080507@cyberone.com.au> <20040319201450.5da6847a.akpm@osdl.org> <405BC760.9090107@cyberone.com.au>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> This machine is I/O-bound, the CPUs are mostly idle.  It would appear to be
>> some interaction between the I/O system and the CPU scheduler.  Haven't we
>> seen that with reaim also?
> 
> I can't remember how much CPU reaim uses, I thought it was
> quite a lot (ie. not IO bound).

aim / reaim supports multiple different workloads (including custom ones) - 
whether it's IO bound or CPU bound depends on which you pick.

M.


