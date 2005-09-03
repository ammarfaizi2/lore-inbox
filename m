Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161139AbVICFa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161139AbVICFa1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 01:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161141AbVICFa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 01:30:27 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:57479 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1161139AbVICFa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 01:30:26 -0400
Subject: Re: [PATCH 1/3] Updated dynamic tick patches - Fix lost
	tick	calculation in timer_pm.c
From: Lee Revell <rlrevell@joe-job.com>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: vatsa@in.ibm.com, linux-kernel@vger.kernel.org, arjan@infradead.org,
       s0348365@sms.ed.ac.uk, kernel@kolivas.org, tytso@mit.edu,
       cfriesen@nortel.com, trenn@suse.de, george@mvista.com,
       johnstul@us.ibm.com, akpm@osdl.org
In-Reply-To: <43193169.3090801@comcast.net>
References: <20050831165843.GA4974@in.ibm.com>
	 <20050831171211.GB4974@in.ibm.com> <1125720301.4991.41.camel@mindpipe>
	 <43193169.3090801@comcast.net>
Content-Type: text/plain
Date: Sat, 03 Sep 2005 01:30:23 -0400
Message-Id: <1125725424.4991.45.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.8 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-09-03 at 01:15 -0400, Parag Warudkar wrote:
> Lee Revell wrote:
> 
> > Are lost ticks really that common? If so, any idea what's disabling
> >
> >interrupts for so long (or if it's a hardware issue)?  And if not, it
> >seems like you'd need an artificial way to simulate lost ticks in order
> >to test this stuff.
> >
> >Lee
> >  
> >
> Yes - I know many people with laptops who have this lost ticks problem. 
> So no simulation and/or
> special efforts required.  If anyone wants a test bed - my laptop is the 
> perfect instrument.
> 
> In my case the rip is always as acpi_processor_idle now a days. Earlier 
> it used to be at acpi_ec_read.

Ah, OK, I forgot about SMM traps.

Lee

