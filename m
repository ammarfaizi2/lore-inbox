Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbVH2DFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbVH2DFn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 23:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbVH2DFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 23:05:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37844 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750703AbVH2DFm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 23:05:42 -0400
Date: Sun, 28 Aug 2005 20:05:35 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.13
In-Reply-To: <9a87484905082817434c581942@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0508281958270.3243@g5.osdl.org>
References: <Pine.LNX.4.58.0508281708040.3243@g5.osdl.org>
 <9a87484905082817434c581942@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Aug 2005, Jesper Juhl wrote:
>
> http://www.kernel.org/pub/linux/kernel/v2.6/ChangeLog-2.6.13 seems to
> be the 2.6.13-rc7 -> 2.6.13 final ChangeLog. Any chance we could get
> the full 2.6.12 -> 2.6.13 ChangeLog up there?

Done.

(Well, it's going to take a while to mirror out).

That's 2.3MB of logs (even the shortlog weighs in at 5000+ lines and
201kB, if anybody cares. I didn't upload that, and the kernel mailing list
limits don't allow me to put it here, but git users can do

	git-rev-list --pretty=short v2.6.12..v2.6.13 | git-shortlog

to generate it. You might additionally want to add a "--no-merges" if you
don't want to see people doing non-linear merges).

		Linus
