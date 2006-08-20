Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbWHTRCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbWHTRCv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 13:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbWHTRCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 13:02:51 -0400
Received: from mother.openwall.net ([195.42.179.200]:38849 "HELO
	mother.openwall.net") by vger.kernel.org with SMTP id S1750958AbWHTRCu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 13:02:50 -0400
Date: Sun, 20 Aug 2006 20:58:46 +0400
From: Solar Designer <solar@openwall.com>
To: Willy Tarreau <w@1wt.eu>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] cit_encrypt_iv/cit_decrypt_iv for ECB mode
Message-ID: <20060820165846.GA20510@openwall.com>
References: <20060820002346.GA16995@openwall.com> <20060820080403.GA602@1wt.eu> <20060820144908.GA19602@openwall.com> <20060820161346.GH602@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060820161346.GH602@1wt.eu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 06:13:46PM +0200, Willy Tarreau wrote:
> On Sun, Aug 20, 2006 at 06:49:08PM +0400, Solar Designer wrote:
> > Can we maybe define working but IV-ignoring functions for ECB (like I
> > did), but use memory-clearing nocrypt*() for CFB and CTR (as long as
> > these are not supported)?  Of course, all of these will return -ENOSYS.
> 
> I thought we would not have to protect users from shooting themselves in
> the foot (right now they get an oops). But I agree that the cost of
> protecting them is close to zero so we probably should do it. If Herbert
> is OK, do you care to provide a new patch ?

Yes, if the above proposal is OK with Herbert, I will provide a new
patch for 2.4.

Thanks,

Alexander
