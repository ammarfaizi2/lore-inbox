Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132447AbRA0J6q>; Sat, 27 Jan 2001 04:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132482AbRA0J6h>; Sat, 27 Jan 2001 04:58:37 -0500
Received: from mail.zmailer.org ([194.252.70.162]:61707 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S132447AbRA0J61>;
	Sat, 27 Jan 2001 04:58:27 -0500
Date: Sat, 27 Jan 2001 11:58:15 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: List User <lists@chaven.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ECN -?  Anything _I_ need to do to allow it?
Message-ID: <20010127115815.N25659@mea-ext.zmailer.org>
In-Reply-To: <Pine.SOL.4.21.0101261344120.11126-100000@red.csi.cam.ac.uk> <07fc01c087f2$523da160$160912ac@stcostlnds2zxj>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07fc01c087f2$523da160$160912ac@stcostlnds2zxj>; from lists@chaven.com on Fri, Jan 26, 2001 at 05:47:14PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2001 at 05:47:14PM -0600, List User wrote:
> I run a small ISP for my local community and have read some reports about
> hotmail not supporting it et al.  I don't want to be in a position where MY
> site doesn't support this if it's the correct thing to do.
> 
> Is there anything special that needs to be done (cisco router config,
> firewall (ie, checkpoint)) to allow this information to pass?

	Cisco IOSes (at routers) ignore the ECN presently.
	Somewhen along 12.2 (or a bit latter) those routers
	will start supporting ECN markup.

	On Cisco product lines, the PIX firewalls have had problems,
	but they weren't cisco product originally...

	Checkpoint seems to pass the ECN bit successfully, at least
	the one at my office passes.

> Steve

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
