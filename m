Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129043AbQKFSWy>; Mon, 6 Nov 2000 13:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129061AbQKFSWp>; Mon, 6 Nov 2000 13:22:45 -0500
Received: from [193.120.224.170] ([193.120.224.170]:56975 "EHLO
	florence.itg.ie") by vger.kernel.org with ESMTP id <S129043AbQKFSWf>;
	Mon, 6 Nov 2000 13:22:35 -0500
Date: Mon, 6 Nov 2000 18:22:10 +0000 (GMT)
From: Paul Jakma <paulj@itg.ie>
To: David Woodhouse <dwmw2@infradead.org>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Dan Hollis <goemon@anime.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Oliver Xymoron <oxymoron@waste.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page] 
In-Reply-To: <28752.973510632@redhat.com>
Message-ID: <Pine.LNX.4.21.0011061814350.31802-100000@rossi.itg.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2000, David Woodhouse wrote:


> * Sound module is autoloaded again, default to zero levels.

so you use the 'post-install' option of modules.conf to run your
mixer-level setting script.

> 	This time it is _NOT_ fine. User is rightly pissed off :)
> 

even better: is there any pressing need for /all/ modules to be
auto-unloaded? things like sound modules should be statically loaded
at boot time and never removed for 99% of workstations i think.

i'd also like to see dist's adopt a nice config file specifying which
modules to statically load at boot-time. (i know i want i them
loaded). then maybe info from depmod could be applied to remove
redundant loads.

> The inter_module_xxx() stuff would facilitate this quite nicely.
> 

but if userspace can do it just as easily... (in the case of sound
modules anyway)

> --
> dwmw2

--paulj

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
