Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263084AbUCMMfQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 07:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263085AbUCMMfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 07:35:16 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:51083 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263084AbUCMMfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 07:35:11 -0500
Date: Fri, 12 Mar 2004 22:46:22 +0100
From: Pavel Machek <pavel@suse.cz>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.4-rc2-mm1: vm-split-active-lists
Message-ID: <20040312214621.GE1236@openzaurus.ucw.cz>
References: <404FACF4.3030601@cyberone.com.au> <200403111825.22674@WOLK> <40517E47.3010909@cyberone.com.au> <20040312012703.69f2bb9b.akpm@osdl.org> <pan.2004.03.12.11.08.02.700169@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2004.03.12.11.08.02.700169@smurf.noris.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> > That effect is to cause the whole world to be swapped out when people
> > return to their machines in the morning.
> 
> The correct solution to this problem is "suspend-to-disk" --
> if the machine isn't doing anything anyway, TURN IT OFF.

Try it.

With current design, machine swaps *a lot* after resume.

Suspend-to-ram is probably better.

But if you don't run your updatedb overnight, you are going to
run it while you are logged in, and that is going to suck.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

