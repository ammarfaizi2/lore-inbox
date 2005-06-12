Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261688AbVFLKrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbVFLKrz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 06:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbVFLKrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 06:47:55 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:59058 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S261688AbVFLKry
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 06:47:54 -0400
Message-ID: <38010.210.137.194.5.1118573221.squirrel@210.137.194.5>
In-Reply-To: <20050611181528.GA15019@elte.hu>
References: <42AA6A6B.5040907@opersys.com> <20050611070845.GA4609@elte.hu>
    <42AAF5CE.9080607@opersys.com> <20050611145240.GA10881@elte.hu>
    <42AB2209.9080006@opersys.com> <20050611181528.GA15019@elte.hu>
Date: Sun, 12 Jun 2005 06:47:01 -0400 (EDT)
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
From: "James R Bruce" <bruce@andrew.cmu.edu>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: "Karim Yaghmour" <karim@opersys.com>,
       "Kristian Benoit" <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de,
       pmarques@grupopie.com, nickpiggin@yahoo.com.au, ak@muc.de,
       sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
User-Agent: SquirrelMail/1.5.1 [CVS]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo, if you could document the right options required for decent performace somewhere it would be quite helpful (maybe in Documentation/rt-preempt?).  My first test of Preempt-RT showed unexpectedly high overhead for a fairly benign network load (120 UDP packets/sec), but that was likely the result of leaving some debugging options on.

I'll try to run an updated test in the near future and see if there are still issues.  In the meantime I'll be saving your email to make sure I get the config options right.

 - Jim

