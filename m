Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310426AbSCBTXf>; Sat, 2 Mar 2002 14:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310428AbSCBTXZ>; Sat, 2 Mar 2002 14:23:25 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:28939 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S310426AbSCBTXR>;
	Sat, 2 Mar 2002 14:23:17 -0500
Date: Fri, 1 Mar 2002 22:35:34 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrea Arcangeli <andrea@suse.de>
Cc: Teodor.Iacob@astral.kappa.ro, <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.18 : lots of "state D" processes ....
In-Reply-To: <20020302022853.E4431@inspiron.random>
Message-ID: <Pine.LNX.4.44L.0203012232560.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Mar 2002, Andrea Arcangeli wrote:
> On Fri, Mar 01, 2002 at 12:03:49AM +0200, Teodor Iacob wrote:
> > Ok, I rushed to reply but it seems like I still get the perl process in a
> > "D state", no matter if I compile USB as module or built-in, with rmap12g
> > or with your patch. Anyway to track this?
>
> SYSRQ+T run on top of 2.4.19pre1aa1 should allow to track down whatever
> USB problem it is.

I've seen this in 2.4.19-pre1 without USB, too.  Here the
tasks were stuck in do_fork() and got unstuck minutes
later.  They were not using any CPU time.

I'm not seeing any of these delays in -pre2 (yet?) and
haven't had any time yet to figure out what's going on...

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

