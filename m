Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271431AbRHZTAz>; Sun, 26 Aug 2001 15:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271432AbRHZTAp>; Sun, 26 Aug 2001 15:00:45 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:65294 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S271431AbRHZTAd>;
	Sun, 26 Aug 2001 15:00:33 -0400
Date: Sun, 26 Aug 2001 16:00:28 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Swap reclaiming
In-Reply-To: <20010826190121.A24395@bug.ucw.cz>
Message-ID: <Pine.LNX.4.33L.0108261559200.5646-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Aug 2001, Pavel Machek wrote:

	[snip swap full code]

> Hmm... This kind-of defeats purposes on swap priorities: with this,
> you are going to fill slow swap even through there is lots of fast
> swap that could be reclaimed.

When swap fills up, we will start freeing swap space on swapin.

This means that we'll free up space in both fast and slow swap.

> I'm not sure what fix should be.

I'm not sure what the problem would be ;)

(but would love a more detailed explanation if you
really have found a problem)

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

