Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932498AbVIHBA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbVIHBA5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 21:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbVIHBA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 21:00:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47500 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932483AbVIHBA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 21:00:56 -0400
Date: Wed, 7 Sep 2005 17:59:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, axboe@suse.de, greg@kroah.com
Subject: Re: [GIT PATCH] SCSI merge for 2.6.13
Message-Id: <20050907175906.09b0a46f.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509071743380.11102@g5.osdl.org>
References: <1126053452.5012.28.camel@mulgrave>
	<Pine.LNX.4.58.0509071730490.11102@g5.osdl.org>
	<Pine.LNX.4.58.0509071738050.11102@g5.osdl.org>
	<Pine.LNX.4.58.0509071743380.11102@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> 
> On Wed, 7 Sep 2005, Linus Torvalds wrote:
> > 
> > Quite frankly, what's the point in asking people to pull a tree that is 
> > known to not compile?

James was assuming you'd merged the klist patch whcih I'd sent beforehand.

> Btw, I see the patch that is supposed to fix it, but I'm in no position to
> know whether it's even acceptable to basically double the size of the
> "struct klist", for example. There may be a good reason why Greg hasn't 
> been merging the klist stuff,

This patch came out around the time Greg went walkabout.

I'd suggest we merge the klist patch anyway, so it doesn't hold up scsi. 
If Greg wants to fix that bug by other means later on, we can do that
anytime.
