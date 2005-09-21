Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbVIUKS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbVIUKS5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 06:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbVIUKS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 06:18:57 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:10184 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1750799AbVIUKS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 06:18:56 -0400
Date: Wed, 21 Sep 2005 12:18:55 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@osdl.org>, len.brown@intel.com,
       Pierre Ossman <drzeus-list@drzeus.cx>, acpi-devel@lists.sourceforge.net,
       ncunningham@cyclades.com, Masoud Sharbiani <masouds@masoud.ir>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] suspend: Cleanup calling of power off methods.
Message-ID: <20050921101855.GD25297@atrey.karlin.mff.cuni.cz>
References: <m1vf0vfa0o.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1vf0vfa0o.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> The S4 suspend code for PM_DISK_PLATFORM was also calling
> >> device_shutdown without setting system_state, and was
> >> not calling the appropriate reboot_notifier.
> >
> > ACK on both. But should not you submit patch via -mm, so it gets at
> > least some testing there?
> 
> The code is obviously correct, and the people with the problem
> have reported that this approach solves it.
> 
> If this bit of functionality is to even work we need to do
> something like this.
> 
> So I don't see what benefit putting this in -mm would give.  If
> I was aggressive I would say that this needs to be in 2.6.13.N.
> If I'm not following some procedure I don't have a problem
> changing though.

I think you are not following the proper procedure. All the patches
should go through akpm.
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
