Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263938AbTFBVCn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 17:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263953AbTFBVCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 17:02:43 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:14475 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263938AbTFBVCj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 17:02:39 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 2 Jun 2003 14:13:43 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>
Subject: Re: [patch] epoll race fix for 2.5 ...
In-Reply-To: <200306022242.22879.m.c.p@wolk-project.de>
Message-ID: <Pine.LNX.4.55.0306021412520.3531@bigblue.dev.mcafeelabs.com>
References: <Pine.LNX.4.55.0305311458260.11255@bigblue.dev.mcafeelabs.com>
 <200306022242.22879.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jun 2003, Marc-Christian Petersen wrote:

> On Monday 02 June 2003 22:27, Davide Libenzi wrote:
>
> Hi Davide,
>
> > The was a race triggered by heavy MT usage that could have caused
> > processes in D state. Bad Davide, bad ...
> > Also, the semaphore is now per-epoll-fd and not global. Plus some comment
> > adjustment.
> > Updated patches for 2.4.{20,21-rc6} are here :
> > http://www.xmailserver.org/linux-patches/nio-improve.html#patches
> is it just me or am I too silly to follow your release name changes? ;)

I know :( the page is a mess :-) I should definitely restructure it


- Davide

