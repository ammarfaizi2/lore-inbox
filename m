Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbWAENit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWAENit (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 08:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWAENit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 08:38:49 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:34191 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751184AbWAENis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 08:38:48 -0500
Date: Thu, 5 Jan 2006 08:38:34 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Vegard Lima <Vegard.Lima@hia.no>
cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.15-rt1-sr1: xfs mount crash
In-Reply-To: <1136467202.2310.10.camel@tordenfugl.lima.heim>
Message-ID: <Pine.LNX.4.58.0601050830120.9377@gandalf.stny.rr.com>
References: <1136467202.2310.10.camel@tordenfugl.lima.heim>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 5 Jan 2006, Vegard Lima wrote:

> Hi,
>
> I still get an Oops when mounting an XFS filesystem under 2.6.15-rt1-sr1
> (Same happend for 2.6.15-rc7-rt1: http://lkml.org/lkml/2005/12/29/67 )
>
> I can make the Oops go away by changing this config option from
>   # CONFIG_DEBUG_RT_LOCKING_MODE is not set
> to
>   CONFIG_DEBUG_RT_LOCKING_MODE=y
>

Hi Vergard,

I just want to make sure I understand the above.

The bug happens when CONFIG_DEBUG_RT_LOCKING_MODE is _not_ set?

And the bug goes away when it _is_ set?

Thanks,

-- Steve

> Full dmesg output and .config can be found here:
>   http://home.hia.no/~vegardl/rt/
>
>
