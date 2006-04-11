Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbWDKPLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbWDKPLz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 11:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWDKPLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 11:11:55 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:63978 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751339AbWDKPLy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 11:11:54 -0400
Date: Tue, 11 Apr 2006 08:12:18 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kernel/rcupdate.c: kill synchronize_kernel()
Message-ID: <20060411151218.GB1295@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060411035100.GD3190@stusta.de> <20060411145355.GA3373@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060411145355.GA3373@rhlx01.fht-esslingen.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2006 at 04:53:56PM +0200, Andreas Mohr wrote:
> Hi,
> 
> On Tue, Apr 11, 2006 at 05:51:01AM +0200, Adrian Bunk wrote:
> > synchronize_kernel() is both deprecated and completely unused.
> > 
> > Let's kill this bloat.
> 
> Probably a good idea, but then it's not too useful to have
> http://lse.sourceforge.net/locking/rcu/HOWTO/descrip.html
> still prominently mention it...

My May 1st patches will update the documentation files as well,
also the -rt tree.  Please let me take care of this.

						Thanx, Paul
