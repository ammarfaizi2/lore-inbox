Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbVKODZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbVKODZi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 22:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbVKODZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 22:25:38 -0500
Received: from ns2.suse.de ([195.135.220.15]:7897 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751325AbVKODZh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 22:25:37 -0500
From: Andi Kleen <ak@suse.de>
To: linux@horizon.com
Subject: Re: Balancing near the locking cliff, with some numbers
Date: Tue, 15 Nov 2005 04:26:50 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20051114120337.3088.qmail@science.horizon.com>
In-Reply-To: <20051114120337.3088.qmail@science.horizon.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511150426.50550.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr Linux,

On Monday 14 November 2005 13:03, linux@horizon.com wrote:

> This is very interesting data, thank you!
> This is using the standard IDE driver?
> And the path names were absolute?

Yes. No.

> 
> What would be really nice is a full trace of the locks acquired so we
> can look for specific problems.  (I can see the OpenSolaris folks puffing
> up to crow about dtrace already.)

> Barring that, a few variants like hot-cache cases, different file systems
> (includig tmpfs), and different device drivers would be informative.
> (You could also try the different ext3 journalling modes.)

I have no plans to generate such data right now, but if you want to
do it yourself I can send you my patches as a starting point. Should be easy enough
using relayfs.

> I'm not sre quite how you did this, but assuming you just installed global
> counters via macros 

per process counters.

> and ran the test by booting with init=

from a normal shell in a running system

-Andi
