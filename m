Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266058AbUF2VIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266058AbUF2VIU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 17:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266056AbUF2VIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 17:08:20 -0400
Received: from palrel12.hp.com ([156.153.255.237]:36006 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S266058AbUF2VID (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 17:08:03 -0400
Date: Tue, 29 Jun 2004 13:41:43 -0700
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com, "David S. Miller" <davem@redhat.com>
Subject: Re: Updated Wireless Extension patches
Message-ID: <20040629204143.GA11782@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20040629162339.GA4356@bougret.hpl.hp.com> <20040629194525.GF23191@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040629194525.GF23191@havoc.gtf.org>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2004 at 03:45:25PM -0400, Jeff Garzik wrote:
> 
> Regardless of our recent discussions, I do want to emphasize that I wish
> to maintain the current WE, and its backwards compatibility, for the
> current 2.6.x stable series at the very least.
> 
> So please don't be discouraged from submitting WE patches...

	No problem Jeff ;-) Because of my wife, I have learned to
compromise (I just wish she had learned that as well). I already told
you that the actual delivery mechanism to the driver doesn't matter to
me, what matter to me is the vocabulary and gramar of the API. And
also I want to satisfy the need of both driver authors and userspace.
	So, we are aiming for the same goal, just having slightly
different methods.
	I plan to submit WE-17 to you somewhat soon, because Jouni
needs it, and I've postponed it far too much. There is actually one
change in WE-17 that you should appreciate. WPA and RtNetlink will go
when they are ready, for WPA it depends on Jouni, for RtNetlink on me.

> 	Jeff
> 
> 
> P.S. do associated userland wireless-tools patches exist to make use of
> netlink?  i.e. how have you been testing it?

	Good catch ;-)
	There are some advantage to RtNetlink. Unfortunately,
simplicity is not one. Dealing with RtNetlink is a lot of work
compared to ioctl, as you may discover if you migrate your API to it.
	I have a pretty simple test app. I'm working on a version of
iwlib that would go through RtNetlink, that would enable the full
Wireless Tools to use RtNetlink. I'll try to release that soon.

	Have fun...

	Jean

