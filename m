Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268405AbUIGS2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268405AbUIGS2q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 14:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268379AbUIGSWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 14:22:14 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:49838 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S268356AbUIGSS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 14:18:28 -0400
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Current state of UML - some help needed from mainline.
Date: Tue, 7 Sep 2004 20:13:49 +0200
User-Agent: KMail/1.6.1
Cc: Jeff Garzik <jgarzik@pobox.com>, Jeff Dike <jdike@addtoit.com>,
       user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <200408190301.i7J30xek004150@ccure.user-mode-linux.org> <413B76DB.5010600@pobox.com> <200409061956.34557.blaisorblade_spam@yahoo.it>
In-Reply-To: <200409061956.34557.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409072013.49494.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For LKML: I'm not subscribed, so don't forget to CC me.
On Monday 06 September 2004 19:56, BlaisorBlade wrote:
> On Sunday 05 September 2004 22:28, Jeff Garzik wrote:
> > Overall I am really impressed.  Like other arches in the Linux kernel,
> > it is IMO very important to be able to work "out of the box", without
> > patches.
Yes - especially when microAPI changes happen every day, as of 2.6. I've just 
downloaded a snapshot including the merge, so I'll be able to merge some 
little fixes which have happened since.

Do you think that keeping a UML tree for new, experimental features is a good 
idea, or that this role should go to -mm?

I ask this also because I don't know how much would help general review for 
new features.

For instance, the "hostfs" feature is in the middle of a rewrite and the new 
code is still very broken (the current release says more or less "VFS: busy 
inodes after unmount - self destroying in 5 seconds. Have a nice day", but 
maybe this is fixed; plus has a number of other bugs).

Also, SMP hasn't compiled for a while, so there is a number of locking problem 
- at least one straight deadlock in the ubd driver when passing ubd=sync. 
It's not a hard problem - just not yet fixed it.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
