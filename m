Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbWEHQ5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbWEHQ5d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 12:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbWEHQ5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 12:57:33 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29458 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932425AbWEHQ5c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 12:57:32 -0400
Date: Mon, 8 May 2006 11:29:15 +0000
From: Pavel Machek <pavel@suse.cz>
To: Wong Edison <hswong3i@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] TCP congestion module: add TCP-LP supporting for 2.6.16.14
Message-ID: <20060508112915.GB4162@ucw.cz>
References: <3feffd230605062232m1b9a3951h6d21071cdacc890f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3feffd230605062232m1b9a3951h6d21071cdacc890f@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> TCP Low Priority is a distributed algorithm whose goal 
> is to utilize only
> the excess network bandwidth as compared to the ``fair 
> share`` of
> bandwidth as targeted by TCP. Available from:
>   http://www.ece.rice.edu/~akuzma/Doc/akuzma/TCP-LP.pdf

Nice... I'd like to use something like this on my (overloaded)
GPRS/EDGE link.

Unfortunately, patch does not include documentation update AFAICS. How
do I use it? net-nice -n 19 rsync would be nice, but I guess that
would be quite complex...?
							Pavel
-- 
Thanks for all the (sleeping) penguins.
