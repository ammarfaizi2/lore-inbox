Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131411AbRCWUKb>; Fri, 23 Mar 2001 15:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131412AbRCWUKV>; Fri, 23 Mar 2001 15:10:21 -0500
Received: from [213.96.124.18] ([213.96.124.18]:34026 "HELO dardhal")
	by vger.kernel.org with SMTP id <S131411AbRCWUKG>;
	Fri, 23 Mar 2001 15:10:06 -0500
Date: Fri, 23 Mar 2001 21:11:10 +0000
From: José Luis Domingo López 
	<jldomingo@crosswinds.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
Message-ID: <20010323211110.A1441@dardhal.mired.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010323015358Z129164-406+3041@vger.kernel.org> <Pine.LNX.4.21.0103230403370.29682-100000@imladris.rielhome.conectiva> <20010323122815.A6428@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010323122815.A6428@win.tue.nl>; from dwguest@win.tue.nl on Fri, Mar 23, 2001 at 12:28:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 23 March 2001, at 12:28:15 +0100,
Guest section DW wrote:

> [...]
> To a murderer: "Why did you kill that old lady?"
> Reply: "I won't defend that deed, but who else should I have killed?"
> 
No comments.

> Andries - getting more and more unhappy with OOM
> 
> Mar 23 11:48:49 mette kernel: Out of Memory: Killed process 2019 (emacs).
> Mar 23 11:48:49 mette kernel: Out of Memory: Killed process 1407 (emacs).
> Mar 23 11:48:50 mette kernel: Out of Memory: Killed process 1495 (emacs).
> Mar 23 11:48:50 mette kernel: Out of Memory: Killed process 2800 (rpm).
> 
> [yes, that was rpm growing too large, taking a few emacs sessions]
> [2.4.2]
>
OOM clearly didn't work perfectly in this case, but it worked and left
your machine usable (maybe you lost data on your emacs sessions). From my
(OS design newbie) point of view, there must be quite difficult to keep
track of all system processes, and even a resource intensive task.

If you can do it better, come up with a kernel patch, submit it, and get
credit and fame for it. I would love to see Linux as the perfect OS for
everyone, but won't ever complain about each other's work, mainly when I'm
unable to contribute a thing.

-- 
José Luis Domingo López
Linux Registered User #189436     Debian GNU/Linux Potato (P166 64 MB RAM)
 
jdomingo AT internautas DOT   org  => Spam at your own risk

