Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266512AbUJAVRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266512AbUJAVRj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 17:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266352AbUJAVQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 17:16:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:20147 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266684AbUJAVAC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 17:00:02 -0400
Date: Fri, 1 Oct 2004 14:03:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: george@mvista.com, drepper@redhat.com, johnstul@us.ibm.com,
       Ulrich.Windl@rz.uni-regensburg.de, jbarnes@sgi.com,
       linux-kernel@vger.kernel.org, libc-alpha@sources.redhat.com
Subject: Re: Posix compliant cpu clocks V6 [1/3]: Generic Kernel patch
Message-Id: <20041001140315.579d4e10.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0410011257510.18738@schroedinger.engr.sgi.com>
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com>
	<Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com>
	<4154F349.1090408@redhat.com>
	<Pine.LNX.4.58.0409242253080.13099@schroedinger.engr.sgi.com>
	<41550B77.1070604@redhat.com>
	<B6E8046E1E28D34EB815A11AC8CA312902CD327E@mtv-atc-605e--n.corp.sgi.com>
	<Pine.LNX.4.58.0409271344220.32308@schroedinger.engr.sgi.com>
	<4159B920.3040802@redhat.com>
	<Pine.LNX.4.58.0409282017340.18604@schroedinger.engr.sgi.com>
	<415AF4C3.1040808@mvista.com>
	<B6E8046E1E28D34EB815A11AC8CA31290322B307@mtv-atc-605e--n.corp.sgi.com>
	<Pine.LNX.4.58.0410011257510.18738@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> --- linux-2.6.9-rc3.orig/kernel/posix-timers.c	2004-09-29 20:04:47.000000000 -0700
> +++ linux-2.6.9-rc3/kernel/posix-timers.c	2004-10-01 12:48:55.000000000 -0700
> ...
> +int do_posix_clock_notimer_create(int which_clock,
> +		struct sigevent __user *time_event_spec,
> +		timer_t __user *created_timer_id);
> +int do_posix_clock_nonanosleep(int which_clock, int flags, struct timespec * t);

These guys are already declared in posix-timers.h.

I'll fix that up, queue the patch up.

