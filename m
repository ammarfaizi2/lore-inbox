Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266171AbUFZS2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266171AbUFZS2W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 14:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266256AbUFZS2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 14:28:22 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:45441 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S266171AbUFZS2V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 14:28:21 -0400
Date: Sat, 26 Jun 2004 20:28:20 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       PARISC list <parisc-linux@lists.parisc-linux.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix the cpumask rewrite
Message-ID: <20040626182820.GA3723@ucw.cz>
References: <1088266111.1943.15.camel@mulgrave> <Pine.LNX.4.58.0406260924570.14449@ppc970.osdl.org> <1088268405.1942.25.camel@mulgrave> <Pine.LNX.4.58.0406260948070.14449@ppc970.osdl.org> <1088270298.1942.40.camel@mulgrave> <Pine.LNX.4.58.0406261044580.16079@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406261044580.16079@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2004 at 11:01:14AM -0700, Linus Torvalds wrote:

> Final note: I might be willing to just change the rules, if people can 
> show that no paths that might need the volatile behaviour exist any more. 
> They definitely used to exist, though, and that's a BIG decision to make.

At least input pretty much relies on the fact that bitops don't need
locking and act as memory barriers.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
