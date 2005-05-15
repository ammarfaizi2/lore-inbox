Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbVEOKR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbVEOKR0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 06:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbVEOKR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 06:17:26 -0400
Received: from mail.suse.de ([195.135.220.2]:10722 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261580AbVEOKRX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 06:17:23 -0400
Date: Sun, 15 May 2005 12:17:05 +0200
From: Andi Kleen <ak@suse.de>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Christoph Lameter <clameter@engr.sgi.com>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Nishanth Aravamudan <nacc@us.ibm.com>, Darren Hart <darren@dvhart.com>,
       "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org, linux-ia64@vger.kernel.org
Subject: Re: IA64 implementation of timesource for new time of day subsystem
Message-ID: <20050515101705.GC26242@wotan.suse.de>
References: <1116029796.26454.2.camel@cog.beaverton.ibm.com> <1116029872.26454.4.camel@cog.beaverton.ibm.com> <1116029971.26454.7.camel@cog.beaverton.ibm.com> <1116030058.26454.10.camel@cog.beaverton.ibm.com> <1116030139.26454.13.camel@cog.beaverton.ibm.com> <Pine.LNX.4.62.0505141251490.18681@schroedinger.engr.sgi.com> <428722E3.6040202@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428722E3.6040202@superbug.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Will this mean that Linux will have a monotonic time source?

2.6 has had one for a long time (posix_gettime(CLOCK_MONOTONIC))

-Andi
