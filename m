Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267612AbUHRUfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267612AbUHRUfw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 16:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267650AbUHRUfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 16:35:52 -0400
Received: from mail1.bluewin.ch ([195.186.1.74]:49638 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S267612AbUHRUfl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 16:35:41 -0400
Date: Wed, 18 Aug 2004 22:34:57 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
Message-ID: <20040818203457.GA17917@k3.hellgate.ch>
Mail-Followup-To: Lee Revell <rlrevell@joe-job.com>,
	Ingo Molnar <mingo@elte.hu>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	Florian Schmidt <mista.tapas@gmx.net>
References: <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu> <1092382825.3450.19.camel@mindpipe> <20040813104817.GI8135@elte.hu> <1092432929.3450.78.camel@mindpipe> <20040814072009.GA6535@elte.hu> <20040815115649.GA26259@elte.hu> <1092612264.867.9.camel@krustophenia.net> <20040816080745.GA18406@k3.hellgate.ch> <1092787266.1807.8.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092787266.1807.8.camel@krustophenia.net>
X-Operating-System: Linux 2.6.8-rc3-mm1 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Aug 2004 20:01:06 -0400, Lee Revell wrote:
> > For the Rhine, there is, but making it work requires some extra black
> > magic we didn't know until a few months ago. It's fixed in -mm now and
> > will probably be in 2.6.9.
> 
> Which of the broken out patches from -mm should I apply to get this
> fix?  Should I just apply all the ones that touch via-rhine.c?

I don't know what Andrew called them. But applying all via-rhine patches
in -mm should work. Check for a function called rhine_enable_linkmon.

Roger
