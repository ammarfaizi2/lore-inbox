Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267890AbTBKOcN>; Tue, 11 Feb 2003 09:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267893AbTBKOcN>; Tue, 11 Feb 2003 09:32:13 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:2749 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267890AbTBKOcM>;
	Tue, 11 Feb 2003 09:32:12 -0500
Date: Tue, 11 Feb 2003 15:41:43 +0100
From: Jens Axboe <axboe@suse.de>
To: Jason Lunz <lunz@falooley.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3 / aa / rmap with contest]
Message-ID: <20030211144143.GR930@suse.de>
References: <20030209133013.41763.qmail@web41404.mail.yahoo.com> <20030209144622.GB31401@dualathlon.random> <20030210162301.GB443@elf.ucw.cz> <20030211114936.GE22275@dualathlon.random> <20030211124330.GK930@suse.de> <slrnb4i27n.3s0.lunz@stoli.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <slrnb4i27n.3s0.lunz@stoli.localnet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11 2003, Jason Lunz wrote:
> axboe@suse.de said:
> > Coolest would to simply stack these schedulers any way you want. Sneak
> > the uid based fairness scheduler in front of the pid based one, and
> > you have per-user with per-process fairness.
> 
> Which again reminds us of the network queueing. You all seem to be
> reinventing alexey's wheel here. The above reminds me of HTB with SFQ
> leaf nodes.

There's no wheel reinventing here, just applying the goodies from
network scheduling to disk scheduling.

> By all means, do the same thing with disk i/o. It's been a smashing
> success with packet queueing.

Well, that's the point.

-- 
Jens Axboe

