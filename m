Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276591AbRKAMLd>; Thu, 1 Nov 2001 07:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275265AbRKAMLW>; Thu, 1 Nov 2001 07:11:22 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:3082 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S271800AbRKAMLL>;
	Thu, 1 Nov 2001 07:11:11 -0500
Date: Thu, 1 Nov 2001 10:10:56 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: safemode <safemode@speakeasy.net>, <linux-kernel@vger.kernel.org>
Subject: Re: graphical swap comparison of aa and rik vm
In-Reply-To: <Pine.LNX.4.10.10111010056100.31484-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.33L.0111011009090.2963-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2001, Mark Hahn wrote:

> also, if you merely sum the SI and SO columns for each:
> 		sum(SI)		sum(SO)		sum(SI+SO)
>       Rik-VM	43564		317448		290032
>       AA-VM	118284		171748		361012
> to me, this looks like the same point: Rik being SO-happy,
> Andrea having to SI a lot more.  interesting also that Andrea wins the race,
> in spite of poorer SO choices and more swap traffic overall.

I think this is because in safemode's test, the swap space
gets exhausted.  My VM works better when there is lots of
swap space available but degrades in the (rare) case where
swap space is exhausted.

Testing corner cases always gives interesting results ;)

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

