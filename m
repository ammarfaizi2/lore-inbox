Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965223AbVJEPmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965223AbVJEPmi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 11:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965229AbVJEPmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 11:42:38 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:26364 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S965223AbVJEPmh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 11:42:37 -0400
Subject: Re: 2.6.14-rc3-rt2
From: Daniel Walker <dwalker@mvista.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>
In-Reply-To: <Pine.LNX.4.58.0510051023460.23350@localhost.localdomain>
References: <20051004084405.GA24296@elte.hu>
	 <Pine.LNX.4.58.0510050928440.23350@localhost.localdomain>
	 <Pine.LNX.4.58.0510051023460.23350@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 05 Oct 2005 08:41:51 -0700
Message-Id: <1128526911.8806.1.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-05 at 10:29 -0400, Steven Rostedt wrote:
> Hmm, Ingo,
> 
> Do you know why time goes backwards when I run hackbench as a realtime
> process?  I added the output of start and stop and it does seem to go
> backwards.
> 
> Thomas?
> 
> Oh and this is with -rt8.

I've seen reports of this on non-RT , but SMP systems . When load goes
up gettimeofdays() will go backwards . Have you tested with RT off?

Daniel

