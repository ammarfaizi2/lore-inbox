Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264530AbUFLBuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbUFLBuY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 21:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264535AbUFLBuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 21:50:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38886 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264530AbUFLBuR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 21:50:17 -0400
Date: Fri, 11 Jun 2004 21:50:03 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: John Bradford <john@grabjohn.com>, Matt Mackall <mpm@selenic.com>,
       Christian Borntraeger <linux-kernel@borntraeger.net>,
       <linux-kernel@vger.kernel.org>,
       Lasse K?rkk?inen / Tronic <tronic2@sci.fi>
Subject: Re: Some thoughts about cache and swap
In-Reply-To: <20040611140721.GB7369@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.44.0406112148420.13607-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jun 2004, Jörn Engel wrote:
> On Wed, 9 June 2004 15:32:41 -0400, Rik van Riel wrote:
> > 
> > Haven't seen many of those, to be honest.  The majority
> > of the VM problems I get to see are people running a
> > workload the kernel didn't expect - a workload the kernel
> > wasn't prepared to handle...
> 
> Is there a list of those different workloads somewhere?  And I don't
> mean in your head. ;)

That's the point.  If there was such a list, we could put
appropriate kludges in place for all of them.

> All I notive in my personal use is the cache flushing effect from
> use-once data.  If that was the whole list, it should be easy enough to
> fix.

I wish it were that easy.  Users keep surprising us with
new and unexpected workloads, though.

Part of it is that every time Linux is improved, people are
encouraged to try out stranger, newer, heavier workloads ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

