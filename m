Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbUCPNy4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 08:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbUCPNyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 08:54:55 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:56078
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261690AbUCPNtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 08:49:36 -0500
Date: Tue, 16 Mar 2004 14:50:17 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [lockup] Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in <=16G machines)
Message-ID: <20040316135017.GX30940@dualathlon.random>
References: <20040315220022.GK30940@dualathlon.random> <Pine.LNX.4.44.0403160436340.1639-100000@dmt.cyclades>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403160436340.1639-100000@dmt.cyclades>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 04:39:50AM -0300, Marcelo Tosatti wrote:
> What are the problems you are facing ? Yes, I could read the previous 
> posts, etc. but a nice resume is always good, for me, for others, and for 
> you :)

the primary problem of rmap is the memory consumption and the slowdown
during things like parallel compiles in 32-ways. on 32bit and 64bit
archs.

> Yes, 4:4 tlb flushing is, hum, not very cool.

and it can't help avoiding to waste several gigs of ram on the 64bit ;).
