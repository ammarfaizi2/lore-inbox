Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132883AbRDEM4r>; Thu, 5 Apr 2001 08:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132884AbRDEM4h>; Thu, 5 Apr 2001 08:56:37 -0400
Received: from pasky.ji.cz ([62.44.12.54]:8177 "EHLO pasky.ji.cz")
	by vger.kernel.org with ESMTP id <S132883AbRDEM4T>;
	Thu, 5 Apr 2001 08:56:19 -0400
Date: Thu, 5 Apr 2001 14:55:20 +0200
From: Petr Baudis <pasky@pasky.ji.cz>
To: linux-kernel@vger.kernel.org
Cc: ben@kalifornia.com
Subject: Re: bug database braindump from the kernel summit
Message-ID: <20010405145519.R22180@pasky.ji.cz>
Mail-Followup-To: linux-kernel@vger.kernel.org, ben@kalifornia.com
In-Reply-To: <Pine.LNX.4.33.0104011640280.25794-100000@dlang.diginsite.com> <3AC7C719.3080403@kalifornia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AC7C719.3080403@kalifornia.com>; from ben@kalifornia.com on Sun, Apr 01, 2001 at 05:26:01PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why not have the /proc/config option but instead of being plain text, 
> make it binary with a userspace app that can interpret it?
[snip]
> You'd have
> 2.4.3-pre3:1101111100000100000000 . . . . .
> 
I think this is against UNIX/Linux philosophy... Why we wouldn't just
providing all the interface through sysctl stuff and abadon all the
/proc? Cause we want to provide human-readable interface, which could
be parsed really simply...

We should just mean 'cat' as 'userspace app' primarily i think. At least
currently we does. Also you have a big problem with forward compatibility
etc.

But anyway i would vote for the .config file somewhere in /boot directory.
If one have a kernel from some linux distribution, it is propably actually
obsolete, so it is proximity the bug is actually fixed anyway. And if he
will get the newest kernel, it should do something like cp .config /boot/config.

-- 

				Peter "Pasky" Baudis

Whoever coded that patch should be taken out and shot, hung, drawn and
quartered then forced to write COBOL for the rest of their natural
life.
-- Keith Owens <kaos@ocs.com.au> in linux-kernel

My public PGP key is on: http://pasky.ji.cz/~pasky/pubkey.txt
-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCS d- s++:++ a--- C+++ UL++++$ P+ L+++ E--- W+ N !o K- w-- !O M-
!V PS+ !PE Y+ PGP+>++ t+ 5 X(+) R++ tv- b+ DI(+) D+ G e-> h! r% y?
------END GEEK CODE BLOCK------
