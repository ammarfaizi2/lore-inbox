Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263100AbUIJF4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbUIJF4w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 01:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266344AbUIJF4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 01:56:52 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:63503 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S263100AbUIJF4v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 01:56:51 -0400
Date: Fri, 10 Sep 2004 15:56:33 +1000
To: "David S. Miller" <davem@davemloft.net>
Cc: fork0@users.sourceforge.net, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: 2.6.9-rc1+bk: assertion tcp_get_pcount failed at net/ipv4/tcp_input.c
Message-ID: <20040910055633.GA27539@gondor.apana.org.au>
References: <20040909111233.GA3987@steel.home> <20040910033055.GA26790@gondor.apana.org.au> <20040909222542.7a30c0e4.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909222542.7a30c0e4.davem@davemloft.net>
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 10:25:42PM -0700, David S. Miller wrote:
> 
> Herbert did you see my division fix I made today for
> tso_factor calculation?  I was dividing by the TSO mss
> instead of the normal one :-)

That would do it :)
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
