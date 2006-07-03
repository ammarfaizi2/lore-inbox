Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWGCW1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWGCW1Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 18:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWGCW1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 18:27:24 -0400
Received: from ozlabs.org ([203.10.76.45]:48305 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750834AbWGCW1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 18:27:23 -0400
Date: Tue, 4 Jul 2006 08:25:06 +1000
From: Anton Blanchard <anton@samba.org>
To: David Miller <davem@davemloft.net>
Cc: bos@pathscale.com, akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il,
       openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, matthew@wil.cx
Subject: Re: [PATCH 38 of 39] IB/ipath - More changes to support InfiniPath on PowerPC 970 systems
Message-ID: <20060703222506.GD31081@krispykreme>
References: <c22b6c244d5db77f7b1d.1151617289@eng-12.pathscale.com> <20060629.145319.71091846.davem@davemloft.net> <1151618499.10886.26.camel@chalcedony.pathscale.com> <20060629.150417.78710870.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060629.150417.78710870.davem@davemloft.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> Please fix the generic code if it doesn't provide the facility
> you need at the moment.  Don't shoe horn it into your driver
> just to make up for that.

Ive had 3 drivers asking for write combining recently so I agree this is
a good idea. How about ioremap_wc as suggested by Willy:

http://marc.theaimsgroup.com/?l=linux-kernel&m=114374741828040&w=2

Anton
