Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbVHaPbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbVHaPbW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 11:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbVHaPbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 11:31:22 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:2499 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964817AbVHaPbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 11:31:21 -0400
Subject: Re: [FYI] 2.6.13-rt3  and a nanosleep jitter test.
From: Steven Rostedt <rostedt@goodmis.org>
To: Daniel Walker <dwalker@mvista.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       george anzinger <george@mvista.com>, Adrian Bunk <bunk@stusta.de>,
       Sven-Thorsten Dietrich <sven@mvista.com>,
       LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1125501128.28697.5.camel@c-67-188-6-232.hsd1.ca.comcast.net>
References: <1124704837.5208.22.camel@localhost.localdomain>
	 <20050822101632.GA28803@elte.hu>
	 <1124710309.5208.30.camel@localhost.localdomain>
	 <20050822113858.GA1160@elte.hu>
	 <1124715755.5647.4.camel@localhost.localdomain>
	 <20050822183355.GB13888@elte.hu>
	 <1124739657.5809.6.camel@localhost.localdomain>
	 <1124739895.5809.11.camel@localhost.localdomain>
	 <1124981238.5350.6.camel@localhost.localdomain>
	 <1124982413.5350.19.camel@localhost.localdomain>
	 <20050825174732.GA23774@elte.hu>
	 <1125000563.6264.10.camel@localhost.localdomain>
	 <1125023010.5365.4.camel@localhost.localdomain>
	 <1125064334.5365.39.camel@localhost.localdomain>
	 <1125414039.5675.42.camel@localhost.localdomain>
	 <1125417156.6355.13.camel@localhost.localdomain>
	 <1125500514.5714.12.camel@localhost.localdomain>
	 <1125501128.28697.5.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 31 Aug 2005 11:30:20 -0400
Message-Id: <1125502220.5714.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-31 at 08:12 -0700, Daniel Walker wrote:
> There is already a suite HRT of tests they include a nanosleep jitter
> test with 8 or 9 other tests..
> 
> find them inside the hrt-support patch at http://high-res-timer.sf.net

Wow, they are hidden nicely :-)

I was looking for a tar ball or something. Not a patch.  Well, anyway I
took a look at it, and it is pretty much like mine. But I wanted to
eliminate any more system calls than I needed. Grant you, that my test
is not portable to anything other than ia86.  But it gives me the
results that I wanted.

Thanks,

-- Steve


