Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264493AbUBOWU4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 17:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265211AbUBOWU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 17:20:56 -0500
Received: from dp.samba.org ([66.70.73.150]:33959 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264493AbUBOWUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 17:20:55 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ian Kent <raven@themaw.net>
Cc: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?= <ia6432@inbox.ru>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       autofs mailing list <autofs@linux.kernel.org>,
       nfs@lists.sourceforge.net
Subject: Re: [NFS] nfs or autofs related hangs 
In-reply-to: Your message of "Sun, 08 Feb 2004 23:32:08 +0800."
             <Pine.LNX.4.58.0402082326270.5926@raven.themaw.net> 
Date: Sun, 15 Feb 2004 19:53:52 +1100
Message-Id: <20040215222107.7E4382C2D8@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.58.0402082326270.5926@raven.themaw.net> you write:
> +static spinlock_t waitq_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;

Is this __cacheline_aligned_in_smp really required?

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
