Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262349AbVCPKxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbVCPKxt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 05:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbVCPKxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 05:53:49 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30945 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262349AbVCPKxq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 05:53:46 -0500
Date: Wed, 16 Mar 2005 11:53:27 +0100
From: Pavel Machek <pavel@suse.cz>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Max Asbock <masbock@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com
Subject: Re: [RFC][PATCH] new timeofday arch specific hooks  (v. A3)
Message-ID: <20050316105326.GA1348@elf.ucw.cz>
References: <1110590655.30498.327.camel@cog.beaverton.ibm.com> <1110590710.30498.329.camel@cog.beaverton.ibm.com> <20050315225901.GB21143@elf.ucw.cz> <1110930129.30498.463.camel@cog.beaverton.ibm.com> <20050315234425.GH21292@elf.ucw.cz> <1110937497.30498.504.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110937497.30498.504.camel@cog.beaverton.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Changing its name is okay... your device probably will not have any
> > user-accessible controls, right?
> 
> Well, at some point I want to have some way for the user to be able to
> select which timesource they want to be used. Similar to the current
> "clock=" boot option override, there would be some sort of sysfs
> timesource entry that users could "echo tsc" or whatever into in order
> to force the system to use the tsc timesource at runtime.
> 
> This however would be separate from the timeofday suspend/resume hooks,
> so its probably not an issue. Let me know if I'm wrong.

No, it should not be a problem. And yes, you could probably use same
sysfs code to select timesource... Just make sure that name is stable
before you publish that interface too much.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
