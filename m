Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270784AbRHXASJ>; Thu, 23 Aug 2001 20:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270800AbRHXAR7>; Thu, 23 Aug 2001 20:17:59 -0400
Received: from [216.151.155.121] ([216.151.155.121]:2056 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S270784AbRHXARs>; Thu, 23 Aug 2001 20:17:48 -0400
To: Tony Hoyle <tmh@nothing-on.tv>
Cc: Fred <fred@arkansaswebs.com>, linux-kernel@vger.kernel.org
Subject: Re: File System Limitations
In-Reply-To: <01082316383301.12104@bits.linuxball> <9m41qd$290$1@sisko.my.home>
	<01082318132000.12319@bits.linuxball> <3B858F58.1000606@nothing-on.tv>
	<m3d75me3b9.fsf@belphigor.mcnaught.org>
From: Doug McNaught <doug@wireboard.com>
Date: 23 Aug 2001 20:17:59 -0400
In-Reply-To: Doug McNaught's message of "23 Aug 2001 19:58:50 -0400"
Message-ID: <m38zgae2fc.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug McNaught <doug@wireboard.com> writes:

> Tony Hoyle <tmh@nothing-on.tv> writes:
> 
> > Does it?  Unless RH are using a seriously old glibc (which I doubt)
> > there's no 2GB limit any more.
> 
> I just did:
> 
> [doug@abbadon workspace]$ dd if=/dev/zero of=foo bs=1024k count=3072
> 3072+0 records in
> 3072+0 records out
> [doug@abbadon workspace]$ ls -l foo  
> -rw-rw-r--    1 doug     doug     3221225472 Aug 23 20:01 foo
> [doug@abbadon workspace]$ 

I meant to add that this is RH7.1, with updates applied, running
2.4.8-ac8. 

-Doug
-- 
Free Dmitry Sklyarov! 
http://www.freesklyarov.org/ 

We will return to our regularly scheduled signature shortly.
