Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264082AbTICRPF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 13:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264084AbTICRPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 13:15:05 -0400
Received: from holomorphy.com ([66.224.33.161]:2441 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264082AbTICRPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 13:15:02 -0400
Date: Wed, 3 Sep 2003 10:16:08 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Nick Piggin <piggin@cyberone.com.au>, Anton Blanchard <anton@samba.org>,
       Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Scaling noise
Message-ID: <20030903171608.GN4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Nick Piggin <piggin@cyberone.com.au>,
	Anton Blanchard <anton@samba.org>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <20030903040327.GA10257@work.bitmover.com> <20030903041850.GA2978@krispykreme> <20030903042953.GC10257@work.bitmover.com> <20030903062817.GA19894@krispykreme> <3F55907B.1030700@cyberone.com.au> <27780000.1062602622@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27780000.1062602622@[10.10.2.4]>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 08:23:44AM -0700, Martin J. Bligh wrote:
> Would be real interesting to see this ... there are actually plenty of
> real degredations there, none of which (that I've seen) come from any
> scalability changes. Things like RMAP on fork times (for which there are
> other legitimite reasons) are more responsible (for which the "scalability" 
> people have offered a solution).

How'd that get capitalized? It's not an acronym.

At any rate, fork()'s relevance to performance is not being measured
in any context remotely resembling real usage cases, e.g. forking
servers. There are other problems with kernel compiles, for instance,
internally limited parallelism, and a relatively highly constrained
userspace component which is impossible to increase the concurrency of.


-- wli
