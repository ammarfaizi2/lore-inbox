Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262434AbVAURt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbVAURt7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 12:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbVAURt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 12:49:58 -0500
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:35549 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S262434AbVAURsx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 12:48:53 -0500
Date: Fri, 21 Jan 2005 09:48:31 -0800
From: Tony Lindgren <tony@atomide.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Pavel Machek <pavel@ucw.cz>, George Anzinger <george@mvista.com>,
       john stultz <johnstul@us.ibm.com>, Andrea Arcangeli <andrea@suse.de>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic tick patch
Message-ID: <20050121174831.GE14554@atomide.com>
References: <20050119000556.GB14749@atomide.com> <Pine.LNX.4.61.0501192100060.3010@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501192100060.3010@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zwane Mwaikambo <zwane@arm.linux.org.uk> [050119 20:02]:
> On Tue, 18 Jan 2005, Tony Lindgren wrote:
> 
> > Hi all,
> > 
> > Attached is the dynamic tick patch for x86 to play with
> > as I promised in few threads earlier on this list.[1][2]
> > 
> > The dynamic tick patch does following:
> > 
> > - Separates timer interrupts from updating system time
> > 
> > - Allows updating time from other interrupts in addition
> >   to timer interrupt
> > 
> > - Makes timer tick dynamic
> > 
> > - Allows power management modules to take advantage of the
> >   idle time inbetween skipped ticks
> > 
> > - Might help with the whistling caps?
> 
> This doesn't seem to cover the local APIC timer, what do you do about the 
> 1kHz tick which it's programmed to do?

Sorry for the delay in replaying. Thanks for pointing that out, I
don't know yet what to do with the local APIC timer. Have to look at
more.

Tony
