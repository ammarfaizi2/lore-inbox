Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266454AbUFUUYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266454AbUFUUYf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 16:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266457AbUFUUYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 16:24:35 -0400
Received: from prosun.first.gmd.de ([194.95.168.2]:37005 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S266454AbUFUUYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 16:24:24 -0400
Subject: Re: sungem - ifconfig eth0 mtu 1300 -> oops
From: Soeren Sonnenburg <kernel@nn7.de>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, davem@redhat.com,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, netdev@oss.sgi.com,
       jgarzik@pobox.com
In-Reply-To: <20040621130316.GA2661@gondor.apana.org.au>
References: <1087568322.4455.22.camel@localhost>
	 <E1BcNzi-0000eh-00@gondolin.me.apana.org.au>
	 <20040621130316.GA2661@gondor.apana.org.au>
Content-Type: text/plain
Message-Id: <1087849459.4146.3.camel@localhost>
Mime-Version: 1.0
Date: Mon, 21 Jun 2004 22:24:20 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-06-21 at 15:03, Herbert Xu wrote:
> On Mon, Jun 21, 2004 at 10:33:50PM +1000, Herbert Xu wrote:
> > 
> > Does this patch fix your problems?
> 
> Oops, I had a thinko about min vs. max.  I've also decided to make the
> bigger MTU useful by adjusting the arguments to skb_put() as well.
> Please try this one instead.
> 
> Cheers,

yes that one works nicely... I tested several mtu's ranging from 1000 to
1500 while the interface was up... no oops.

thanks,
Soeren.

