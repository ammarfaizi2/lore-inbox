Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbWCTNfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWCTNfO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 08:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbWCTNfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 08:35:14 -0500
Received: from [194.90.237.34] ([194.90.237.34]:9935 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S964777AbWCTNfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 08:35:13 -0500
Date: Mon, 20 Mar 2006 15:35:54 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>,
       "David S. Miller" <davem@davemloft.net>, rick.jones2@hp.com,
       netdev@vger.kernel.org, rdreier@cisco.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: TSO and IPoIB performance degradation
Message-ID: <20060320133554.GA29929@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20060320090629.GA11352@mellanox.co.il> <20060320.015500.72136710.davem@davemloft.net> <20060320102234.GV29929@mellanox.co.il> <20060320.023704.70907203.davem@davemloft.net> <20060320112753.GX29929@mellanox.co.il> <1142855223.3114.30.camel@laptopd505.fenrus.org> <20060320114933.GA3058@xi.wantstofly.org> <1142855615.3114.33.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142855615.3114.33.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 20 Mar 2006 13:37:50.0406 (UTC) FILETIME=[7B5F7E60:01C64C23]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arjan van de Ven <arjan@infradead.org>:
> > I read it as if he was proposing to have a sysctl knob to turn off
> > TCP congestion control completely (which has so many issues it's not
> > even funny.)
> 
> owww that's so bad I didn't even consider that

No, I think that comment was taken out of thread context. We were talking about
stretching ACKs - while avoiding stretch ACKs is important for TCP congestion
control, it's not the only mechanism.

-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies
