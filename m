Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbULZSfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbULZSfv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 13:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbULZSfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 13:35:51 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:53984 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S261726AbULZSfq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 13:35:46 -0500
Date: Sun, 26 Dec 2004 10:35:41 -0800
From: Larry McVoy <lm@bitmover.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Larry McVoy <lm@bitmover.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK] disconnected operation
Message-ID: <20041226183541.GA28952@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Larry McVoy <lm@bitmover.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <1104077531.5268.32.camel@mulgrave> <20041226162727.GA27116@work.bitmover.com> <1104079394.5268.34.camel@mulgrave> <20041226171900.GA27706@work.bitmover.com> <1104085546.5268.38.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1104085546.5268.38.camel@mulgrave>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, I cloned a new repository and started applying patches to it.  The
> transcript of what I did is attached.  You can see that after I
> disconnect from the network, I get three emails imported before it spits
> an error at me.

OK, cool.  We can keep going back and forth or if you wish you can send me
the mailbox of patches and the cset key to which they should be applied 
and I'll try it.

Can you do a "bk lease renew" before you start the process, then do a
"bk lease show" to make sure it took?  When it starts to fail I'd like
to know what time your computer thinks it is.  Is it possible that you
are using your net connection to maintain your date and then when you
disconnect your date warps forward?  Does this always happen at the 
3rd commit?

Thanks!
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
