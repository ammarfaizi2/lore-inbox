Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261757AbVBDLQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbVBDLQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 06:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbVBDLQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 06:16:58 -0500
Received: from cantor.suse.de ([195.135.220.2]:25288 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261757AbVBDLQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 06:16:56 -0500
Date: Fri, 4 Feb 2005 12:16:49 +0100
From: Olaf Kirch <okir@suse.de>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>, anton@samba.org,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arp_queue: serializing unlink + kfree_skb
Message-ID: <20050204111649.GB32678@suse.de>
References: <20050131102920.GC4170@suse.de> <E1CvZo6-0001Bz-00@gondolin.me.apana.org.au> <20050203142705.GA11318@krispykreme.ozlabs.ibm.com> <20050203203010.GA7081@gondor.apana.org.au> <20050203141901.5ce04c92.davem@davemloft.net> <20050203235044.GA8422@gondor.apana.org.au> <20050203164922.2627a112.davem@davemloft.net> <20050204012053.GA8949@gondor.apana.org.au> <20050203172357.670c3402.davem@davemloft.net> <20050204015539.GA9727@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050204015539.GA9727@gondor.apana.org.au>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 12:55:39PM +1100, Herbert Xu wrote:
> OK, here is the patch to do that.  Let's get rid of kfree_skb_fast
> while we're at it since it's no longer used.

Thanks, I'll give that to the PPC folks and ask the to run with it.

Regards,
Olaf
-- 
Olaf Kirch   |  --- o --- Nous sommes du soleil we love when we play
okir@suse.de |    / | \   sol.dhoop.naytheet.ah kin.ir.samse.qurax
