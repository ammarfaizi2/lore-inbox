Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWELNn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWELNn7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 09:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbWELNn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 09:43:59 -0400
Received: from 216-54-166-5.static.twtelecom.net ([216.54.166.5]:47042 "EHLO
	mx1.compro.net") by vger.kernel.org with ESMTP id S932070AbWELNn7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 09:43:59 -0400
Message-ID: <44649119.5040105@compro.net>
Date: Fri, 12 May 2006 09:43:53 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, johnstul@us.ibm.com
Subject: Re: rt20 patch question
References: <4460ADF8.4040301@compro.net> <Pine.LNX.4.58.0605100827500.3282@gandalf.stny.rr.com> <4461E53B.7050905@compro.net> <Pine.LNX.4.58.0605100938100.4503@gandalf.stny.rr.com> <446207D6.2030602@compro.net> <Pine.LNX.4.58.0605101215220.19935@gandalf.stny.rr.com> <44623157.9090105@compro.net> <Pine.LNX.4.58.0605101556580.22959@gandalf.stny.rr.com> <20060512081628.GA26736@elte.hu> <Pine.LNX.4.58.0605120435570.28581@gandalf.stny.rr.com> <20060512092159.GC18145@elte.hu> <446481C8.4090506@compro.net> <Pine.LNX.4.58.0605120854480.30264@gandalf.stny.rr.com>
In-Reply-To: <Pine.LNX.4.58.0605120854480.30264@gandalf.stny.rr.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
 >
> I was looking at the logdump, but I don't see anything spinning.  CPU 1
> seems to be constantly running your v67 program (alternating with
> posix_cpu_timer), and CPU: 0 is still switching with the swapper, along
> with other tasks, so that this means nothing is just spinning and hogging
> the CPU (on CPU 0, but I assume the v67 tasks is suppose to keep running).
>  

Yes the v67 task is the CPU process. Could it also mean I just didn't
get the logdump at the right time?

Mark

