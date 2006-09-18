Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964983AbWIRUw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbWIRUw5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 16:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbWIRUw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 16:52:57 -0400
Received: from alephnull.demon.nl ([83.160.184.112]:3753 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S964983AbWIRUw4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 16:52:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=1148133259;
	d=wantstofly.org;
	h=date:from:to:cc:subject:message-id:mime-version:content-type:
	content-disposition:in-reply-to:user-agent;
	b=AgevqqWkfUjEBjnUvHXTnkdNwGOqLMHJXeamAJQJuH+cHd3vsKePdNa46YBVG
	ccm2U9RVC7GCDURefgkQls2wg==
Date: Mon, 18 Sep 2006 22:52:52 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Joerg Roedel <joro-lkml@zlug.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCH] EtherIP tunnel driver (RFC 3378)
Message-ID: <20060918205252.GA6830@xi.wantstofly.org>
References: <20060911204129.GA28929@zlug.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060911204129.GA28929@zlug.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2006 at 10:41:29PM +0200, Joerg Roedel wrote:

> This driver implements the tunneling of Ethernet packets over IPv4
> networks for Linux. It uses the protocol defined in RFC 3378.

Check out the thread "[PATCH][RFC] etherip: Ethernet-in-IPv4 tunneling"
that was on netdev in January of 2005 -- a number of arguments against
etherip (and for tunneling ethernet in GRE) were raised back then.

One of the most significant ones, IMHO:

> Another argument against etherip would be that OpenBSD apparently
> mis-implemented etherip by putting the etherip version nibble in the
> second nibble of the etherip header instead of the first, which would
> probably prevent the linux and OpenBSD versions from interoperating,
> negating the advantage of using etherip in the first place.


cheers,
Lennert
