Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVFMUaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVFMUaR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 16:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbVFMU0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 16:26:34 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:52495 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261255AbVFMUZv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 16:25:51 -0400
Date: Mon, 13 Jun 2005 13:31:00 -0700
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Karim Yaghmour <karim@opersys.com>, Andrea Arcangeli <andrea@suse.de>,
       Bill Huey <bhuey@lnxw.com>, Lee Revell <rlrevell@joe-job.com>,
       Tim Bird <tim.bird@am.sony.com>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu, pmarques@grupopie.com,
       bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au, ak@muc.de,
       sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050613203100.GA32690@nietzsche.lynx.com>
References: <20050610232955.GH6564@g5.random> <20050611014133.GO1300@us.ibm.com> <20050611155459.GB5796@g5.random> <20050611210417.GC1299@us.ibm.com> <42AB7857.1090907@opersys.com> <20050612214519.GB1340@us.ibm.com> <42ACE2D3.9080106@opersys.com> <20050613144022.GA1305@us.ibm.com> <42ADE334.4030002@opersys.com> <20050613201046.GE1305@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050613201046.GE1305@us.ibm.com>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 01:10:46PM -0700, Paul E. McKenney wrote:
...
> It may well be that system calls containing such side-effects need to be
> Linux-only, or maybe someone will come up with the necessary tricks to
> make it all work nicely.  Not particularly worried about it myself --
> yet, anyway.  There are plenty of things to worry about before we get
> to that point!
...

I suggest not speculating about the needs of various RT apps with
respect to the kernel. (your speculation here will add more confusion
to parts of an already confused kernel community) Vendors and other
groups will layer them on as needed depending on specific usage.
The futex/fusyn work is an exception with regard to syscalls, but
don't speculate about projects like that if you haven't been carefully
tracking their progress and their end goals.

That's my suggestion.

bill

