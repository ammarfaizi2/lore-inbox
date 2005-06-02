Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVFBS5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVFBS5h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 14:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVFBS5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 14:57:37 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:63722 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261243AbVFBS4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 14:56:12 -0400
X-Comment: AT&T Maillennium special handling code - c
From: kernel-stuff@comcast.net (Parag Warudkar)
To: john stultz <johnstul@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andrew Morton <akpm@osdl.org>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Nishanth Aravamudan <nacc@us.ibm.com>, Darren Hart <darren@dvhart.com>,
       "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org
Subject: Re: [PATCH 3/4] new timeofday x86-64 arch specific changes (v. B1)
Date: Thu, 02 Jun 2005 18:51:05 +0000
Message-Id: <060220051851.27583.429F551900098EA300006BBF220588617200009A9B9CD3040A029D0A05@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Dec 17 2004)
X-Authenticated-Sender: a2VybmVsLXN0dWZmQGNvbWNhc3QubmV0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Since we do not interpolate, lost ticks no longer cause time problems
> (well, unless you're using the jiffies timesource). 
> 

That's certainly cool - no longer lost ticks!

> > Sadly, it somehow feels noticeably slower than vanilla 2.6.12-rc5.
> > Especially using X/KDE - It is surely usable but not snappy. I will do
> > more research to find out exactly why - but before that is such as
> > loss of snappiness possible due to the TOD changes?
> 
> Could you send me your dmesg output with and without using my patch? It
> could be you're using a different timesource.
> 

I can send the dmesg output later on - but when I checked it last it printed - "using acpi_pm".  Machine is a laptop and has nvidia chipset if that matters.

Parag



