Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbUL0Jbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbUL0Jbc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 04:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbUL0Jbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 04:31:32 -0500
Received: from ozlabs.org ([203.10.76.45]:51648 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261225AbUL0Jba (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 04:31:30 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16847.21964.789391.93324@cargo.ozlabs.ibm.com>
Date: Mon, 27 Dec 2004 11:22:36 +1100
From: Paul Mackerras <paulus@samba.org>
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20041226030957.GA8512@work.bitmover.com>
References: <200412250121_MC3-1-91AF-7FBB@compuserve.com>
	<20041226011222.GA1896@work.bitmover.com>
	<20041226030957.GA8512@work.bitmover.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy writes:

> Has anyone else been shut down because of lease.openlogging.org being down
> and if so what version of BK were you running please?

Yes, I had bk pull and bk export fail for me yesterday.  If I did a bk
pull it would sit there for a while and then put up a window saying it
couldn't get to lease.openlogging.org.  If I clicked OK, after a while
another window would come up with a similar message (but I didn't read
it carefully).

> It is true that both servers are at our offices so if the network had been
> down you would have been out of luck.

I did a traceroute and it looked like a network problem.  From memory
it stopped after about 10 hops, and it seems to be 17 hops to
openlogging.org from here now.

My setup is possibly a little unusual, and may be causing problems for
your lease code: I have my BK repos on a firewire-attached disk, which
I move from machine to machine - specifically, it commutes between home
and work with me.

Paul.
