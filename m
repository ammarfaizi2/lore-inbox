Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVCESi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVCESi5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 13:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbVCESiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 13:38:03 -0500
Received: from ishtar.tlinx.org ([64.81.245.74]:58603 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S261264AbVCESdY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 13:33:24 -0500
Message-ID: <4229FB57.70309@tlinx.org>
Date: Sat, 05 Mar 2005 10:32:55 -0800
From: "L. A. Walsh" <lkml@tlinx.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org, chrisw@osdl.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Linux 2.6.11.1
References: <20050304175302.GA29289@kroah.com>
In-Reply-To: <20050304175302.GA29289@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many, many thanks...it's a great idea and seems to go well
with Linus's idea of making even releases "hyper-stable".

This is exactly what I was looking for in
(http://article.gmane.org/gmane.linux.kernel/268836)

Sorry some of you feel like "suckers"...but you're _not_.
You're heroes -- doing the hard sh*t that most programmers
don't want to be bothered with.  I salute you!

Linda W.

Greg KH wrote:

>For those of you who haven't waded through the huge "RFD: Kernel release
>numbering" thread on lkml to realize that we are now going to start
>putting out 2.6.x.y releases, here's the summary:
>
>	A few of us $suckers will be trying to maintain a 2.6.x.y set of
>	releases that happen after 2.6.x is released.  It will contain
>	only a set of bugfixes and security fixes that meet a strict set
>	of guidelines, as defined by Linus at:
>		http://article.gmane.org/gmane.linux.kernel/283396
>
>Chris Wright and I are going to start working on doing this work, we
>will have a <SOME_ALIAS>@kernel.org to post these types of bug fixes to,
>and a set of people we bounce the patches off of to test for "smells
>good" validation.  We will also have a bk-commits type mailing list for
>those who want to watch the patches flow in, and a bk tree from which
>changsets can be pulled from.
>
>Chris and I will be hashing all of the details out next Tuesday, and
>hopefully all the infrastructure will be in place soon.  When that
>happens, we will post the full details on how all of this is going to
>work.  In the meantime, feel free to CC: me and Chris on patches that
>everyone thinks should go into the 2.6.11.y releases.
>
>But right now, Chris is on a plane, and we don't have the email alias
>set up, or the proper permissions set up on kernel.org to push changes
>into the v2.6 directory, but we have a few bugs that are needing to be
>fixed in the 2.6.11 release.  And since our mantra is, "release early
>and often", here's the first release.
>
>---------------
>
>I've released the 2.6.11.1 patch:
>	kernel.org/pub/linux/kernel/people/gregkh/v2.6.11/patch-2.6.11.1.gz
>
>With a detailed changelog at:
>	kernel.org/pub/linux/kernel/people/gregkh/v2.6.11/ChangeLog-2.6.11.1
>
>A bitkeeper tree for the 2.6.11.y releases can be found at:
>	bk://linux-release.bkbits.net/linux-2.6.11
>
>The diffstat and short summary of the fixes are below.  
>
>I'll also be replying to this message with a copy of the patch itself,
>as it is small enough to do so.
>
>thanks,
>
>greg k-h
>
>-------
>
> Makefile                              |    2 +-
> drivers/input/serio/i8042-x86ia64io.h |    6 +++---
> drivers/md/raid6altivec.uc            |    4 ++++
> 3 files changed, 8 insertions(+), 4 deletions(-)
>
>
>Summary of changes from v2.6.11 to v2.6.11.1
>============================================
>
>Dmitry Torokhov:
>  o Fix keyboards for Dell machines
>
>Greg Kroah-Hartman:
>  o Linux 2.6.11.1
>
>Olof Johansson:
>  o Fix for trivial fix for 2.6.11 raid6 compilation on ppc w/ Altivec
>
>Rene Rebe:
>  o trivial fix for 2.6.11 raid6 compilation on ppc w/ Altivec
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>
