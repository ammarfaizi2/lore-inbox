Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264261AbUG0LWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264261AbUG0LWE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 07:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264595AbUG0LWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 07:22:04 -0400
Received: from ss1000.ms.mff.cuni.cz ([195.113.20.8]:41183 "EHLO
	ss1000.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264261AbUG0LWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 07:22:02 -0400
Date: Tue, 27 Jul 2004 13:21:58 +0200
From: Rudo Thomas <rudo@matfyz.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Jens Axboe <axboe@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       Lenar L?hmus <lenar@vision.ee>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: no luck with max_sectors_kb (Re: voluntary-preempt-2.6.8-rc2-J4)
Message-ID: <20040727112158.GA8993@ss1000.ms.mff.cuni.cz>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Lee Revell <rlrevell@joe-job.com>, Jens Axboe <axboe@suse.de>,
	William Lee Irwin III <wli@holomorphy.com>,
	Lenar L?hmus <lenar@vision.ee>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu> <20040726100103.GA29072@elte.hu> <20040726101536.GA29408@elte.hu> <20040726204228.GA1231@ss1000.ms.mff.cuni.cz> <20040726205741.GA27527@elte.hu> <20040726225009.GA2369@ss1000.ms.mff.cuni.cz> <20040727064345.GA5594@elte.hu> <20040727080612.GA7277@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040727080612.GA7277@elte.hu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > ok, dm (and some other layered block drivers) set q->max_sectors
> > directly instead of using blk_queue_max_sectors().
> 
> does the patch below fix your DM problems?

Indeed it does.

Rudo.
