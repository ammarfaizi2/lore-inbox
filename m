Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbUEQQOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbUEQQOi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 12:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbUEQQOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 12:14:38 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:37543 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261791AbUEQQOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 12:14:36 -0400
Date: Mon, 17 May 2004 09:14:32 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm3
Message-ID: <20040517161432.GG6763@smtp.west.cox.net>
References: <20040516025514.3fe93f0c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040516025514.3fe93f0c.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 16, 2004 at 02:55:14AM -0700, Andrew Morton wrote:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6/2.6.6-mm3/
> 
> - A few VM changes, getting things synced up better with Andrea's work.
> 
> - A new kgdb stub, for ia64 (what happened to the grand unified kgdb
>   project?)

No one asked the ia64 folks who did that work "Hey, have you looked at
the grand unified kgdb project on kgdb.sf.net ?" would be my guess.

Having said that, if you're willing to go with a slightly late
initalizing (I saw part of the early_param work get dropped again I
think, so I'm gonna guess you don't wanna deal with that again yet) KGDB
for i386 and PPC32, I can whip something up vs 2.6.6 in a day or so.

-- 
Tom Rini
http://gate.crashing.org/~trini/
