Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265300AbTL0DbD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 22:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265302AbTL0DbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 22:31:03 -0500
Received: from imladris.surriel.com ([66.92.77.98]:26774 "EHLO
	imladris.surriel.com") by vger.kernel.org with ESMTP
	id S265300AbTL0DbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 22:31:01 -0500
Date: Fri, 26 Dec 2003 22:31:16 -0500 (EST)
From: Rik van Riel <riel@surriel.com>
To: Andrew Morton <akpm@osdl.org>
cc: torvalds@osdl.org, benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       andrea@suse.de
Subject: Re: Page aging broken in 2.6
In-Reply-To: <20031226190045.0f4651f3.akpm@osdl.org>
Message-ID: <Pine.LNX.4.55L.0312262230040.7686@imladris.surriel.com>
References: <1072423739.15458.62.camel@gaston> <Pine.LNX.4.58.0312260957100.14874@home.osdl.org>
 <1072482941.15458.90.camel@gaston> <Pine.LNX.4.58.0312261626260.14874@home.osdl.org>
 <1072485899.15456.96.camel@gaston> <Pine.LNX.4.58.0312261649070.14874@home.osdl.org>
 <Pine.LNX.4.55L.0312262147030.7686@imladris.surriel.com>
 <20031226190045.0f4651f3.akpm@osdl.org>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Dec 2003, Andrew Morton wrote:

> The current behaviour seems better from a theoretical point of view.

It's certainly easier to understand when tuning the VM,
indeed.

> And if we want to give mapped pages more preference over unmapped ones
> (they already have some preference, by the default value of
> /proc/sys/vm/swappiness), we have less radical ways of doing this.

Agreed, the current swappiness is probably a better measure.
More flexible and more easy to tune.

cheers,

Rik
-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
