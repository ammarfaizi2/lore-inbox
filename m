Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751449AbWEDJE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbWEDJE4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 05:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWEDJE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 05:04:56 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:33678 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751449AbWEDJE4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 05:04:56 -0400
Message-ID: <4459C30C.4080309@aitel.hist.no>
Date: Thu, 04 May 2006 11:02:04 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [RFC] kernel facilities for cache prefetching
References: <346556235.24875@ustc.edu.cn>
In-Reply-To: <346556235.24875@ustc.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang wrote:

>	Rapid linux desktop startup through pre-caching
>
>
>MOTIVATION
>
>	KDE, Gnome, OpenOffice, and Firefox all take too long to start up.
>	Boot time pre-caching seems to be the single most straightforward and
>	effective way to improve it and make linux desktop experience more
>	comfortable. It is a great pleasure for me to take up the work.
>  
>
Actually, the best way is to not run so much software.  An yes,
that is an option.  I won't say no to an improved kernel too though. :-)

The apps mentioned are popular, but few needs *all* of them.
One can do without KDE and gnome, run a nice lightweight
window manager instead.  Take the kde/gnome performance hit
only when you actually need some kde/gnome app. Not every day.
A nice windowmanager like icewm of fluxbox brings the login
delay down to 3s or so for me.

Openoffice has lightweight alternatives for every task.
(abiword,lyx,gnumeric, . . . )  Strange that this bloated sw is
as popular as it is, given the many alternatives.  Not something
I use every month, and I use linux exclusively for my office tasks.

Another alternative is to profile the slow apps and improve them.
Fix algorithms, optimize stuff. 

The slow boot is fixable by:
1) run boot scripts in parallell instead of sequentially - somewhat 
experimental
    but helps.  Especially if you can bring up X before slowest stuff 
completes.
2) Don't run what you don't use/need!  Don't install everything and the 
kitchen
    sink just because it is free software.  I am guilty of installing 
too much myself,
    so I suffer 40-second bootup time.  But I don't reboot my office pc 
every
    week, normally I only have that 3s login delay.

Helge Hafting


