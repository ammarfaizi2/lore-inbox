Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263056AbVFXDhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263056AbVFXDhi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 23:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263059AbVFXDhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 23:37:37 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:64681
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S263057AbVFXDg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 23:36:57 -0400
Date: Thu, 23 Jun 2005 20:36:47 -0700 (PDT)
Message-Id: <20050623.203647.88475017.davem@davemloft.net>
To: christoph@lameter.com
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org, shai@scalex86.org,
       akpm@osdl.org, netdev@vger.kernel.org, herbert@gondor.apana.org.au
Subject: Re: [PATCH] dst_entry structure use,lastuse and refcnt abstraction
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.62.0506231953260.28244@graphe.net>
References: <Pine.LNX.4.62.0506231953260.28244@graphe.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Lameter <christoph@lameter.com>
Date: Thu, 23 Jun 2005 20:04:52 -0700 (PDT)

> The patch also removes the atomic_dec_and_test in dst_destroy.

That is the only part of this patch I'm willing to entertain
at this time, as long as Herbert Xu ACKs it.  How much of that
quoted %3 gain does this change alone give you?

Also, please post networking patches to netdev@vger.kernel.org.
Because you didn't, the majority of the networking maintainers
did not see your dst patch submissions.  It's mentioned in
linux/MAINTAINERS for a reason:

	NETWORKING [GENERAL]
	P:	Networking Team
	M:	netdev@vger.kernel.org
	L:	netdev@vger.kernel.org
	S:	Maintained

Thanks.
