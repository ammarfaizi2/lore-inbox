Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316831AbSGXEr1>; Wed, 24 Jul 2002 00:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316852AbSGXEr1>; Wed, 24 Jul 2002 00:47:27 -0400
Received: from adsl-66-136-199-175.dsl.austtx.swbell.net ([66.136.199.175]:21636
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S316831AbSGXEr0>; Wed, 24 Jul 2002 00:47:26 -0400
Subject: Re: 2.4.19rc2aa1 VM too aggressive?
From: Austin Gonyou <austin@digitalroadkill.net>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Andrea Arcangeli <andrea@suse.de>, Johannes Erdfelt <johannes@erdfelt.com>,
       David Rees <dbr@greenhydrant.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44L.0207232121130.3086-100000@imladris.surriel.com>
References: <Pine.LNX.4.44L.0207232121130.3086-100000@imladris.surriel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1027486143.32523.2.camel@UberGeek.digitalroadkill.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 23 Jul 2002 23:49:03 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-23 at 19:21, Rik van Riel wrote:
...
> > if the app allocates and frees 150MB of shm per second that's what the
> > kernel has to show you.
> 
> Indeed, though I have to comment that that's rather interesting
> web server software ;)

I agree, but I'm not sure what else could be causing it, unless vmstat
is not calculating values correctly, like off by 1 values or something.
I take a look at my local box, not the same has his test environment,
but still, 512MB and Apache. I'll see what I can see, maybe we can shed
*some* light on this. :)

> Rik

-- 
Austin Gonyou <austin@digitalroadkill.net>
