Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbWINBdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWINBdo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 21:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWINBdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 21:33:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6334 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751308AbWINBdn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 21:33:43 -0400
Date: Thu, 14 Sep 2006 10:33:32 +0900
From: Stephen Hemminger <shemminger@osdl.org>
To: Philip Craig <philipc@snapgear.com>
Cc: Joerg Roedel <joro-lkml@zlug.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCH] EtherIP tunnel driver (RFC 3378)
Message-ID: <20060914103332.641e7ff0@localhost.localdomain>
In-Reply-To: <4508AE92.1090202@snapgear.com>
References: <20060911204129.GA28929@zlug.org>
	<4508AE92.1090202@snapgear.com>
X-Mailer: Sylpheed-Claws 2.1.1 (GTK+ 2.8.17; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2006 11:21:22 +1000
Philip Craig <philipc@snapgear.com> wrote:

> Joerg Roedel wrote:
> > +	 To configure tunnels an extra tool is required. You can download
> > +	 it from http://zlug.fh-zwickau.de/~joro/projects/ under the
> > +	 EtherIP section. If unsure, say N.
> 
> To obtain a list of tunnels, this tool calls SIOCGETTUNNEL
> (SIOCDEVPRIVATE + 0) for every device in /proc/net/dev. I don't think
> this is safe, but I don't have a solution for you.
> 
> Is there a reason why you have a separate tool rather than modifying
> iproute2?
> 
> I don't know if you are aware of this older etherip patch by Lennert
> Buytenhek: http://www.wantstofly.org/~buytenh/etherip/

SIOCDEVPRIVATE usage makes it hard to do 32 bit compatibility layer.
