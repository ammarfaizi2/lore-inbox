Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVFBSjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVFBSjR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 14:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVFBSjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 14:39:17 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:39128 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261205AbVFBSjM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 14:39:12 -0400
Date: Thu, 2 Jun 2005 11:39:04 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: john stultz <johnstul@us.ibm.com>, Andi Kleen <ak@suse.de>,
       lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andrew Morton <akpm@osdl.org>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org
Subject: Re: [PATCH 3/4] new timeofday x86-64 arch specific changes (v. B1)
Message-ID: <20050602183904.GC2636@us.ibm.com>
References: <060220051827.15835.429F4FA6000DF9D700003DDB220588617200009A9B9CD3040A029D0A05@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <060220051827.15835.429F4FA6000DF9D700003DDB220588617200009A9B9CD3040A029D0A05@comcast.net>
X-Operating-System: Linux 2.6.12-rc5 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.06.2005 [18:27:51 +0000], Parag Warudkar wrote:
> > If you grab Linus' current tree it should apply.
> > 
> > Sorry about the confusion.
> > -john
> 
> I ignored the reject since it was from an #include section - the build
> went fine. I am even able to use it successfully. Couple things -
> 
> Very happy to report that I no longer get those annoying - "losing
> some ticks ..." "your time source is unreliable or some driver is
> hogging interrupts" messages - Not sure what change in TOD subsystem
> cured it - or was it just the removal of the printk? ;) 
> 
> Sadly, it somehow feels noticeably slower than vanilla 2.6.12-rc5.
> Especially using X/KDE - It is surely usable but not snappy. I will do
> more research to find out exactly why - but before that is such as
> loss of snappiness possible due to the TOD changes?

Which timesource is being used?

cat /sys/devices/system/timesource/timesource0/timesource

Thanks,
Nish
