Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268411AbUI3CLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268411AbUI3CLt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 22:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268470AbUI3CLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 22:11:49 -0400
Received: from zeus.kernel.org ([204.152.189.113]:49371 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S268411AbUI3CLr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 22:11:47 -0400
Subject: Re: [PATCH] I/O space write barrier
From: Greg Banks <gnb@melbourne.sgi.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Jeremy Higdon <jeremy@sgi.com>,
       John Partridge <johnip@sgi.com>,
       Linux Network Development list <netdev@oss.sgi.com>
In-Reply-To: <20040929135029.38444afd.davem@davemloft.net>
References: <200409271103.39913.jbarnes@engr.sgi.com>
	 <20040929103646.GA4682@sgi.com>
	 <20040929133500.59d78765.davem@davemloft.net>
	 <200409291343.55863.jbarnes@engr.sgi.com>
	 <20040929135029.38444afd.davem@davemloft.net>
Content-Type: text/plain
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1096511023.3620.3314.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 30 Sep 2004 12:23:43 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-30 at 06:50, David S. Miller wrote:
> On Wed, 29 Sep 2004 13:43:55 -0700
> Jesse Barnes <jbarnes@engr.sgi.com> wrote:
> 
> > The patch that actually implements mmiowb() already does this, I think Greg 
> > just used his patch for testing.  

Yes, that hunk will be unnecessary when Jesse's patch goes in.

> The proper way to do it of course is to 
> > just use mmiowb() where needed in tg3 after the write barrier patch gets in.
> 
> Perfect, please send me a tg3 patch once the mmiowb() bits
> go into the tree.

Will do.

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


