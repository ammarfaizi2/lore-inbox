Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268168AbUJJHkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268168AbUJJHkE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 03:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268169AbUJJHkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 03:40:04 -0400
Received: from main.gmane.org ([80.91.229.2]:16001 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268168AbUJJHj7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 03:39:59 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: Re: Weirdness with suspending jobs in 2.6.9-rc3
Date: Sun, 10 Oct 2004 00:39:55 -0700
Message-ID: <pan.2004.10.10.07.39.54.154306@triplehelix.org>
References: <20041005063324.GA7445@darjeeling.triplehelix.org> <20041009101552.GA3727@stusta.de> <20041009140551.58fce532.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-68-126-181-112.dsl.pltn13.pacbell.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 09 Oct 2004 14:05:51 -0700, Andrew Morton wrote:
> What about current -linus?

Also affected.
 
> Is there any way in which you can do a bit of bisecting, identify the
> offending patch?

It happened between 2.6.9-rc1-bk7 and 2.6.9-rc1-bk8. Roland's waitid patch
most likely breaks it but I'm too tired right now to specifically revert
that. If that's enough for you, well, fix it.. If not I'll try and narrow
it down tomorrow.

What kinds of machines are you people testing on? Perhaps it only happens
on UP. Andrew probably has some 12-way box to compile new -mm kernels
with which he's using..

-- 
Joshua Kwan


