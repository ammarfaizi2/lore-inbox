Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267935AbTBSDd6>; Tue, 18 Feb 2003 22:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267940AbTBSDd5>; Tue, 18 Feb 2003 22:33:57 -0500
Received: from are.twiddle.net ([64.81.246.98]:12186 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S267935AbTBSDd5>;
	Tue, 18 Feb 2003 22:33:57 -0500
Date: Tue, 18 Feb 2003 19:43:51 -0800
From: Richard Henderson <rth@twiddle.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eliminate warnings in generated module files
Message-ID: <20030218194351.A23525@twiddle.net>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
References: <20030218184317.A20436@twiddle.net> <Pine.LNX.4.44.0302181925360.1468-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0302181925360.1468-100000@home.transmeta.com>; from torvalds@transmeta.com on Tue, Feb 18, 2003 at 07:29:15PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2003 at 07:29:15PM -0800, Linus Torvalds wrote:
> Have you tested this with older compilers?

Nope.

> In particular, I have this dim memory of gcc historically not liking 
> multiple separate __attribute__ bits, ie
> 
> 	__attribute__((unused,__section__ ...))
> 
> would be fine, but
> 
> 	__attribute__((unused)) __attribute__((__section__ ...))
> 
> would not compile.
> 
> But hey, my brain is cabbage, and my memory might be crap.

Hmm.  It was always supposed to have worked, but I suppose
there could have been bugs.  How far back to I need to go
looking?


r~
