Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbVJSPVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbVJSPVo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 11:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbVJSPVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 11:21:44 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:17144 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S1751089AbVJSPVo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 11:21:44 -0400
Date: Wed, 19 Oct 2005 08:21:08 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Ktimer / -rt9 (+custom) monotonic_clock going backwards.
In-Reply-To: <Pine.LNX.4.58.0510191047270.24515@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0510190816380.30406@dhcp153.mvista.com>
References: <Pine.LNX.4.58.0510191047270.24515@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Oct 2005, Steven Rostedt wrote:

>
> Hi Thomas,
>
> I switched my custom kernel timer to use the ktimers with the prio of -1
> as you mentioned to me offline.  I set up the timer to be monotonic and
> have a requirement that the returned time is always greater or equal to
> the last time returned from do_get_ktime_mono.
>
> Now here's the results that I got between two calls of do_get_ktime_mono
>
> 358.069795728 secs then later 355.981483177.  Should this ever happen?

Are you running NTP ?

Daniel
