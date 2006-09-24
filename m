Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752131AbWIXSX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbWIXSX4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 14:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752133AbWIXSX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 14:23:56 -0400
Received: from bayc1-pasmtp02.bayc1.hotmail.com ([65.54.191.162]:12855 "EHLO
	BAYC1-PASMTP02.CEZ.ICE") by vger.kernel.org with ESMTP
	id S1752131AbWIXSXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 14:23:55 -0400
Message-ID: <BAYC1-PASMTP025A69D18D30F23AC048BDAE270@CEZ.ICE>
X-Originating-IP: [65.94.249.130]
X-Originating-Email: [seanlkml@sympatico.ca]
Date: Sun, 24 Sep 2006 14:23:53 -0400
From: Sean <seanlkml@sympatico.ca>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       David Miller <davem@davemloft.net>, jeff@garzik.org, davidsen@tmr.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 -mm merge plans
Message-Id: <20060924142353.6c725128.seanlkml@sympatico.ca>
In-Reply-To: <20060924092010.GC17639@flint.arm.linux.org.uk>
References: <Pine.LNX.4.64.0609211106391.4388@g5.osdl.org>
	<45130533.2010209@tmr.com>
	<45130527.1000302@garzik.org>
	<20060921.145208.26283973.davem@davemloft.net>
	<20060921220539.GL26683@redhat.com>
	<20060922083542.GA4246@flint.arm.linux.org.uk>
	<20060922154816.GA15032@redhat.com>
	<Pine.LNX.4.64.0609220901040.4388@g5.osdl.org>
	<20060924074837.GB13487@xi.wantstofly.org>
	<20060924092010.GC17639@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.10.3; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Sep 2006 18:23:55.0032 (UTC) FILETIME=[97F29180:01C6E006]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Sep 2006 10:20:10 +0100
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> The point I'm making is that for some things, keeping the changes as
> patches until they're ready is far easier, more worthwhile and flexible
> than having them simmering in some git tree somewhere.

It's not really easier, just different.   Git allows you to make a 
"topic branch" to keep separate items that need to bake before going
upstream without being mixed in with all your other worked.  This
allows you to continue to pull in upstream changes to make sure that
the patch series still applies cleanly and doesn't need updates etc.

Of course you may be more comfortable with other tools, but Git _does_
make it easy and practical to do the same thing.

Sean
