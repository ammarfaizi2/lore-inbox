Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289046AbSAUFd0>; Mon, 21 Jan 2002 00:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289047AbSAUFdG>; Mon, 21 Jan 2002 00:33:06 -0500
Received: from [203.94.130.164] ([203.94.130.164]:27914 "EHLO bad-sports.com")
	by vger.kernel.org with ESMTP id <S289046AbSAUFc7>;
	Mon, 21 Jan 2002 00:32:59 -0500
Date: Mon, 21 Jan 2002 16:50:21 +1100 (EST)
From: Brett <brett@bad-sports.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: linux-kernel@vger.kernel.org, "Udo A. Steinberg" <reality@delusion.de>
Subject: Re: [PATCH] Combined APM patch for 2.5.3-pre2
In-Reply-To: <20020121135046.574bfa60.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.44.0201211648050.5769-100000@bad-sports.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2002, Stephen Rothwell wrote:
>
> Hi all,
> 
> This is the same patch as the 2.4 combined APM patch I posted earlier,
> but against 2.5.3-pre2.  It does:
> 	Update a couple of email addresses
> 	Fix the idle handling (this is an improved version of the fix
> 		that Alan Cox has in his -ac tree)
> 	Notify user mode of suspend events before drivers (fix)
> 	Make the idling percentage boot time configurable
> 	Rename kapm-idled to kapmd
> 
> As a bonus, it makes apm compile! :-)
> 
> Anyone brave enough to run 2.5.3-pre on their laptop, please test
> and let me know the results.
> 
> 

s/brave/stupid/

Compiled and booted fine for me on my toshiba satellite 100cs (after 
adding the #include <linux/fs.h> fix to dnotify.h.  System seems fine and 
dandy to me, what should I be looking for by way of improvements ?

thanks,

	/ Brett

