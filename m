Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbUCKJx2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 04:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbUCKJx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 04:53:28 -0500
Received: from uslink-66.173.43-133.uslink.net ([66.173.43.133]:26508 "EHLO
	dingdong.cryptoapps.com") by vger.kernel.org with ESMTP
	id S261156AbUCKJx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 04:53:27 -0500
Date: Thu, 11 Mar 2004 01:53:26 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Anton Blanchard <anton@samba.org>
Cc: dan carpenter <error27@email.com>, ltp-list@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Announce] Strace Test
Message-ID: <20040311095326.GA23446@dingdong.cryptoapps.com>
References: <20040216052257.A2C971D7214@ws3-3.us4.outblaze.com> <20040216065926.GA22323@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040216065926.GA22323@krispykreme>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 16, 2004 at 05:59:26PM +1100, Anton Blanchard wrote:

> Im running it on ppc32 at the moment, will test ppc64 next. Might be
> worth changing maxed to a long and passing back -1UL:

Nit; I really dislike -1UL... it doesnt make any sense (well,
certainly not to me anyhow).  I'd much rather see ~0ul.


  --cw
