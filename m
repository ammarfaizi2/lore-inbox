Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286179AbSAGT6T>; Mon, 7 Jan 2002 14:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286184AbSAGT6J>; Mon, 7 Jan 2002 14:58:09 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:9483 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S286179AbSAGT6A>;
	Mon, 7 Jan 2002 14:58:00 -0500
Date: Mon, 7 Jan 2002 17:57:30 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: Pavel Machek <pavel@suse.cz>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFT] simple deadline I/O scheduler
In-Reply-To: <Pine.LNX.4.33.0201071429470.5017-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.33L.0201071756580.872-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2002, Mark Hahn wrote:

> > Would it be possible to introduce concept of I/O priority? I.e. I want
> > updatedb not to load disk if I need it for something else?
>
> makes sense to me.  actually, VM is another place where priority
> could be quite useful - for instance, how hard the VM scavenges
> a proc's pages.  oops, there I go advocating a tunable...
>
> VM_SWAP_ME_HARDER anyone?

This seems to work very badly, making one process swap more
means it pagefaults more and sucks up more IO bandwidth ;)

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

