Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbULAJUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbULAJUg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 04:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbULAJUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 04:20:35 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:8379 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261346AbULAJUb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 04:20:31 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 1 Dec 2004 10:02:03 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       jdike@addtoit.com, bstroesser@fujitsu-siemens.com,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: VFS interactions with UML and other big UML changes (was: Re: [patch 1/2] Uml - first part rework of run_helper() and users.)
Message-ID: <20041201090203.GD12963@bytesex>
References: <20041130200845.2C5058BAFE@zion.localdomain> <20041130152017.129e134c.akpm@osdl.org> <200412010120.39579.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412010120.39579.blaisorblade_spam@yahoo.it>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > uml-terminal-cleanup.patch
> 
> I don't know technically this one. It won't probably go in 2.6.10, I think 
> later... tested in the SuSE tree, but let's be quiet in merging _big_ things, 
> ok? It was also tested in a different tree, so it perfectly working on 2.6.9 
> does not mean perfectly working on current kernels.

Tested by me on 2.6.10-rc2-bk<something> as well.  It needed some
trivial adaptions to the tty layer changes done by Linus compared
to the old 2.6.9 version.  I'm pretty confident it wouldn't break
anything, but as it is to big to be classified as ObviouslyCorrect[tm]
fix it probably should not go to into 2.6.10 but be merged in the
2.6.11 cycle.

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
