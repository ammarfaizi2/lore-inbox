Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751004AbWIXQN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbWIXQN6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 12:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWIXQN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 12:13:58 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:16906 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751177AbWIXQN6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 12:13:58 -0400
Date: Sun, 24 Sep 2006 10:17:53 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Adrian Bunk <bunk@stusta.de>
Cc: Willy Tarreau <w@1wt.eu>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.30-pre1
Message-ID: <20060924101753.GB4813@ucw.cz>
References: <20060922222300.GA5566@stusta.de> <20060922223859.GB21772@kroah.com> <20060922224735.GB5566@stusta.de> <20060922230928.GB22830@kroah.com> <20060923045610.GM541@1wt.eu> <20060923232150.GK5566@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060923232150.GK5566@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Adrian, when you have a doubt whether such a fix should go into next
> > release, simply tell people about the problem and ask them to test
> > current driver. If nobody encounters the problem, you can safely keep
> > the patch in your fridge until someone complains. By that time, the
> > risks associated with this patch will be better known.
> 
> It's not that I wanted to upgrade ACPI to the latest version.
> 
> And my rules are:
> - patch must be in Linus' tree
> - I'm asking the patch authors and maintainers of the affected subsystem
>   whether the patch is OK for 2.6.16

I thought stable rules were longer than this... including 'patch must
be < 100 lines' and 'must be bugfix for serious bug'. Changing rules
for -stable series in the middle of it seems like a bad idea...

Maybe you can keep -ab with relaxed rules and -stable with original
rules?

							Pavel
-- 
Thanks for all the (sleeping) penguins.
