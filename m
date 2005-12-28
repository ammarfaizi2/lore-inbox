Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbVL1O3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbVL1O3w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 09:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbVL1O3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 09:29:51 -0500
Received: from waste.org ([64.81.244.121]:48270 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S964825AbVL1O3v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 09:29:51 -0500
Date: Wed, 28 Dec 2005 08:26:21 -0600
From: Matt Mackall <mpm@selenic.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch 01/2] allow gcc4 to control inlining
Message-ID: <20051228142621.GJ3356@waste.org>
References: <20051228114653.GB3003@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051228114653.GB3003@elte.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2005 at 12:46:53PM +0100, Ingo Molnar wrote:
> allow gcc4 compilers to decide what to inline and what not - instead
> of the kernel forcing gcc to inline all the time.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> Signed-off-by: Arjan van de Ven <arjan@infradead.org>

I'm ever so slightly wary of GCC 4's stack size logic for functions with
nested scopes, but I think we'll have no trouble catching any trouble
cases in 2.6.16-rc.

Acked-by: Matt Mackall <mpm@selenic.com>

-- 
Mathematics is the supreme nostalgia of our time.
