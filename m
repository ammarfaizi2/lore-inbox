Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129610AbRAAW7Y>; Mon, 1 Jan 2001 17:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129913AbRAAW7O>; Mon, 1 Jan 2001 17:59:14 -0500
Received: from online.indstate.edu ([139.102.15.42]:44715 "EHLO
	online.indstate.edu") by vger.kernel.org with ESMTP
	id <S129610AbRAAW7C>; Mon, 1 Jan 2001 17:59:02 -0500
From: "Rich Baum" <baumr1@coral.indstate.edu>
To: Andreas Franck <afranck@gmx.de>, Linus Torvalds <torvalds@transmeta.com>,
        Mike Galbraith <mikeg@wen-online.de>, linux-kernel@vger.kernel.org
Date: Mon, 1 Jan 2001 17:28:11 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [revisited] Oops on boot with 2.4.0testX and GCC snapshots
Reply-to: richbaum@acm.org
CC: Linus Torvalds <torvalds@transmeta.com>,
        Mike Galbraith <mikeg@wen-online.de>
Message-ID: <3A50BE2B.11580.104406@localhost>
In-Reply-To: <01010119004100.01545@dg1kfa.ampr.org>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 Jan 2001, at 19:00, Andreas Franck wrote:

> Hello together,
> 
> after all the new year's celebrations, I have today taken the time to create 
> a small patch, based on Linus' idea, that will fix this problem in the 
> kernel, _without_ pessimizing any code or breaking with earlier compilers.
> 
> 2.4.0-prerelease is now running here for an hour compiled completely with 
> gcc-snapshot-2.97-20001222, without any noticed problems (so far).
> 
> Perhaps this could be included in the kernel to enable people to look for the 
> real caveats when compiling everything on the bleeding edge, or should we 
> wait for the GCC maintainers' call - I haven't had any reaction on my bug 
> report yet.
> 
> Along with it is a small fix for a typo in fs/umsdos/mangle.c, which was 
> detected by GCC's new preprocessor (#elseif instead of #else).
> 
> Greetings and a happy new year to everyone,
> Andreas
> 
> -- 
> ->>>----------------------- Andreas Franck --------<<<-
> ---<<<---- Andreas.Franck@post.rwth-aachen.de --->>>---
> ->>>---- Keep smiling! ----------------------------<<<-
> 

Thanks, this patch works for me.  I'm using gcc-2.97-20001225.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
