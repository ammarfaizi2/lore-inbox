Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264266AbUGYSo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264266AbUGYSo7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 14:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264270AbUGYSo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 14:44:59 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:36844 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264266AbUGYSo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 14:44:58 -0400
Date: Sun, 25 Jul 2004 11:44:28 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Kronos <kronos@kronoz.cjb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.8-rc2][XFS] Page allocation failure
Message-ID: <20040725184428.GA10402@taniwha.stupidest.org>
References: <20040725173022.GA8345@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040725173022.GA8345@dreamland.darkstar.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 25, 2004 at 07:30:23PM +0200, Kronos wrote:

> java: page allocation failure. order:5, mode:0xd0

> It seems that XFS failed an order 5 allocation (not atomic) on the
> read path two times (there are 80 secs between the warnings). Can I
> assume that the FS is not harmed?

Unless it oopsed it should be OK.  XFS retries the allocations sowhat
you are seeing are the lower-layers warning.

> Btw, even if the allocation is quite big the machine was up for a
> bit more the one hour, it's strange that the memory is fragmented so
> badly...

Blame java :)



  --cw
