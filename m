Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263893AbUHJKco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbUHJKco (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 06:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264261AbUHJKcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 06:32:43 -0400
Received: from holomorphy.com ([207.189.100.168]:65255 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263893AbUHJKcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 06:32:39 -0400
Date: Tue, 10 Aug 2004 03:32:22 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] preempt-timing-on-2.6.8-rc3-O4.patch
Message-ID: <20040810103222.GQ11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
	Florian Schmidt <mista.tapas@gmx.net>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
References: <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040809130558.GA17725@elte.hu> <20040809190201.64dab6ea@mango.fruits.de> <1092103522.761.2.camel@mindpipe> <1092117141.761.15.camel@mindpipe> <20040810080933.GA26081@elte.hu> <1092125864.848.2.camel@mindpipe> <20040810101232.GA2706@elte.hu> <20040810102019.GP11200@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810102019.GP11200@holomorphy.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 12:13:03PM +0200, Ingo Molnar wrote:
>> i've uploaded a new version of the preempt-timing patch:
>> http://redhat.com/~mingo/voluntary-preempt/preempt-timing-on-2.6.8-rc3-O4.patch
>> this patch fixes a number of false positives and false negatives. In
>> particular it fixes the idle-task false positives, and it now correctly
>> measures preemption delays in softirq and hardirq contexts and in
>> bh-disabled process contexts. Maybe this sheds a light on some of the
>> more mysterious delays that we've seen. (and which were never directly
>> measured before.)
>> (the patch also got alot simpler, which should help portability.)

On Tue, Aug 10, 2004 at 03:20:19AM -0700, William Lee Irwin III wrote:
> Looks really good, this thing is really starting to look slick from all
> the time you've put in on it.
> The adding in of the FOOIRQ_OFFSET bits were a rather major oversisght
> on my part!  Very good catch.

Feh, there has to be a way to say "this is a good patch" without sounding
like I'm reviewing freshman code. This is a good patch.


-- wli
