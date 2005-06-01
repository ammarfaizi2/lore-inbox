Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbVFAOq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbVFAOq1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 10:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbVFAOq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 10:46:27 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:4374
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261396AbVFAOqW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 10:46:22 -0400
Date: Wed, 1 Jun 2005 16:46:12 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Paulo Marques <pmarques@grupopie.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Esben Nielsen <simlo@phys.au.dk>, James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050601144612.GJ5413@g5.random>
References: <20050531143051.GL5413@g5.random> <Pine.OSF.4.05.10505311652140.1707-100000@da410.phys.au.dk> <20050531161157.GQ5413@g5.random> <20050531183627.GA1880@us.ibm.com> <20050531204544.GU5413@g5.random> <429DA7AE.5000304@grupopie.com> <20050601135154.GF5413@g5.random> <20050601141919.GA9282@elte.hu> <20050601143202.GI5413@g5.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050601143202.GI5413@g5.random>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 04:32:02PM +0200, Andrea Arcangeli wrote:
> years of doing that in linux. I'm not a lawyer but you may want to
> check before investing too much on this for the next 15 years. The

Here's a link that may be of interest:

http://www.fsmlabs.com/openpatentlicense.html
http://patft.uspto.gov/netacgi/nph-Parser?Sect1=PTO2&Sect2=HITOFF&p=1&u=/netahtml/search-bool.html&r=12&f=G&l=50&co1=AND&d=ptxt&s1=5,995,745&OS=5,995,745&RS=5,995,745

This means all preempt-RT users are forced to release all their userland
code that runs with RT prio as GPL (not just the preempt-RT kernel
patch). This is not the case with RTAI. This will expire in a matter of
about 15 years so it's not too bad, and I was approximative when I've
said preempt-RT infringe on the patent. You Ingo are perfectly safe,
it's only the preempt-RT users that will infringe unless all their RT
code is GPL'd.

This is JFYI.
