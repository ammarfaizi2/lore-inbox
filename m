Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbWEBGfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbWEBGfi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 02:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWEBGfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 02:35:38 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:42293 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932400AbWEBGfh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 02:35:37 -0400
Date: Tue, 2 May 2006 08:35:35 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] RCU: add comments to rcu_pending/rcu_needs_cpu
Message-ID: <20060502063535.GA9482@osiris.boeblingen.de.ibm.com>
References: <20060424111141.GC16007@osiris.boeblingen.de.ibm.com> <20060424160943.4bbdb788.akpm@osdl.org> <20060425052721.GA9458@osiris.boeblingen.de.ibm.com> <20060425114656.GA16719@us.ibm.com> <20060425115226.GA9421@osiris.boeblingen.de.ibm.com> <20060425120854.GF16719@us.ibm.com> <20060425122706.GB9421@osiris.boeblingen.de.ibm.com> <20060426141205.58675763.akpm@osdl.org> <20060427081156.GB9457@osiris.boeblingen.de.ibm.com> <20060501215723.GE1305@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060501215723.GE1305@us.ibm.com>
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Add some comments to rcu_pending() and rcu_needs_cpu().
> 
> But these are internal interfaces for RCU, so doesn't seem like they
> should go into docbook.  Quite different than (say) rcu_read_lock()
> or call_rcu().
> 
> How about something like the following instead?

Fine with me :)
