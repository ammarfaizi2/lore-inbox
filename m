Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbWBPUy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbWBPUy7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 15:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbWBPUy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 15:54:59 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:19447 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S964792AbWBPUy6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 15:54:58 -0500
Date: Thu, 16 Feb 2006 12:54:04 -0800 (PST)
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 0/6] lightweight robust futexes: -V3
In-Reply-To: <20060216202357.GA21415@elte.hu>
Message-ID: <Pine.LNX.4.64.0602161229390.30911@dhcp153.mvista.com>
References: <20060216094130.GA29716@elte.hu> <1140107585.21681.18.camel@localhost.localdomain>
 <20060216172435.GC29151@elte.hu> <1140111257.21681.26.camel@localhost.localdomain>
 <20060216202357.GA21415@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 16 Feb 2006, Ingo Molnar wrote:
> and? You can 'manipulate' arbitrary userspace memory, be that used by
> the kernel or not, and you can do a sys_futex(FUTEX_WAKE) on any
> arbitrary userspace memory address too (this is a core property of
> futexes). You must have meant something specific when you said "on the
> surface looks like a malicious users dream variable". In other words:
> please move your statement out of innuendo by backing it up with
> specifics (or by retracting it) - right now it's hanging in the air :)


 	Sorry I didn't mean to leave something hanging out there. I was 
just making an observation. The 'dream variable' comment was maybe a little 
to much and I'll gladly retract that .. I'll replace it with , I think the 
code needs more review in that area ..

Daniel
