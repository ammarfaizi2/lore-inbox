Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265743AbUHHQL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265743AbUHHQL7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 12:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265770AbUHHQL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 12:11:58 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:51348 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S265743AbUHHQL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 12:11:57 -0400
Date: Sun, 8 Aug 2004 17:11:46 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andi Kleen <ak@muc.de>
cc: Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Allow to disable shmem.o
In-Reply-To: <20040808141908.GA94449@muc.de>
Message-ID: <Pine.LNX.4.44.0408081705100.1983-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 Aug 2004, Andi Kleen wrote:
> i suspect the standard functionality is already covered by CONFIG_EMBEDDED.

It would still be appropriate to say what functionality is lost
by configuring out, rather than leaving everyone to guess.

> > You're completely changing the meaning and configurability of
> > CONFIG_TMPFS.  Perhaps it's not a useful config option any more
> > (too often needed "y", too little saved by "n"), and yours is
> > more useful.  But if you want to go this way, you must change
> > its name and Documentation and #ifdefs too.
> 
> Perhaps, but calling it CONFIG_TMPFS is not too bad.

Okay, so I come along to clean up after you.  Yes, we could work it that
way.  But somehow I still prefer Matt's patch, which offers a lot more.

Hugh

