Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262519AbUCLUxY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 15:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbUCLUxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 15:53:09 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:10256
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262508AbUCLUsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 15:48:21 -0500
Date: Fri, 12 Mar 2004 21:49:02 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Linus Torvalds <torvalds@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: anon_vma RFC2
Message-ID: <20040312204902.GH30940@dualathlon.random>
References: <20040312202741.GG30940@dualathlon.random> <Pine.LNX.4.44.0403121532060.6494-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403121532060.6494-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 03:32:20PM -0500, Rik van Riel wrote:
> That's not all anonymous memory, though ;)

true, my point is it's feasible (cow or shared is the same from a memory
footprint standpoint, actually less since anon_vmas are a lot cheaper
than dummy shmfs inodes)
