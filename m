Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267340AbUHSTeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267340AbUHSTeD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 15:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267313AbUHSTeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 15:34:02 -0400
Received: from thunk.org ([140.239.227.29]:59561 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S267365AbUHSTbE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 15:31:04 -0400
Date: Thu, 19 Aug 2004 15:30:49 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
Message-ID: <20040819193049.GA13070@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	Florian Schmidt <mista.tapas@gmx.net>
References: <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu> <1092374851.3450.13.camel@mindpipe> <1092375673.3450.15.camel@mindpipe> <20040813103151.GH8135@elte.hu> <1092699974.13981.95.camel@krustophenia.net> <20040817074826.GA1238@elte.hu> <20040817191819.GA19449@thunk.org> <1092914397.830.3.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092914397.830.3.camel@krustophenia.net>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 07:19:58AM -0400, Lee Revell wrote:
> > I doubt SHA_CODE_SIZE will make a sufficient difference to avoid the
> > latency problems.  What we would need to do is to change the code so
> > that the rekey operation in __check_and_rekey takes place in a
> > workqueue.  Say, something like this (warning, I haven't tested this
> > patch; if it breaks, you get to keep both pieces):
> > 
> 
> Tested, works for me.  This should probably be pushed upstream, as well
> as added to -P5, correct?  Is there any disadvantage to doing it this
> way?

Great, I will be pushing this upstream very shortly.

						- Ted
