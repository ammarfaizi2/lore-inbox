Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265816AbUAKJh5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 04:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265817AbUAKJh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 04:37:57 -0500
Received: from smtp2.fre.skanova.net ([195.67.227.95]:36593 "EHLO
	smtp2.fre.skanova.net") by vger.kernel.org with ESMTP
	id S265816AbUAKJhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 04:37:45 -0500
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Increase recursive symlink limit from 5 to 8
References: <E1AeMqJ-00022k-00@minerva.hungry.com>
	<2flllofnvp6.fsf@saruman.uio.no>
	<microsoft-free.87isjj0y1e.fsf@eicq.dnsalias.org>
From: Peter Osterlund <petero2@telia.com>
Date: 11 Jan 2004 10:37:42 +0100
In-Reply-To: <microsoft-free.87isjj0y1e.fsf@eicq.dnsalias.org>
Message-ID: <m27jzyrfkp.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Youngs <sryoungs@bigpond.net.au> writes:

> * Petter Reinholdtsen <pere@hungry.com> writes:
> 
>   >   Linux:         Symlink limit seem to be 6 path entities.
>   >   AIX:           Symlink limit seem to be 21 path entities.
>   >   HP-UX:         Symlink limit seem to be 21 path entities.
>   >   Solaris:       Symlink limit seem to be 21 path entities.
>   >   Irix:          Symlink limit seem to be 31 path entities.
>   >   Mac OS X:      Symlink limit seem to be 33 path entities.
>   >   Tru64 Unix:    Symlink limit seem to be 65 path entities.
> 
>   > I really think this limit should be increased in Linux.  Not sure
>   > how high it should go, but from 5 to somewhere between 20 and 64
>   > seem like a good idea to me.
> 
> 6 does seem pretty low.  What was the reason for setting it there?  Is
> there a downside to increasing it?

Search the archives for "symlink recursion":

http://marc.theaimsgroup.com/?l=linux-kernel&w=2&r=1&s=symlink+recursion&q=b

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
