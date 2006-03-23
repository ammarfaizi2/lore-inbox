Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbWCWNpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbWCWNpt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 08:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbWCWNps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 08:45:48 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:64135 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751370AbWCWNpr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 08:45:47 -0500
Date: Thu, 23 Mar 2006 14:45:41 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: john stultz <johnstul@us.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, george@wildturkeyranch.net,
       Steven Rostedt <rostedt@goodmis.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Ingo Molnar <mingo@elte.hu>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCHSET 0/10] Time: Generic Timekeeping (v.C1)
In-Reply-To: <1143123658.28099.12.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0603231437120.16802@scrub.home>
References: <20060323030547.19338.95102.sendpatchset@cog.beaverton.ibm.com>
  <Pine.LNX.4.64.0603231209380.17704@scrub.home> <1143123658.28099.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 23 Mar 2006, Thomas Gleixner wrote:

> IMO it makes completely sense to move the time/timer/clocks related
> generic code into kernel/time.

Why? Currently it has two files: jiffies.c is a simple clocksource driver 
and clocksource.c is the driver support code.
It's basically driver code, which only is used by some core kernel parts.

bye, Roman
