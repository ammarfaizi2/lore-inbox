Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261337AbSIWTLH>; Mon, 23 Sep 2002 15:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261404AbSIWTJ5>; Mon, 23 Sep 2002 15:09:57 -0400
Received: from zeus.kernel.org ([204.152.189.113]:27041 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261338AbSIWSlr>;
	Mon, 23 Sep 2002 14:41:47 -0400
Date: Mon, 23 Sep 2002 12:10:46 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Jamie Zawinski <jwz@jwz.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel oops, 2.4.19
In-Reply-To: <3D881ABB.5C65CD87@jwz.org>
Message-ID: <Pine.LNX.4.44.0209231210250.922-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Sep 2002, Jamie Zawinski wrote:

> A while back I described some weird kernel oopses I was getting with
> the Red Hat version of 2.4.18; a few people said that it could be due
> to Red Hat changes, and that I should try a kernel.org kernel.  Well,
> I finally did -- downloaded 2.4.19 from kernel.org yesterday, compiled
> and booted it, and today my X server got shot down with a
> similar-looking syslog entry (which follows.)
>
> I've checked my RAM with memtest86 3.0 with no errors.
>
> Details on the machine config and the previous crashes I had with
> RH's 2.4.18-3 and 2.4.18-5 are here:
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=69852
>
> I managed to run "top" on another terminal after X had hung, but
> before it had died (or at least, before the screen cleared) and it
> showed:
>
>    10:59pm  up 1 day,  3:22,  1 user,  load average: 3.98, 2.19, 1.45
>   78 processes: 68 sleeping, 7 running, 0 zombie, 3 stopped
>   CPU states: 16.3% user,  2.1% system,  3.0% nice, 34.8% idle
>   Mem:   321588K av,  289888K used,   31700K free,       0K shrd,   15564K buff
>   Swap:  369380K av,   11136K used,  358244K free                  223164K cached
>
> so it doesn't look like memory was a problem.
>
> Here's the latest oops.  Any suggestions?

Your kernel seems to be tainted. Are you using any binary-only module?

