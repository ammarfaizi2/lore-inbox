Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266837AbUHRAAC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266837AbUHRAAC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 20:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268527AbUHRAAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 20:00:02 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:50362 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266837AbUHQX77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 19:59:59 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
From: Lee Revell <rlrevell@joe-job.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <20040816080745.GA18406@k3.hellgate.ch>
References: <20040801193043.GA20277@elte.hu>
	 <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu>
	 <20040812235116.GA27838@elte.hu> <1092382825.3450.19.camel@mindpipe>
	 <20040813104817.GI8135@elte.hu> <1092432929.3450.78.camel@mindpipe>
	 <20040814072009.GA6535@elte.hu> <20040815115649.GA26259@elte.hu>
	 <1092612264.867.9.camel@krustophenia.net>
	 <20040816080745.GA18406@k3.hellgate.ch>
Content-Type: text/plain
Message-Id: <1092787266.1807.8.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 17 Aug 2004 20:01:06 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-16 at 04:07, Roger Luethi wrote:

> > Also, isn't there a better solution than for network drivers to actively 
> > poll for changes in link status?  Can't they just register a callback that 
> 
> For the Rhine, there is, but making it work requires some extra black
> magic we didn't know until a few months ago. It's fixed in -mm now and
> will probably be in 2.6.9.

Which of the broken out patches from -mm should I apply to get this
fix?  Should I just apply all the ones that touch via-rhine.c?

Lee

