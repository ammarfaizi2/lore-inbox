Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265853AbUATVjv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 16:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265854AbUATVjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 16:39:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:46212 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265853AbUATVjt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 16:39:49 -0500
Date: Tue, 20 Jan 2004 13:39:08 -0800
From: Chris Wright <chrisw@osdl.org>
To: Andrew Beresford <a.j.beresford@sheffield.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops with multicast/mrouted
Message-ID: <20040120133908.A11081@osdlab.pdx.osdl.net>
References: <1074587506.3375.5.camel@turtle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1074587506.3375.5.camel@turtle>; from a.j.beresford@sheffield.ac.uk on Tue, Jan 20, 2004 at 08:31:47AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Beresford (a.j.beresford@sheffield.ac.uk) wrote:
> I'm seeing a problem with multicast using mrouted 3.9-beta3 on a 2.6.0
> kernel.

Using 2.6.1, I have no problems.  Have you tried a newer kernel?  If you
can still reproduce on a newer kernel, send me your mrouted.conf and
kernel .config, I'll look at reproducing it here.

> When I set mrouted going, it segfaults after a few moments and the
> following gets output to messages. If I restart mrouted the machine hard
> locks and I have to reset.
> 
> The kernel is being tainted by the tsdev touchscreen driver which seems
> to load each time I turn my machine on. Nothing else is tainting it, I
> promise!

BTW, updating to current 2.6 kernel will eliminate that tainting.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
