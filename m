Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263075AbVFXDr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263075AbVFXDr3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 23:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263073AbVFXDr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 23:47:28 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:41414
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S263065AbVFXDrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 23:47:13 -0400
Date: Thu, 23 Jun 2005 20:47:02 -0700 (PDT)
Message-Id: <20050623.204702.26274560.davem@davemloft.net>
To: christoph@lameter.com
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org, shai@scalex86.org,
       akpm@osdl.org, netdev@vger.kernel.org, herbert@gondor.apana.org.au
Subject: Re: [PATCH] dst_entry structure use,lastuse and refcnt abstraction
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.62.0506232037430.28814@graphe.net>
References: <Pine.LNX.4.62.0506231953260.28244@graphe.net>
	<20050623.203647.88475017.davem@davemloft.net>
	<Pine.LNX.4.62.0506232037430.28814@graphe.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Lameter <christoph@lameter.com>
Date: Thu, 23 Jun 2005 20:40:25 -0700 (PDT)

> Nothing as far as I can tell. The main benefit may be reorganization of 
> the code.

You told us way back in the original thread that the final atomic dec
shows up very much on NUMA, and if it could be avoided (and changed
into a read test), it would help a lot on NUMA.

> > 	NETWORKING [GENERAL]
> > 	P:	Networking Team
> > 	M:	netdev@vger.kernel.org
> > 	L:	netdev@vger.kernel.org
> > 	S:	Maintained
> > 
> > Thanks.
> 
> Yes and it was recently changed. Typical use is linux-xxx@vger.kernel.org

netdev@oss.sgi.com is what used to be the place for networking
stuff, it's not netdev@vger.kernel.org

