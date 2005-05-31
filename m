Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbVEaT50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVEaT50 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 15:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbVEaT50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 15:57:26 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:61348 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261378AbVEaTzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 15:55:51 -0400
Subject: Re: RT patch acceptance
From: Lee Revell <rlrevell@joe-job.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: karim@opersys.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       hch@infradead.org, dwalker@mvista.com, Ingo Molnar <mingo@elte.hu>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, Andi Kleen <ak@muc.de>,
       James Bruce <bruce@andrew.cmu.edu>, kus Kusche Klaus <kus@keba.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Esben Nielsen <simlo@phys.au.dk>,
       "Bill Huey (hui)" <bhuey@lnxw.com>
In-Reply-To: <1117556975.2569.37.camel@localhost.localdomain>
References: <Pine.OSF.4.05.10505301934001.31148-100000@da410.phys.au.dk>
	 <429B61F7.70608@opersys.com> <20050530223434.GC9972@nietzsche.lynx.com>
	 <429B9880.1070604@opersys.com> <20050530224949.GE9972@nietzsche.lynx.com>
	 <429B9E85.2000709@opersys.com>
	 <1117556975.2569.37.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 31 May 2005 15:55:49 -0400
Message-Id: <1117569350.23283.17.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-31 at 12:29 -0400, Steven Rostedt wrote:
> I would assume that the distros would ship without PREEMPT enabled
> because it was (and probably still is) considered unstable.

I suspect this is no longer the case, as the -RT development process has
fixed many, many of these bugs.

What would the point of shipping with PREEMPT enabled have been anyway,
when you could still get 20-30ms bumps?  You'd still need huge buffers
for audio to work at all.  Now that PREEMPT in mainline actually works
reasonably (1-2ms by some accounts, also due to side effects of
PREEMPT_RT development) there might be a reason to enable it.

Lee

