Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUDLPDn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 11:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbUDLPDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 11:03:43 -0400
Received: from ambr.mtholyoke.edu ([138.110.1.10]:42509 "EHLO
	ambr.mtholyoke.edu") by vger.kernel.org with ESMTP id S261239AbUDLPDi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 11:03:38 -0400
Date: Mon, 12 Apr 2004 11:03:37 -0400 (EDT)
From: Ron Peterson <rpeterso@MtHolyoke.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: network / performance problems
In-Reply-To: <Pine.OSF.4.21.0403041415400.195051-100000@mhc.mtholyoke.edu>
Message-ID: <Pine.OSF.4.21.0404121056530.4091-100000@mhc.mtholyoke.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Mar 2004, Ron Peterson wrote:

> These machines remain very stable at 2.4.20.
> 
> I don't know where things currently stand vis-a-vis knowing what's
> causing this network/system load creep problem, but I thought I'd report
> that I installed 2.4.21 on a single processor about a week ago (1GHz PIII,
> 500MB, Intel 82820 (ICH2) Chipset w/ eepro100 module), and am seeing the
> same bad behaviour.

I still don't know the root cause of my ever increasing ping
latencies.  However, I can report that if I compile all the netfilter
helpers as modules, rather than statically linking them, that everything
runs fine.

This has solved my immediate problem, so I've turned my attention to other
things.  As far as I know, though, there's still something amiss.

I have another machine that's not in production yet running 2.6.5.  I'm
adopted the habit of compiling netfilter stuff as modules, but I'll
statically link everything and run it that way to see what I can see.

_________________________
Ron Peterson
Network & Systems Manager
Mount Holyoke College

