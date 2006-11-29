Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757964AbWK2AOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757964AbWK2AOe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 19:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757508AbWK2AOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 19:14:34 -0500
Received: from smtp.osdl.org ([65.172.181.25]:45012 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1757342AbWK2AOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 19:14:33 -0500
Date: Tue, 28 Nov 2006 16:13:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Miller <davem@davemloft.net>
Cc: dada1@cosmosbay.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       viro@ftp.linux.org.uk
Subject: Re: [PATCH] [NET] dont insert socket dentries into
 dentry_hashtable.
Message-Id: <20061128161354.d5c11ba5.akpm@osdl.org>
In-Reply-To: <20061128.153531.34751359.davem@davemloft.net>
References: <20061025.230615.92585270.davem@davemloft.net>
	<200610311948.48970.dada1@cosmosbay.com>
	<200611221900.36216.dada1@cosmosbay.com>
	<20061128.153531.34751359.davem@davemloft.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2006 15:35:31 -0800 (PST)
David Miller <davem@davemloft.net> wrote:

> 
> Andrew, I'm fine with these three patches, specifically:
> 
> [PATCH] dont insert pipe dentries into dentry_hashtable.
> [PATCH] [DCACHE] : avoid RCU for never hashed dentries
> [PATCH] [NET] dont insert socket dentries into dentry_hashtable.
> 
> Could you toss them into -mm if you haven't already?

They were in rc6-mm2.

>  This
> makes better sense then me putting it into net-2.6.20 since
> it touches FS stuff.
> 

No probs, they're all lined up and ready to go, thanks.
