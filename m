Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbWFUVJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWFUVJx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWFUVJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:09:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23218 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751153AbWFUVJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 17:09:52 -0400
Date: Wed, 21 Jun 2006 14:09:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: + netlink-remove-dead-code.patch added to -mm tree
Message-Id: <20060621140948.c3365525.akpm@osdl.org>
In-Reply-To: <20060621.135339.59831267.davem@davemloft.net>
References: <200606212033.k5LKXw9B003804@shell0.pdx.osdl.net>
	<20060621.135339.59831267.davem@davemloft.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006 13:53:39 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: akpm@osdl.org
> Date: Wed, 21 Jun 2006 13:33:58 -0700
> 
> > diff -puN net/netlink/af_netlink.c~netlink-remove-dead-code net/netlink/af_netlink.c
> > --- a/net/netlink/af_netlink.c~netlink-remove-dead-code
> > +++ a/net/netlink/af_netlink.c
> > @@ -1380,9 +1380,6 @@ static int netlink_dump(struct sock *sk)
> >  
> >  	netlink_destroy_callback(cb);
> >  	return 0;
> > -
> > -nlmsg_failure:
> > -	return -ENOBUFS;
> >  }
> >  
> >  int netlink_dump_start(struct sock *ssk, struct sk_buff *skb,
> 
> Andrew, please type make before you commit things like this
> to your tree.

Nope.  I build-test in batches, not after every patch.
