Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264609AbUEaXaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264609AbUEaXaL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 19:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264734AbUEaXaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 19:30:11 -0400
Received: from quechua.inka.de ([193.197.184.2]:26048 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S264609AbUEaXaH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 19:30:07 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
Organization: Deban GNU/Linux Homesite
In-Reply-To: <40BBB5F7.1010407@yahoo.com.au>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1BUwEH-00030X-00@calista.eckenfels.6bone.ka-ip.net>
Date: Tue, 01 Jun 2004 01:30:05 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <40BBB5F7.1010407@yahoo.com.au> you wrote:
> Well, at the "expense" of paging out unused memory. I don't see
> any swapin.

On a slow system with small memory you quite often see swapped out
applications like for example a kopete messenger windows. Once you click on
it, it takes 10sec or more to get responsive again. Of course its a slow
system, but gradually paging out and forgetting image pages has that effecct
on faster systems too, makes the desktop sluggish.

> Well yes, but if I had another 57MB of physical memory then I would
> still turn on swap so that other 57MB of unused memory isn't wasted.

Actually the number of totally unused memory is quite small. Therefore the
pages get swapped in sooner or later anyway. And even if you turn of fswap
completely, the image pages backed up by binaries on disk get still freeded,
if the code is unused. So on my multimedia system I prefer to have no swap
(1GB ram) and make sure the pages are not freeded so aggressivley to keep
the system smooth and responsive (and allow spin down of the disk).

Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
