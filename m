Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263430AbVGASts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263430AbVGASts (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 14:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263433AbVGASts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 14:49:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59356 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263430AbVGAStr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 14:49:47 -0400
Date: Fri, 1 Jul 2005 11:49:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.13-rc1-mm1 unresolved symbols
Message-Id: <20050701114910.73e57022.akpm@osdl.org>
In-Reply-To: <200507011818.17828.bero@arklinux.org>
References: <200507011818.17828.bero@arklinux.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernhard Rosenkraenzer <bero@arklinux.org> wrote:
>
> ipw2200 in 2.6.13-rc1-mm1 makes use of is_broadcast_ether_addr, which was 
> removed.

Yes, this is due to my failure to negotiate the twisty maze of netdev
trees, sorry.

> The attached patch restores that function for now.

Ah, you have a kernel.org account.  It seems that something is playing up
at kernel.org, preventing 2.6.13-rc1-mm1 and 2.6.13-rc1-git* from getting
to the servers.

