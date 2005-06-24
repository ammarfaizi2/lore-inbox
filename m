Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263061AbVFXDlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263061AbVFXDlE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 23:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263059AbVFXDko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 23:40:44 -0400
Received: from graphe.net ([209.204.138.32]:57553 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S263024AbVFXDk3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 23:40:29 -0400
Date: Thu, 23 Jun 2005 20:40:25 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: "David S. Miller" <davem@davemloft.net>
cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org, shai@scalex86.org,
       akpm@osdl.org, netdev@vger.kernel.org, herbert@gondor.apana.org.au
Subject: Re: [PATCH] dst_entry structure use,lastuse and refcnt abstraction
In-Reply-To: <20050623.203647.88475017.davem@davemloft.net>
Message-ID: <Pine.LNX.4.62.0506232037430.28814@graphe.net>
References: <Pine.LNX.4.62.0506231953260.28244@graphe.net>
 <20050623.203647.88475017.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2005, David S. Miller wrote:

> From: Christoph Lameter <christoph@lameter.com>
> Date: Thu, 23 Jun 2005 20:04:52 -0700 (PDT)
> 
> > The patch also removes the atomic_dec_and_test in dst_destroy.
> 
> That is the only part of this patch I'm willing to entertain
> at this time, as long as Herbert Xu ACKs it.  How much of that
> quoted %3 gain does this change alone give you?

Nothing as far as I can tell. The main benefit may be reorganization of 
the code.

> Also, please post networking patches to netdev@vger.kernel.org.
> Because you didn't, the majority of the networking maintainers
> did not see your dst patch submissions.  It's mentioned in
> linux/MAINTAINERS for a reason:
> 
> 	NETWORKING [GENERAL]
> 	P:	Networking Team
> 	M:	netdev@vger.kernel.org
> 	L:	netdev@vger.kernel.org
> 	S:	Maintained
> 
> Thanks.

Yes and it was recently changed. Typical use is linux-xxx@vger.kernel.org

