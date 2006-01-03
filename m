Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbWACDgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWACDgg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 22:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWACDgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 22:36:36 -0500
Received: from nevyn.them.org ([66.93.172.17]:63211 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S1751097AbWACDgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 22:36:36 -0500
Date: Mon, 2 Jan 2006 22:36:30 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Matt Mackall <mpm@selenic.com>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20060103033630.GA31798@nevyn.them.org>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@osdl.org>,
	Arjan van de Ven <arjan@infradead.org>,
	lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
	Matt Mackall <mpm@selenic.com>
References: <20051228114637.GA3003@elte.hu> <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org> <1135798495.2935.29.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org> <20051228212313.GA4388@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051228212313.GA4388@elte.hu>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2005 at 10:23:13PM +0100, Ingo Molnar wrote:
> (there's a third thing that i was also playing with, -ffunction-sections 
> and -fdata-sections, but those dont seem to be reliable on the binutils 
> side yet.)

They should be - I'd bet more on the kernel's linker scripts, and other
weird bits like that.  Feel free to report any problems, though.

However, -ffunction-sections tends to increase size in non-discarded
functions.

-- 
Daniel Jacobowitz
CodeSourcery
