Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264518AbTLLJmb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 04:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264524AbTLLJmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 04:42:31 -0500
Received: from pix-525-pool.redhat.com ([66.187.233.200]:34756 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264518AbTLLJma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 04:42:30 -0500
Date: Fri, 12 Dec 2003 04:41:54 -0500 (EST)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Nick Piggin <piggin@cyberone.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Anton Blanchard <anton@samba.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Mark Wong <markw@osdl.org>
Subject: Re: [PATCH] improve rwsem scalability (was Re: [CFT][RFC] HT scheduler)
In-Reply-To: <3FD91F5D.30005@cyberone.com.au>
Message-ID: <Pine.LNX.4.58.0312120440400.14103@devserv.devel.redhat.com>
References: <20031208155904.GF19412@krispykreme> <3FD50456.3050003@cyberone.com.au>
 <20031209001412.GG19412@krispykreme> <3FD7F1B9.5080100@cyberone.com.au>
 <3FD81BA4.8070602@cyberone.com.au> <3FD8317B.4060207@cyberone.com.au>
 <20031211115222.GC8039@holomorphy.com> <3FD86C70.5000408@cyberone.com.au>
 <20031211132301.GD8039@holomorphy.com> <3FD8715F.9070304@cyberone.com.au>
 <20031211133207.GE8039@holomorphy.com> <3FD88D93.3000909@cyberone.com.au>
 <3FD91F5D.30005@cyberone.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 12 Dec 2003, Nick Piggin wrote:

> getting contended. The following graph is a best of 3 runs average.
> http://www.kerneltrap.org/~npiggin/rwsem.png

the graphs are too noise to be conclusive.

> The part to look at is the tail. I need to do some more testing to see
> if its significant.

yes, could you go from 150 to 300?

	Ingo
