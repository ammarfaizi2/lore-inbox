Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751478AbVKYWLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbVKYWLM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 17:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbVKYWLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 17:11:12 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44000 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751478AbVKYWLL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 17:11:11 -0500
Date: Fri, 25 Nov 2005 23:09:34 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rob Landley <rob@landley.net>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] make miniconfig (take 2)
Message-ID: <20051125220934.GA2268@elf.ucw.cz>
References: <200511170629.42389.rob@landley.net> <200511232119.46383.rob@landley.net> <20051125194524.GA2164@elf.ucw.cz> <200511251545.32343.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511251545.32343.rob@landley.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > #
> > # Automatically generated make config: don't edit
> > # Linux kernel version: 2.6.15-rc2
> > # Wed Nov 23 14:17:02 2005
> ...
> 
> Uh-huh.
> 
>   landley@driftwood:~/linux-2.6.15-rc2$ make allnoconfig > /dev/null
>   landley@driftwood:~/linux-2.6.15-rc2$ diff -u .config pavelconfig
>   --- .config     2005-11-25 15:38:49.333425064 -0600
>   +++ pavelconfig3        2005-11-25 15:41:40.929338520 -0600
>   @@ -1,7 +1,7 @@
>    #
>    # Automatically generated make config: don't edit
>   -# Linux kernel version: 2.6.15-rc2-git2
>   -# Fri Nov 25 15:38:49 2005
>   +# Linux kernel version: 2.6.15-rc2
>   +# Wed Nov 23 14:17:02 2005
>    #
>    CONFIG_X86_32=y
>    CONFIG_SEMAPHORE_SLEEPERS=y
>   landley@driftwood:~/linux-2.6.15-rc2$ 
>   
> Am I wrong, or is the .config you just sent me identical to the output of 
> allnoconfig?  (I have no idea why it decided CONFIG_PM=y was needed, I just 
> reproduced that here.  Probably an idiosyncrasy of allnoconfig, I could 
> investigate that...)

Ouch, I guess I killed my .config :-(. It seems that interrupted
miniconfig.sh leaves .config in close to empty state...

I'm not sure what I did wrong last time, it worked this time. My
miniconfig is 6K instead of 46K, good. Still its quite long. Thanks!

							Pavel
-- 
Thanks, Sharp!
