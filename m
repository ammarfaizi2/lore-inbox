Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131304AbRDBVgu>; Mon, 2 Apr 2001 17:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131320AbRDBVgk>; Mon, 2 Apr 2001 17:36:40 -0400
Received: from ohiper3-113.apex.net ([209.250.52.128]:24328 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S131304AbRDBVgZ>; Mon, 2 Apr 2001 17:36:25 -0400
Date: Mon, 2 Apr 2001 16:35:10 -0500
From: Steven Walter <trwalter@apex.net>
To: Richard Russon <kernel@flatcap.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug database braindump from the kernel summit
Message-ID: <20010402163510.A26109@hapablap.dyn.dhs.org>
In-Reply-To: <Pine.LNX.3.96.1010401181724.28121i-100000@mandrakesoft.mandrakesoft.com> <986189206.789.0.camel@home.flatcap.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <986189206.789.0.camel@home.flatcap.org>; from kernel@flatcap.org on Mon, Apr 02, 2001 at 06:26:45AM +0100
X-Uptime: 4:21pm  up 1 day, 38 min,  1 user,  load average: 1.03, 1.08, 1.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2001 at 06:26:45AM +0100, Richard Russon wrote:
> On 01 Apr 2001 18:21:29 -0500, Jeff Garzik wrote:
> > Let's hope it's not a flamewar, but here goes :)
> > 
> > We -need- .config, but /proc/config seems like pure bloat.
> 
> Don't ask me for sample code, but...
> 
> The init code for many drivers is freed up after it's used.
> Could we apply the same technique and compile in .config,
> then printk the entire lot (boot option) and free up the
> space afterwards?

Though this would save memory at run-time, you'd still increase the size
of the image.

-- 
-Steven
Freedom is the freedom to say that two plus two equals four.
