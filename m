Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264971AbUBOPWY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 10:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265045AbUBOPWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 10:22:23 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:43743 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264971AbUBOPWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 10:22:21 -0500
Date: Fri, 13 Feb 2004 20:02:23 +0100
From: Pavel Machek <pavel@suse.cz>
To: Gidon <gidon@warpcore.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel GPL Violations and How to Research
Message-ID: <20040213190222.GG6804@openzaurus.ucw.cz>
References: <1076388828.9259.32.camel@CPE-65-26-89-23.kc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076388828.9259.32.camel@CPE-65-26-89-23.kc.rr.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> So what I am writing to ask, is what is the best way to ascertain
> whether or not a binary (in this case a "kernel image" of this project)
> contains GPL'd code or functions. So far I have found nearly a hundred
> identical (down to formatting specifiers, punctuation, etc.) or nearly
> identical error messages that consistently match areas of Linux i386
> arch specific kernel code or drivers as well as matching function names,
> using the "strings" program on their Kernel image.

At this point you can be pretty sure they are violating GPL. Archive binary
they provide, and ask them for the sources.

(Drivers may come from BSD, but arch-i386 is probably not.)
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

