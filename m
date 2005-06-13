Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVFMUaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVFMUaQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 16:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbVFMU15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 16:27:57 -0400
Received: from opersys.com ([64.40.108.71]:7437 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261303AbVFMUXt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 16:23:49 -0400
Message-ID: <42ADEDC7.9030904@opersys.com>
Date: Mon, 13 Jun 2005 16:34:15 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: paulmck@us.ibm.com
CC: Andrea Arcangeli <andrea@suse.de>, Bill Huey <bhuey@lnxw.com>,
       Lee Revell <rlrevell@joe-job.com>, Tim Bird <tim.bird@am.sony.com>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
References: <20050610230836.GD21618@nietzsche.lynx.com> <20050610232955.GH6564@g5.random> <20050611014133.GO1300@us.ibm.com> <20050611155459.GB5796@g5.random> <20050611210417.GC1299@us.ibm.com> <42AB7857.1090907@opersys.com> <20050612214519.GB1340@us.ibm.com> <42ACE2D3.9080106@opersys.com> <20050613144022.GA1305@us.ibm.com> <42ADE334.4030002@opersys.com> <20050613201046.GE1305@us.ibm.com>
In-Reply-To: <20050613201046.GE1305@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paul E. McKenney wrote:
> OK.  However, should the discussion get to the point where something
> like RTAI-Fusion has realtime versions of system calls that have
> globally-visible side-effects (such as I/O, networking, IPC, ...),
> then the issue of how to get the non-realtime and the realtime variants
> to play nicely with each other will arise.

Maybe so, but this will be a problem for the RT folks, not the
mainstream folks, and that's why I believe this strategy is
likely to be more feasible.

> I was responding to your list of combinations of CONFIG_PREEMPT_RT, Adeos,
> and Fusion, assuming (probably incorrectly) that you and Kristian were
> looking to compare all the possible combinations.  If my assumption is
> incorrect, then my question was irrelevant, and I apologize for the noise.

Sorry, there's only so much we can do. Currently, we are redoing
our earlier tests with what Ingo gave us.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
