Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289918AbSBKSNs>; Mon, 11 Feb 2002 13:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289995AbSBKSNj>; Mon, 11 Feb 2002 13:13:39 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:47878 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S289989AbSBKSN0>; Mon, 11 Feb 2002 13:13:26 -0500
Date: Mon, 11 Feb 2002 13:11:51 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Harald Welte <laforge@gnumonks.org>
cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        netfilter-devel@lists.samba.org, stelian.pop@fr.alcove.com,
        hpa@zytor.com
Subject: Re: [SOLUTION] Re: Fw: 2.4.18-pre9: iptables screwed?
In-Reply-To: <20020208105548.P26676@sunbeam.de.gnumonks.org>
Message-ID: <Pine.LNX.3.96.1020211130712.32755C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Feb 2002, Harald Welte wrote:

> On Fri, Feb 08, 2002 at 01:08:39AM -0800, David Miller wrote:
> 
> > Stelian has analyzed the bug already.
> 
> This is strange.
> 

> The code you are quoting is only defined if debugging is compiled into 
> the iptables package. The default distribution of the iptables package
> does _not_ ship with debugging enabled.
> 
> The Makefile of all iptables versions between 1.1.1 (released way before
> the linux 2.4.0 kernel came out!) and 1.2.5 (current) have the following
> line in the Makefile:

What is the first thing anyone would do if they had a problem with
iptables? Turn on debugging, obviously.

1 - that explains why I have no problem, I build from source, since I'm
    always trying features in the new versions for better firewalls.
2 - it really should work, debug should find errors, not cause them.
3 - Perhaps debug could be disabled but default, so instead of needing
    NDEBUG in production, you would use -DDEBUG when you had a problem
    (and it might even work ;-).

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

