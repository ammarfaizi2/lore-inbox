Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267865AbTBKOUd>; Tue, 11 Feb 2003 09:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267867AbTBKOUd>; Tue, 11 Feb 2003 09:20:33 -0500
Received: from main.gmane.org ([80.91.224.249]:13750 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S267865AbTBKOUd>;
	Tue, 11 Feb 2003 09:20:33 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jason Lunz <lunz@falooley.org>
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3 / aa / rmap with contest]
Date: Tue, 11 Feb 2003 14:28:03 +0000 (UTC)
Organization: PBR Streetgang
Message-ID: <slrnb4i27n.3s0.lunz@stoli.localnet>
References: <20030209133013.41763.qmail@web41404.mail.yahoo.com> <20030209144622.GB31401@dualathlon.random> <20030210162301.GB443@elf.ucw.cz> <20030211114936.GE22275@dualathlon.random> <20030211124330.GK930@suse.de>
X-Complaints-To: usenet@main.gmane.org
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

axboe@suse.de said:
> Coolest would to simply stack these schedulers any way you want. Sneak
> the uid based fairness scheduler in front of the pid based one, and
> you have per-user with per-process fairness.

Which again reminds us of the network queueing. You all seem to be
reinventing alexey's wheel here. The above reminds me of HTB with SFQ
leaf nodes.

By all means, do the same thing with disk i/o. It's been a smashing
success with packet queueing.

Jason

