Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbVIMXs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbVIMXs4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 19:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbVIMXs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 19:48:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44219 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964852AbVIMXsz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 19:48:55 -0400
Date: Tue, 13 Sep 2005 16:48:39 -0700
From: Chris Wright <chrisw@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: chrisw@osdl.org, andystewart@comcast.net, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.13 BUG tg3.c:2805 = crash (this one isn't tainted)
Message-ID: <20050913234839.GN7762@shell0.pdx.osdl.net>
References: <43263CDC.1010604@comcast.net> <43264C1C.9030207@comcast.net> <20050913222830.GG7991@shell0.pdx.osdl.net> <20050913.162935.53822111.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913.162935.53822111.davem@davemloft.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David S. Miller (davem@davemloft.net) wrote:
> From: Chris Wright <chrisw@osdl.org>
> Date: Tue, 13 Sep 2005 15:28:30 -0700
> 
> > Might help to copy netdev on the report.  Seems you've had a bit of luck
> > in reproducing.  Any chance on narrowing down to last known good kernel?
> > There's been a fair bit of change in that driver between 2.6.12 and
> > 2.6.13.
> 
> Michael Chan has already sent him a test patch for the tg3
> driver to try and narrow this one down.  We think his chipset
> is reordering MMIO's and the patch he's been sent tries to
> confirm/deny that theory.

Thanks, I missed that.
-chris
