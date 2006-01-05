Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbWAEOjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbWAEOjq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWAEOjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:39:45 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:24783 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751375AbWAEOjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:39:44 -0500
Date: Thu, 5 Jan 2006 09:39:37 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Nedko Arnaudov <nedko@arnaudov.name>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: sched.c:659 dec_rt_tasks BUG with patch-2.6.15-rt1 (realtime-preempt)
In-Reply-To: <87k6deg2z6.fsf@arnaudov.name>
Message-ID: <Pine.LNX.4.58.0601050936340.10361@gandalf.stny.rr.com>
References: <87ek3ug314.fsf@arnaudov.name> <87mzie2tzu.fsf@arnaudov.name>
 <20060102214516.GA12850@elte.hu> <87lkxyrzby.fsf_-_@arnaudov.name>
 <87u0cj5riq.fsf_-_@arnaudov.name> <1136436273.12468.113.camel@localhost.localdomain>
 <87u0cj3saf.fsf@arnaudov.name> <1136463552.12468.119.camel@localhost.localdomain>
 <87k6deg2z6.fsf@arnaudov.name>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 5 Jan 2006, Nedko Arnaudov wrote:

> Steven Rostedt <rostedt@goodmis.org> writes:
>
> > Although this should not bug, and I'm going to try this config on a UP
> > machine myself to see if I can reproduce your problem, I'd suggest to
> > you to turn off the SMP configuration.
>
> Unfortunatly this is not option for my setup, since I use same kernel on
> multiple systems (kind of livecd but with usb disk). One of them is SMP
> one. I'm currently doing audio only on one of machines and it is
> uniprocessor one. I prefer to avoid triggerring this bug instead of
> having multiple kernels.

Understood.

Does this bug on your SMP machines?

Also where does it crash with cdrecord?  My UP test machine does not have
a cd-burner. And I, unfortunately, don't have time now to put one in.

-- Steve

