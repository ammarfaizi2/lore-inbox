Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030330AbVKWGTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030330AbVKWGTR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 01:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbVKWGTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 01:19:17 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:61144
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030327AbVKWGTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 01:19:16 -0500
Date: Tue, 22 Nov 2005 22:18:00 -0800 (PST)
Message-Id: <20051122.221800.53590951.davem@davemloft.net>
To: herbert@gondor.apana.org.au
Cc: kuznet@ms2.inr.ac.ru, cfriesen@nortel.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [NETLINK]: Use tgid instead of pid for nlmsg_pid
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051123000337.GA17249@gondor.apana.org.au>
References: <E1EeJxb-0006xG-00@gondolin.me.apana.org.au>
	<20051122.144334.23915283.davem@davemloft.net>
	<20051123000337.GA17249@gondor.apana.org.au>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Wed, 23 Nov 2005 11:03:37 +1100

> On Tue, Nov 22, 2005 at 02:43:34PM -0800, David S. Miller wrote:
> > It is possible we accidently reintroduced current->pid when
> > we redid all of the netlink hashing. :-)
> 
> I just checked using git-whatchanged and that line goes back to
> 2002 :)

Ho hum, I guess we just missed it on the current->pid
scan then :-)
