Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbWDKOyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWDKOyD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 10:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWDKOyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 10:54:03 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:21385 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1751221AbWDKOyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 10:54:01 -0400
Date: Tue, 11 Apr 2006 16:53:56 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: paulmck@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kernel/rcupdate.c: kill synchronize_kernel()
Message-ID: <20060411145355.GA3373@rhlx01.fht-esslingen.de>
References: <20060411035100.GD3190@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060411035100.GD3190@stusta.de>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 11, 2006 at 05:51:01AM +0200, Adrian Bunk wrote:
> synchronize_kernel() is both deprecated and completely unused.
> 
> Let's kill this bloat.

Probably a good idea, but then it's not too useful to have
http://lse.sourceforge.net/locking/rcu/HOWTO/descrip.html
still prominently mention it...

Andreas Mohr
