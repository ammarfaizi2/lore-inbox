Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbVHCCZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbVHCCZZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 22:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbVHCCZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 22:25:25 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:9722 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261989AbVHCCZY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 22:25:24 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
From: Daniel Walker <dwalker@mvista.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1123027226.1590.59.camel@localhost.localdomain>
References: <20050730160345.GA3584@elte.hu>
	 <1122920564.6759.15.camel@localhost.localdomain>
	 <1122931238.4623.17.camel@dhcp153.mvista.com>
	 <1122944010.6759.64.camel@localhost.localdomain>
	 <20050802101920.GA25759@elte.hu>
	 <1123011928.1590.43.camel@localhost.localdomain>
	 <1123025895.25712.7.camel@dhcp153.mvista.com>
	 <1123027226.1590.59.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 02 Aug 2005 19:25:08 -0700
Message-Id: <1123035909.11101.1.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-02 at 20:00 -0400, Steven Rostedt wrote:
> On Tue, 2005-08-02 at 16:38 -0700, Daniel Walker wrote:
> > Couldn't you just do some math off current->timestamp to see how long
> > the task has been running? This per arch stuff seems a bit invasive..
> 
> The thing is, I'm tracking how long the task is running in the kernel
> without doing a schedule.  That's actually easy, but I don't want to

Why make the distinction ? For what I was going for all I wanted to know
was that an RT task was eating up all the CPU . Did you have something
else in mind?

Daniel

