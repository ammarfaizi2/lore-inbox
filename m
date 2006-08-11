Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWHKSqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWHKSqi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 14:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWHKSqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 14:46:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2998 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932191AbWHKSqi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 14:46:38 -0400
Date: Fri, 11 Aug 2006 11:46:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mark Lord <lkml@rtr.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, cpufreq@www.linux.org.uk
Subject: Re: cpufreq stops working after a while
Message-Id: <20060811114631.4a699667.akpm@osdl.org>
In-Reply-To: <44DCCB96.5080801@rtr.ca>
References: <44DCCB96.5080801@rtr.ca>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2006 14:25:26 -0400
Mark Lord <lkml@rtr.ca> wrote:

> One of my notebooks (Dell Latitude X1) has a 1.1GHz Pentium-M ULV processor.
> This chip can change CPU speeds from 600 -> 800 -> 1100 Mhz.
> 
> I use speedstep-centrino with it, and after boot all is usually okay.
> But after a few hours of operation, it stops shifting to the highest frequency
> even under continuous 100% load (or not).  Eventually it gets stuck at 600Mhz
> and stays there until I reboot.
> 
> Sometimes rebooting doesn't even restore it.
> 
> /sys/devices/system/cpu/cpu0/cpufreq is all very normal looking,
> showing the available frequencies and other info.  All of the attribs
> there look fine, except for "scaling_max_freq", which is what seems
> to gradually get set smaller.  For instance, right now it is set to 800000,
> and it won't let me change it (echo 11000000 > scaling_max_freq has no effect.
> 
> WHY?

cpufreq seems to have relatively frequent problems.

>  And how can I fix it?

You could start by telling us which kernel versions are affected ;)
