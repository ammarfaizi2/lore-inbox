Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWJETjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWJETjZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 15:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWJETjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 15:39:25 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:11385 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1750714AbWJETjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 15:39:24 -0400
Subject: Re: [RFC] The New and Improved Logdev (now with kprobes!)
From: Daniel Walker <dwalker@mvista.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       Karim Yaghmour <karim@opersys.com>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>, fche@redhat.com,
       Tom Zanussi <zanussi@us.ibm.com>
In-Reply-To: <1160074147.6660.10.camel@c-67-180-230-165.hsd1.ca.comcast.net>
References: <1160025104.6504.30.camel@localhost.localdomain>
	 <20061005143133.GA400@Krystal>
	 <Pine.LNX.4.58.0610051054300.28606@gandalf.stny.rr.com>
	 <20061005170132.GA11149@Krystal>
	 <Pine.LNX.4.58.0610051309090.30291@gandalf.stny.rr.com>
	 <1160072999.6660.5.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <Pine.LNX.4.58.0610051438010.31280@gandalf.stny.rr.com>
	 <1160074147.6660.10.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Content-Type: text/plain
Date: Thu, 05 Oct 2006 12:39:20 -0700
Message-Id: <1160077160.6660.13.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-05 at 11:49 -0700, Daniel Walker wrote:

> That's part of the reason for the changes that I made to the clocksource
> API . It makes it so instrumentation, with other things, can generically
> read a low level cycle clock. Like on PPC you would read the
> decrementer, and on x86 you would read the TSC . However, the
> application has no idea what it's reading.

Meant to say PowerPC uses the timebase clocksource. Sorry I've got to
many architectures swirling around.

Daniel

