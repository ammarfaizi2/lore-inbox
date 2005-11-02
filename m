Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbVKBDFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbVKBDFj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 22:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbVKBDFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 22:05:39 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:29662 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932243AbVKBDFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 22:05:38 -0500
Subject: Re: 2.6.14-rt1
From: Steven Rostedt <rostedt@goodmis.org>
To: Carlos Antunes <cmantunes@gmail.com>
Cc: Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Ingo Molnar <mingo@elte.hu>, Rui Nuno Capela <rncbc@rncbc.org>,
       "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>,
       john stultz <johnstul@us.ibm.com>, Mark Knecht <markknecht@gmail.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
In-Reply-To: <cb2ad8b50511011855w41bf4a30l3127cc36dcacb094@mail.gmail.com>
References: <20051017160536.GA2107@elte.hu> <20051020195432.GA21903@elte.hu>
	 <20051030133316.GA11225@elte.hu>
	 <1130876293.6178.6.camel@cmn3.stanford.edu>
	 <1130899662.12101.2.camel@cmn3.stanford.edu>
	 <cb2ad8b50511011855w41bf4a30l3127cc36dcacb094@mail.gmail.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 01 Nov 2005 22:05:16 -0500
Message-Id: <1130900716.29788.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-01 at 21:55 -0500, Carlos Antunes wrote:

> 
> Fernando,
> 
> I'm also having some when using SCHED_FIFO and SCHED_RR. When running
> several hundred threads, each sleeping on a loop for 20ms, SCHED_OTHER
> performs ok with latencies of less than 10ms while with SCHED_FIFO or
> SCHED_RR, I see latencies exceeding 1 full second!

Are you saying that you have several hundred threads in SCHED_FIFO or
SCHED_RR? Or is just Jack as that.

-- Steve


