Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932629AbVKXLls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932629AbVKXLls (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 06:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932630AbVKXLls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 06:41:48 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:178 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932629AbVKXLlr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 06:41:47 -0500
Date: Thu, 24 Nov 2005 12:41:36 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] Add try_to_freeze to kauditd
Message-ID: <20051124114136.GA25197@elf.ucw.cz>
References: <20051107071300.7073.47106.stgit@poseidon.drzeus.cx> <4385844C.5080707@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4385844C.5080707@drzeus.cx>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >kauditd was causing suspends to fail because it refused to freeze.
> >Adding a try_to_freeze() to its sleep loop solves the issue.
> >
> >Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
> >Acked-by: Pavel Machek <pavel@suse.cz>
> >---
> >
> > kernel/audit.c |    4 +++-
> > 1 files changed, 3 insertions(+), 1 deletions(-)
> >
> >  
> 
> Did anyone actually pick this up? Its not in -mm or Linus' tree.

Not me... I do not think it needs to go through my trees, should be
simple enough to go to -mm directly.
								Pavel
-- 
Thanks, Sharp!
