Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264585AbTLCPAL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 10:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264589AbTLCPAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 10:00:10 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:14258 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264585AbTLCPAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 10:00:05 -0500
Date: Wed, 3 Dec 2003 16:00:01 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 future
Message-ID: <20031203150001.GA11687@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031203103634.GA6449@merlin.emma.line.org> <Pine.LNX.4.44.0312032234520.2968-100000@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312032234520.2968-100000@raven.themaw.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Dec 2003, Ian Kent wrote:

> > It's fragile currently, and if there are changes that make the beast
> > solid, I'm all for it, and the whole discussion can be killed right here
> > because it's a "bugfix" in that case. After all, autofs4 is a
> > pre-something stuff and going "gold" is certainly a fix.
> 
> And that would be 4.1.0-beta3 you are talking about right?
> Perhaps you could tell me about your problems and I'll put them on my 
> growing todo list for 4.1.1.

I'd need to find and evaluate your 4.1.0-beta works first. Oops, I've
got it, I should look into
http://www.de.kernel.org/pub/linux/daemons/autofs/v4/ :-)

Being used to a different directory layout, I looked into the testing
directories and didn't notice there was an actual 4.0.0 version. Wee.

> > If there are optional features, well, they might have to be split out to
> > a separate patch or #ifdef'd out - but I direly hope that autofs4 will
> > improve.
> 
> The kernel module is only needed to provide support for browsable 
> directories (I coined it 'ghost'ing directories in autofs v4). The 
> difficulty is many people don't like, and should not have 
> to, patch the kernel to get the full functionality of the daemon.

User-space issues should not be discussed on linux-kernel in the first
place. If the user-space daemon just disables those features it doesn't
find kernel support for, no-one has any ground to base a complaint on.

For my purposes, I don't *really* need browsable top-level directories
(for /net or /host style mounts), I'm used to giving the name explicitly
to trigger the mount, and if that works RELIABLY (i. e. picking up old
mounts after coming back after a daemon dcrash), that's most I need on
short notice :-)

I cannot make a qualified statement yet as the most current version I've
in production is 4.0.0pre10, and that's pretty aged. I'll review the
4.0.0 and 4.1.0-beta3 versions later and see if they rid me of some
"stale NFS file handle" that keep haunting my LAN.

Either way, your work is much welcome and appreciated. Before even
looking at the results, thank you for the effort put into this software.

I'll come back to you later with my findings - might be "week-end"
though.

Best regards,
Matthias
