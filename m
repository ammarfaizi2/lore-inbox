Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWIJJet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWIJJet (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 05:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWIJJet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 05:34:49 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:24841 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750807AbWIJJer
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 05:34:47 -0400
Date: Sat, 9 Sep 2006 11:59:54 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: David Madore <david.madore@ens.fr>,
       Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
Message-ID: <20060909115954.GB4277@ucw.cz>
References: <20060908225118.GB877@clipper.ens.fr> <20060909001113.97649.qmail@web36612.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060909001113.97649.qmail@web36612.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, I could imagine that a paranoid sysadmin might
> > want some users'
> > processes to run without this or that capability
> > (perhaps
> > CAP_REG_PTRACE or some other yet-to-be-defined
> > capability).  This
> > doesn't mean that they shouldn't be able to run a
> > game which runs sgid
> > in order to write the score file.
> 
> A likely scenario might be the 3rd party program
> that you really are sure about trusting. You
> give it a capability set that has nothing in it
> (hence runs without capability regardless of
> the capabilities of the parent). That's part
> of the rationale behind the POSIX scheme, that
> some programs you just don't want to ever run
> privileged, period. But POSIX only deals with
> going "above" base, which is why I like the
> notion of your "underprivileged" scheme as a
> seperate addition.

Well, in kernel above-priviledge and below-priviledge makes sense to
be handled by same code. You can always create interface you prefer in
glibc...
						Pavel

-- 
Thanks for all the (sleeping) penguins.
