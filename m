Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285007AbRLZWpz>; Wed, 26 Dec 2001 17:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285013AbRLZWpp>; Wed, 26 Dec 2001 17:45:45 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:6156 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S285007AbRLZWpa>;
	Wed, 26 Dec 2001 17:45:30 -0500
Date: Wed, 26 Dec 2001 20:45:13 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: safemode <safemode@speakeasy.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: some 2.4.17 vs. 2.4.17-rmap8 vs. lowmem analysis
In-Reply-To: <1009405122.381.0.camel@psuedomode>
Message-ID: <Pine.LNX.4.33L.0112262044280.24031-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Dec 2001, safemode wrote:

> Ok, ran the same test again this time limiting ram to 32MB to really
> work the vm. Unfortunately 2.4.17-rmap8 couldn't handle the vm load and
> locked up during a swapin. So obviously there is no real data on it.

Yes, the rmap patch still has a known livelock. I haven't
quite tracked it down yet, but am looking into it whenever
I have the time.

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

