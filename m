Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbWBCTaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbWBCTaT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 14:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945916AbWBCTaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 14:30:18 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:26838
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1945915AbWBCTaR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 14:30:17 -0500
Subject: Re: time function behaving strane
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: john stultz <johnstul@us.ibm.com>
Cc: Conio sandiago <coniodiago@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1138994370.10057.129.camel@cog.beaverton.ibm.com>
References: <993d182d0602022015j70bff250x2524c6c5917be2a7@mail.gmail.com>
	 <1138994370.10057.129.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 03 Feb 2006 20:30:33 +0100
Message-Id: <1138995034.29087.130.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-03 at 11:19 -0800, john stultz wrote:
> On Fri, 2006-02-03 at 09:45 +0530, Conio sandiago wrote:
> > Hi all,
> > i am using time function in my application.
> > When i call the try function in a loop of say 1 lac iterations then i
> > m facing strange behaviour.
> > 
> > What i am doing is that i am making a call twice to time function
> > inside every iteration and i compare the time of both the calls.
> > But sometimes the time obtained from recent call is 1 second less than
> > the previous call.
> > 
> > Has anybody observed such kind of problem??
> 
> Time inconsistencies are possible with some hardware, although full
> second inconsistencies are a bit large.
> 
> Please open a bug at  http://bugzilla.kernel.org
> 
> Attach a full dmesg log and assign it to me.

Please provide also test code which makes that problem visible.

	tglx


