Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272416AbTHEDaT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 23:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272417AbTHEDaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 23:30:19 -0400
Received: from holomorphy.com ([66.224.33.161]:45697 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S272416AbTHEDaQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 23:30:16 -0400
Date: Mon, 4 Aug 2003 20:31:19 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] O11int for interactivity
Message-ID: <20030805033119.GO32488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nick Piggin <piggin@cyberone.com.au>,
	Marc-Christian Petersen <m.c.p@wolk-project.de>,
	Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	Con Kolivas <kernel@kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <200307301038.49869.kernel@kolivas.org> <20030802225513.GE32488@holomorphy.com> <200308030119.47474.m.c.p@wolk-project.de> <200308042106.51676.m.c.p@wolk-project.de> <20030804195335.GK32488@holomorphy.com> <3F2F00B0.9050804@cyberone.com.au> <20030805024103.GM32488@holomorphy.com> <3F2F1F80.7060207@cyberone.com.au> <20030805031341.GN32488@holomorphy.com> <3F2F231C.3030901@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F2F231C.3030901@cyberone.com.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> Well, I was vaguely hoping a useful way to instrument the io stuff
>> would already be out there.

On Tue, Aug 05, 2003 at 01:23:08PM +1000, Nick Piggin wrote:
> Not really.
> For a process doing blocking reads you could measure the time
> from when a process submits a read to when it gets the result.
> I suppose you also need some minimum rate too but I really can't
> see that being the problem here.

I'm at least aware of patches for 2.4.x that log io scheduling
decisions in the driver, which is basically what I was hoping for.

On a higher level, are you thinking there's some indication the
io schedulers themselves aren't involved? Or that something higher-
level should be instrumented? If so, what?


-- wli
