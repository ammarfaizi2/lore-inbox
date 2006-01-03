Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751480AbWACURl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbWACURl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 15:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbWACURl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 15:17:41 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:40845
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751445AbWACURk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 15:17:40 -0500
Date: Tue, 03 Jan 2006 12:13:52 -0800 (PST)
Message-Id: <20060103.121352.56284758.davem@davemloft.net>
To: spereira@tusc.com.au
Cc: linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org, eis@baty.hanse.de,
       akpm@osdl.org, netdev@vger.kernel.org
Subject: Re: [PATCH - 2.6.14.5]x25: fix for broken x25 module
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1136267307.11486.44.camel@spereira05.tusc.com.au>
References: <1136267307.11486.44.camel@spereira05.tusc.com.au>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shaun Pereira <spereira@tusc.com.au>
Date: Tue, 03 Jan 2006 16:48:27 +1100

> -
> - if (sock_flag(osk, SOCK_ZAPPED))
> - sock_set_flag(sk, SOCK_ZAPPED);
> - 
> - if (sock_flag(osk, SOCK_DBG))
> - sock_set_flag(sk, SOCK_DBG);
> + sock_copy_flags(sk, osk);

Please get your email setup such that the patches you post
might actually be capable of being applied.  Your email
client corrupts the tabbing and spaces in patches heavily.

Thanks.
