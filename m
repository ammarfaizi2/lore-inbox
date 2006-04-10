Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbWDJOz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWDJOz4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 10:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWDJOzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 10:55:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:6843 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751192AbWDJOzz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 10:55:55 -0400
X-Authenticated: #14349625
Subject: Re: [patch][rfc] quell interactive feeding frenzy
From: Mike Galbraith <efault@gmx.de>
To: bert hubert <bert.hubert@netherlabs.nl>
Cc: Con Kolivas <kernel@kolivas.org>, lkml <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
In-Reply-To: <1144663242.8040.27.camel@homer>
References: <1144402690.7857.31.camel@homer>
	 <200604072256.27665.kernel@kolivas.org> <1144417064.8114.26.camel@homer>
	 <200604072356.03580.kernel@kolivas.org> <1144419294.14231.7.camel@homer>
	 <20060409111436.GA26533@outpost.ds9a.nl> <1144582778.13991.10.camel@homer>
	 <20060409121436.GA28075@outpost.ds9a.nl> <1144606061.7408.14.camel@homer>
	 <20060410091248.GA32468@outpost.ds9a.nl>  <1144663242.8040.27.camel@homer>
Content-Type: text/plain
Date: Mon, 10 Apr 2006 16:56:49 +0200
Message-Id: <1144681009.8493.17.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-10 at 12:00 +0200, Mike Galbraith wrote:
> You may not like the testcase, but it remains a bug exposing testcase.

That proposed change just became moot.  Changing to pulling a 16k file
instead of the 20k directory makes it unmanageable with that change,
with it completely disabled, and even with a full throttling tree.

Oh well, I wanted to try run limiting queues anyway I guess (sigh).

	-Mike

