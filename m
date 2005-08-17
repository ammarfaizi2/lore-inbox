Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbVHQT02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbVHQT02 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 15:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbVHQT02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 15:26:28 -0400
Received: from mx2.elte.hu ([157.181.151.9]:49061 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751216AbVHQT01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 15:26:27 -0400
Date: Wed, 17 Aug 2005 21:27:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-rt6
Message-ID: <20050817192707.GA27903@elte.hu>
References: <20050816170805.GA12959@elte.hu> <1124214647.5764.40.camel@localhost.localdomain> <1124215631.5764.43.camel@localhost.localdomain> <1124218245.5764.52.camel@localhost.localdomain> <1124252419.5764.83.camel@localhost.localdomain> <1124257580.5764.105.camel@localhost.localdomain> <20050817064750.GA8395@elte.hu> <1124287505.5764.141.camel@localhost.localdomain> <1124288677.5764.154.camel@localhost.localdomain> <1124295214.5764.163.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124295214.5764.163.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 2005-08-17 at 10:24 -0400, Steven Rostedt wrote:
> 
> > OK the output from netconsole still seems like netconsole itself is
> > causing some problems.  But I think it is also showing this lockup. I'll
> > recompile my kernel as UP and see if netconsole works fine.
> 
> Well, the UP kernel boots on my laptop, but netconsole gives strange 
> warnings.

Now that printk is in essence preemptible, there shouldnt be any 
warnings from netconsole - if there are any then it should be possible 
to fix them.

	Ingo
