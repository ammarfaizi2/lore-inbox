Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268775AbUIXOQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268775AbUIXOQU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 10:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268786AbUIXOQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 10:16:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:51634 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S268775AbUIXOQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 10:16:12 -0400
Date: Thu, 23 Sep 2004 15:13:12 +0200
From: Pavel Machek <pavel@suse.cz>
To: William Lee Irwin III <wli@holomorphy.com>, mj@ucw.cz
Cc: Albert Cahalan <albert@users.sf.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>, cw@f00f.org,
       mingo@elte.hu, anton@samba.org
Subject: Re: /proc/sys/kernel/pid_max issues
Message-ID: <20040923131312.GQ467@openzaurus.ucw.cz>
References: <1095045628.1173.637.camel@cube> <20040913074230.GW2660@holomorphy.com> <1095084688.1173.1329.camel@cube> <20040913142752.GC9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040913142752.GC9106@holomorphy.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > With per-user PID recycling, it would be difficult for
> > him to grab the desired PID.
> 
> I'd suggest pushing for 64-bit+ pid's, then. IIRC most of the work
> there is in userspace (the in-kernel part is trivial).

Actually 64-bit pids would be very nice for clustering.
mj did that once, IIRC, maybe he still has a patch?
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

