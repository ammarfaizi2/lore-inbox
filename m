Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271308AbTHRHW3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 03:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271310AbTHRHW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 03:22:29 -0400
Received: from [66.212.224.118] ([66.212.224.118]:30727 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S271308AbTHRHW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 03:22:28 -0400
Date: Mon, 18 Aug 2003 03:10:36 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Jamie Lokier <jamie@shareable.org>
Cc: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>,
       Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: NMI appears to be stuck! (2.4.22-rc2 on dual Athlon)
In-Reply-To: <20030818001616.GA4761@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.53.0308180300250.11674@montezuma.mastecende.com>
References: <20030817212824.GA9025@www.13thfloor.at> <20030817221114.GA734@alpha.home.local>
 <20030817222843.GB10967@www.13thfloor.at> <Pine.LNX.4.53.0308171822391.9067@montezuma.mastecende.com>
 <20030818001616.GA4761@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Aug 2003, Jamie Lokier wrote:

> > nmi_watchdog=2 will work on the majority of i686+ (performance 
> > counters with NMI delivery mode) boxes and you can check whether it's 
> > enabled by doing cat /proc/interrupts and watching if the NMI line ticks 
> > at a decent rate. nmi_watchdog=1 tends to be harder for hardware 
> > manufacturers to get right (for some reason or other).
> 
> Is it possible to try both at boot time and pick the one which works?

I believe we currently already do that if you do nmi_watchdog=2
