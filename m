Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264082AbUFQWnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264082AbUFQWnb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 18:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264096AbUFQWnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 18:43:31 -0400
Received: from mail.dif.dk ([193.138.115.101]:43712 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S264082AbUFQWnX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 18:43:23 -0400
Date: Fri, 18 Jun 2004 00:42:29 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: Re: [Bug 2905] New: Aironet 340 PCMCIA card not working since 2.6.7
In-Reply-To: <Pine.LNX.4.60.0406172152310.5847@poirot.grange>
Message-ID: <Pine.LNX.4.56.0406180040050.15935@jjulnx.backbone.dif.dk>
References: <200406171753.i5HHrx38015816@fire-2.osdl.org>
 <Pine.LNX.4.60.0406172152310.5847@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -			skb = dev_alloc_skb( len + hdrlen + 2 );
> +			skb = dev_alloc_skb( len + hdrlen + 2 + 2 );

nitpicking, but why not
	skb = dev_alloc_skb( len + hdrlen + 4 );
?


--
Jesper Juhl <juhl-lkml@dif.dk>

