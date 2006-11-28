Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758009AbWK1XfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758009AbWK1XfZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 18:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758012AbWK1XfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 18:35:25 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:53483
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1758001AbWK1XfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 18:35:24 -0500
Date: Tue, 28 Nov 2006 15:35:31 -0800 (PST)
Message-Id: <20061128.153531.34751359.davem@davemloft.net>
To: dada1@cosmosbay.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       viro@ftp.linux.org.uk, akpm@osdl.org
Subject: Re: [PATCH] [NET] dont insert socket dentries into
 dentry_hashtable.
From: David Miller <davem@davemloft.net>
In-Reply-To: <200611221900.36216.dada1@cosmosbay.com>
References: <20061025.230615.92585270.davem@davemloft.net>
	<200610311948.48970.dada1@cosmosbay.com>
	<200611221900.36216.dada1@cosmosbay.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew, I'm fine with these three patches, specifically:

[PATCH] dont insert pipe dentries into dentry_hashtable.
[PATCH] [DCACHE] : avoid RCU for never hashed dentries
[PATCH] [NET] dont insert socket dentries into dentry_hashtable.

Could you toss them into -mm if you haven't already?  This
makes better sense then me putting it into net-2.6.20 since
it touches FS stuff.

Thanks!
