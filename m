Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbVKVWyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbVKVWyo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 17:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbVKVWyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 17:54:44 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:61677 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030217AbVKVWyn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 17:54:43 -0500
Date: Tue, 22 Nov 2005 23:54:28 +0100
From: Pavel Machek <pavel@suse.cz>
To: Rob Landley <rob@landley.net>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] make miniconfig (take 2)
Message-ID: <20051122225428.GJ1748@elf.ucw.cz>
References: <200511170629.42389.rob@landley.net> <200511211253.40212.rob@landley.net> <20051121192431.GJ29518@elf.ucw.cz> <200511212314.41605.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511212314.41605.rob@landley.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> P.S.  I don't use git.  Poked at it a few times, but I made the mistake of 
> reading largeish chunks of the git man page and the git glossary in an 
> attempt to get up to speed, and got a headache.  Anything that can define 
> "clean" in such a way that I'm _less_ sure of the definition afterwards:
> http://www.kernel.org/pub/software/scm/git/docs/glossary.html
> Learning git went back on the to-do list somewhere between cleaning behind the 
> refrigerator and sorting my book collection by author...

Getting latest try via git is _really_ easy:


mkdir clean-cg; cd clean-cg
cg-init
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

... Do cg-update origin to pickup latest changes from Linus. You can
do cg-diff to see what changes you done in your local tree. cg-cancel
will kill any such changes, and cg-commit will make them permanent.

Sorry, I did not have time to look what's wrong with miniconfig, yet.

								Pavel

-- 
Thanks, Sharp!
