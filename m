Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275206AbRIZOX7>; Wed, 26 Sep 2001 10:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275228AbRIZOXu>; Wed, 26 Sep 2001 10:23:50 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:46349 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S275206AbRIZOXj>;
	Wed, 26 Sep 2001 10:23:39 -0400
Date: Wed, 26 Sep 2001 11:23:44 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Craig Kulesa <ckulesa@as.arizona.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: VM in 2.4.10(+tweaks) vs. 2.4.9-ac14/15(+stuff)
In-Reply-To: <20010926160347.F27945@athlon.random>
Message-ID: <Pine.LNX.4.33L.0109261123070.19147-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2001, Andrea Arcangeli wrote:
> On Wed, Sep 26, 2001 at 06:38:48AM -0700, Craig Kulesa wrote:
> > in memory, and is swapping out harder to compensate.  The ac14/ac15 tree
>
> 2.4.10 is swapping out more also because I don't keep track of which
> pages are just uptodate on the swap space. This will be fixed as soon
> as I teach get_swap_page to collect away from the swapcache mapped
> exclusive swap pages.

Wouldn't that be easier to do from try_to_swap_out() ?

cheers,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

