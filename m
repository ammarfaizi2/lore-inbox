Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUKFPdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUKFPdw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 10:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbUKFPdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 10:33:52 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:10428 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S261405AbUKFPdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 10:33:50 -0500
Date: Sat, 6 Nov 2004 16:29:47 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, Jesse Barnes <jbarnes@sgi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages /    all_unreclaimable braindamage
Message-ID: <20041106152947.GB3851@dualathlon.random>
References: <Pine.LNX.4.44.0411060944150.2721-100000@localhost.localdomain> <418CAD0C.3030109@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418CAD0C.3030109@cyberone.com.au>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 06, 2004 at 09:53:00PM +1100, Nick Piggin wrote:
> Yeah right you are. I think NOFAIL is a bug and should really not fail.

agreed.
