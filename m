Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261730AbULZSqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbULZSqn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 13:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbULZSqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 13:46:43 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:31461 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261730AbULZSqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 13:46:39 -0500
Subject: Re: [BK] disconnected operation
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Larry McVoy <lm@bitmover.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20041226183541.GA28952@work.bitmover.com>
References: <1104077531.5268.32.camel@mulgrave>
	 <20041226162727.GA27116@work.bitmover.com>
	 <1104079394.5268.34.camel@mulgrave>
	 <20041226171900.GA27706@work.bitmover.com>
	 <1104085546.5268.38.camel@mulgrave>
	 <20041226183541.GA28952@work.bitmover.com>
Content-Type: text/plain
Date: Sun, 26 Dec 2004 12:46:32 -0600
Message-Id: <1104086792.5268.43.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-12-26 at 10:35 -0800, Larry McVoy wrote:
> OK, cool.  We can keep going back and forth or if you wish you can send me
> the mailbox of patches and the cset key to which they should be applied 
> and I'll try it.

That might be easier, since BK operations take a large amount of time on
my laptop.  I'll send you the emails under separate cover.

> Can you do a "bk lease renew" before you start the process, then do a
> "bk lease show" to make sure it took?  When it starts to fail I'd like
> to know what time your computer thinks it is.  Is it possible that you
> are using your net connection to maintain your date and then when you
> disconnect your date warps forward?  Does this always happen at the 
> 3rd commit?

I did do a bk lease renew at the top (in the log).  My clock is
controlled by NTP, but it just syncs to the localhost fudge when it
loses all net connection.  The time doesn't jump when this happens (it
does drift by a few hundred milliseconds every hour or so I remain
disconnected, though).

Where it happens seems to be variable.  Most often it's the first or
second commit.

James


