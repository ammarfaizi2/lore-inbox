Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268765AbUIXOQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268765AbUIXOQP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 10:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268786AbUIXOQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 10:16:15 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:51378 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S268765AbUIXOQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 10:16:12 -0400
Date: Thu, 23 Sep 2004 15:11:33 +0200
From: Pavel Machek <pavel@suse.cz>
To: William Lee Irwin III <wli@holomorphy.com>,
       Albert Cahalan <albert@users.sf.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>, cw@f00f.org,
       mingo@elte.hu, anton@samba.org
Subject: Re: /proc/sys/kernel/pid_max issues
Message-ID: <20040923131132.GP467@openzaurus.ucw.cz>
References: <1095045628.1173.637.camel@cube> <20040913074230.GW2660@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040913074230.GW2660@holomorphy.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > 1. weak security enhancement
> > 2. cosmetic (backwards, IMHO)
> > 3. speed (avoid PIDs likely to be used)
> 
> Well, weak security enhancement translates to "nop" in my book, but
> I guess if that's really what people were trying to arrange...
> 

Well, how many times did you do kill <pid> from command line after doing ps?
If you randomly kill some other process because pids wrapped too fast, it is bad.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

