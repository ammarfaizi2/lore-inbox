Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUDRERw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 00:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264118AbUDRERw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 00:17:52 -0400
Received: from holomorphy.com ([207.189.100.168]:55949 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264113AbUDRERv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 00:17:51 -0400
Date: Sat, 17 Apr 2004 21:17:48 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Marc Singer <elf@buici.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: vmscan.c heuristic adjustment for smaller systems
Message-ID: <20040418041748.GW743@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>, Marc Singer <elf@buici.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040417193855.GP743@holomorphy.com> <20040417212958.GA8722@flea> <20040417162125.3296430a.akpm@osdl.org> <20040417233037.GA15576@flea> <20040417165151.24b1fed5.akpm@osdl.org> <20040418002343.GA16025@flea> <4081F809.4030606@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4081F809.4030606@yahoo.com.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 18, 2004 at 01:37:45PM +1000, Nick Piggin wrote:
> swappiness is pretty arbitrary and unfortunately it means
> different things to machines with different sized memory.
> Also, once you *have* gone past the reclaim_mapped threshold,
> mapped pages aren't really given any preference above
> unmapped pages.
> I have a small patchset which splits the active list roughly
> into mapped and unmapped pages. It might hopefully solve your
> problem. Would you give it a try? It is pretty stable here.

It would be interesting to see the results of this on Marc's system.
It's a more comprehensive solution than tweaking numbers.


-- wli
