Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271141AbTHRAQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 20:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271144AbTHRAQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 20:16:27 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:37248 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S271141AbTHRAQ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 20:16:26 -0400
Date: Mon, 18 Aug 2003 01:16:16 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>,
       Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: NMI appears to be stuck! (2.4.22-rc2 on dual Athlon)
Message-ID: <20030818001616.GA4761@mail.jlokier.co.uk>
References: <20030817212824.GA9025@www.13thfloor.at> <20030817221114.GA734@alpha.home.local> <20030817222843.GB10967@www.13thfloor.at> <Pine.LNX.4.53.0308171822391.9067@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0308171822391.9067@montezuma.mastecende.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> > > mine works fine only with nmi_watchdog=2. Don't know why. 
> > > It's an ASUS A7M266D.
> > 
> > hmm, nmi_watchdog=2 on the kernel boot line gives no
> > difference to booting without, at least according to
> > the boot messages ...
> 
> nmi_watchdog=2 will work on the majority of i686+ (performance 
> counters with NMI delivery mode) boxes and you can check whether it's 
> enabled by doing cat /proc/interrupts and watching if the NMI line ticks 
> at a decent rate. nmi_watchdog=1 tends to be harder for hardware 
> manufacturers to get right (for some reason or other).

Is it possible to try both at boot time and pick the one which works?

-- Jamie
