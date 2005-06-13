Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbVFMVPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVFMVPA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 17:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVFMVPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 17:15:00 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:43940 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261354AbVFMVCX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 17:02:23 -0400
Date: Mon, 13 Jun 2005 14:02:46 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Karim Yaghmour <karim@opersys.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Bill Huey <bhuey@lnxw.com>,
       Lee Revell <rlrevell@joe-job.com>, Tim Bird <tim.bird@am.sony.com>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050613210246.GH1305@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050611014133.GO1300@us.ibm.com> <20050611155459.GB5796@g5.random> <20050611210417.GC1299@us.ibm.com> <42AB7857.1090907@opersys.com> <20050612214519.GB1340@us.ibm.com> <42ACE2D3.9080106@opersys.com> <20050613144022.GA1305@us.ibm.com> <42ADE334.4030002@opersys.com> <20050613201046.GE1305@us.ibm.com> <42ADEDC7.9030904@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42ADEDC7.9030904@opersys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 04:34:15PM -0400, Karim Yaghmour wrote:
> 
> Paul E. McKenney wrote:
> > OK.  However, should the discussion get to the point where something
> > like RTAI-Fusion has realtime versions of system calls that have
> > globally-visible side-effects (such as I/O, networking, IPC, ...),
> > then the issue of how to get the non-realtime and the realtime variants
> > to play nicely with each other will arise.
> 
> Maybe so, but this will be a problem for the RT folks, not the
> mainstream folks, and that's why I believe this strategy is
> likely to be more feasible.

Unless correctly handling the side effects requires changes to the
mainstream as well as to the RT implementations, as it might well for
I/O, networking, and IPC.  Again, I believe that it might be some time
before we get to this point, so am not all that worried about it.

> > I was responding to your list of combinations of CONFIG_PREEMPT_RT, Adeos,
> > and Fusion, assuming (probably incorrectly) that you and Kristian were
> > looking to compare all the possible combinations.  If my assumption is
> > incorrect, then my question was irrelevant, and I apologize for the noise.
> 
> Sorry, there's only so much we can do. Currently, we are redoing
> our earlier tests with what Ingo gave us.

Yours and Kristian's benchmarking contribution is quite timely and
substantial, and I know that I am not the only one who very much
appreciates it!

							Thanx, Paul
