Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbTKZCLU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 21:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263934AbTKZCLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 21:11:20 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:26571 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S263930AbTKZCLS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 21:11:18 -0500
Date: Tue, 25 Nov 2003 18:11:11 -0800
From: Larry McVoy <lm@bitmover.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: "Mr. BOFH" <icerbofh@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: Fire Engine??
Message-ID: <20031126021111.GA10193@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Nick Piggin <piggin@cyberone.com.au>,
	"Mr. BOFH" <icerbofh@hotmail.com>, linux-kernel@vger.kernel.org
References: <BAY1-DAV15JU71pROHD000040e2@hotmail.com> <3FC40663.6050602@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FC40663.6050602@cyberone.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 26, 2003 at 12:48:19PM +1100, Nick Piggin wrote:
> 
> 
> Mr. BOFH wrote:
> 
> >Sun has announced that they have redone their TCP/IP stack and is showing
> >for some instances a 30% improvement over Linux....
> >
> >http://www.theregister.co.uk/content/61/33440.html
> >
> >
> 
> Thats odd. Since when did Linux's TCP/IP stack become the benchmark? :)
> 
> PS. This isn't really appropriate for this list. I'm sure an open and
>    verifiable comparison would be welcomed though.

And not to dis my Alma Mater but I tend think the whole TOE idea is a lose.
I used to think otherwise, while I was a Sun employee, and Sun employee #1
pointed out to me that CPUs and memory were getting faster more quickly than
the TOE type answers could come to market.  He was right then and he seems
to still be right.

Maybe throwing processors at the problem will make him (and me now) wrong
but I have to think I could do better things with a CPU than offload some
TCP packets.

Linux has it right.  Make the normal case fast and lightweight and ignore
the other cases.  There are no other cases if the normal path is fast.

Another way to say "fast path" is "our normal path sucks".
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
