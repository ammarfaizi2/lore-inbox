Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262878AbVDHRMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbVDHRMr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 13:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262880AbVDHRMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 13:12:46 -0400
Received: from fire.osdl.org ([65.172.181.4]:13199 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262878AbVDHRMf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 13:12:35 -0400
Date: Fri, 8 Apr 2005 10:14:22 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
cc: Andrea Arcangeli <andrea@suse.de>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
In-Reply-To: <4256AE0D.201@tiscali.de>
Message-ID: <Pine.LNX.4.58.0504081010540.28951@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
 <20050408041341.GA8720@taniwha.stupidest.org> <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
 <20050408071428.GB3957@opteron.random> <Pine.LNX.4.58.0504080724550.28951@ppc970.osdl.org>
 <4256AE0D.201@tiscali.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Apr 2005, Matthias-Christian Ott wrote:
>
> SQL Databases like SQLite aren't slow.

After applying a patch, I can do a complete "show-diff" on the kernel tree
to see the effect of it in about 0.15 seconds.

Also, I can use rsync to efficiently replicate my database without having 
to re-send the whole crap - it only needs to send the new stuff.

You do that with an sql database, and I'll be impressed.

		Linus
