Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbVFBSdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVFBSdO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 14:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVFBSdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 14:33:12 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:24039 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261227AbVFBSdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 14:33:02 -0400
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
Date: Thu, 02 Jun 2005 18:27:51 +0000
Message-Id: <060220051827.15835.429F4FA6000DF9D700003DDB220588617200009A9B9CD3040A029D0A05@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Dec 17 2004)
X-Authenticated-Sender: a2VybmVsLXN0dWZmQGNvbWNhc3QubmV0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you grab Linus' current tree it should apply.
> 
> Sorry about the confusion.
> -john

I ignored the reject since it was from an #include section - the build went fine. I am even able to use it successfully. Couple things -

Very happy to report that I no longer get those annoying - "losing some ticks ..." "your time source is unreliable or some driver is hogging interrupts" messages - Not sure what change in TOD subsystem cured it - or was it just the removal of the printk? ;) 

Sadly, it somehow feels noticeably slower than vanilla 2.6.12-rc5. Especially using X/KDE - It is surely usable but not snappy. I will do more research to find out exactly why - but before that is such as loss of snappiness possible due to the TOD changes?

Thanks
Parag


