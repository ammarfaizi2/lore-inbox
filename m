Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293037AbSCAMxw>; Fri, 1 Mar 2002 07:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293214AbSCAMxn>; Fri, 1 Mar 2002 07:53:43 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:52754 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S293037AbSCAMxd>;
	Fri, 1 Mar 2002 07:53:33 -0500
Date: Fri, 1 Mar 2002 09:52:02 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] enable uptime display > 497 days on 32 bit (1/2)
In-Reply-To: <Pine.LNX.4.33.0203010339240.3946-100000@gans.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.33L.0203010931160.2801-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Mar 2002, Tim Schmielau wrote:

> rediffed to 2.4.19-pre2 and three micro-optimizations:
>
>   move jiffies_hi etc. to same cacheline as jiffies
>     (suggested by George Anzinger)
>   avoid turning off interrupts (suggested by Andreas Dilger)
>   use unlikely() (suggested by Andreas Dilger)
>
> As no other comments turned up, this will go to Marcelo RSN.

Please merge with Linus first, otherwise you'll loose this
feature once you'll upgrade to 2.6 ...

> (wondered why noone vetoed this as overkill...)

I guess sneaking it past Linus will be the real test ;)

cheers,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/


