Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbUJaTCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbUJaTCN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 14:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261591AbUJaTCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 14:02:13 -0500
Received: from gprs214-91.eurotel.cz ([160.218.214.91]:62340 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261578AbUJaTAM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 14:00:12 -0500
Date: Sun, 31 Oct 2004 19:59:55 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jan Kara <jack@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Configurable Magic Sysrq
Message-ID: <20041031185955.GC5578@elf.ucw.cz>
References: <20041029093941.GA2237@atrey.karlin.mff.cuni.cz> <20041029024651.1ebadf82.akpm@osdl.org> <20041029101758.GA7278@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029101758.GA7278@atrey.karlin.mff.cuni.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >    I know about a few people who would like to use some functionality of
> > >  the Magic Sysrq but don't want to enable all the functions it provides.
> > 
> > That's a new one.  Can you tell us more about why people want to do such a
> > thing?
>   For example in a computer lab at the university the admin don't want
> to allow users to Umount/Kill (mainly to make it harder for users to
> screw up the computer) but wants to allow SAK/Unraw.

In that particular computer lab, admin is *****, and paranoid one,
too. He's more worried about security that functionality, and then you
find suid bash in /tmp and learn that root password is name of the
laboratory, with first character uppercased. Heh.

BTW interesting things can be done with sak alone. (It is bye-bye
vlock -a, right?). Changing console log-level and info-prints could
lead to user seeing some info he's not allowed to see [perhaps part of
some password are in the registers because they are now memcopied?],
but I agree allowing that is probably okay.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
