Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271365AbRHOTAy>; Wed, 15 Aug 2001 15:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271366AbRHOTAo>; Wed, 15 Aug 2001 15:00:44 -0400
Received: from [205.201.12.35] ([205.201.12.35]:49786 "EHLO odin.buserror.net")
	by vger.kernel.org with ESMTP id <S271365AbRHOTAj>;
	Wed, 15 Aug 2001 15:00:39 -0400
Date: Tue, 14 Aug 2001 13:47:21 -0400
To: David Schwartz <davids@webmaster.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Is there something that can be done against this ???
Message-ID: <20010814134721.A28589@odin>
In-Reply-To: <3B78DE6D.E8DB6B7C@trader.com> <NOEJJDACGOHCKNCOGFOMKENKDCAA.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <NOEJJDACGOHCKNCOGFOMKENKDCAA.davids@webmaster.com>; from davids@webmaster.com on Tue, Aug 14, 2001 at 03:00:58AM -0700
From: Scott Wood <scott@buserror.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2001 at 03:00:58AM -0700, David Schwartz wrote:
> 	Why? Is it because you don't trust your system security? Your operating
> system shouldn't let the script do anything you don't want it to do.

Anything?  How will it be prevented from being used to attack other machines
(other than attacks that require root on the attacking machine), or to relay
spam, or to act as a warez/mp3/whatever server (sure, quotas could be used,
but are they?  And even if they are, does it have enough space for a few
small titles)?

And if that account is also used for mail reading, it could send your
mailbox to the attacker, delete or alter your mail, etc.  It'd also have
access to a bunch of e-mail addresses that it could forward itself to.

> 	That should do no harm. What you mean to say is "if somebody is dumb enough
> to execute any program recieved by email under a user account that has
> permissions to modify files he cares about, consume too many process slots,
> consume excessive vm, or has other special capabilities".

And by default, even the nobody user can use virtually all the memory or
processes it wants.  Even with only a few process slots, it could steal a
decent amount of CPU cycles (hmm... a distributed.net worm? :-).

> 	If a user can run code that can harm the system, then nobody who isn't
> trusted not to harm the system can be a user. That's not how we want Linux
> to be, is it?

If you define "harm the system" as perform any unauthorized
externally-visible (relative to the sandbox) action, then Linux is a *long*
way from achieving that.

-Scott
