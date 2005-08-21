Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbVHUWTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbVHUWTv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 18:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbVHUWTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 18:19:51 -0400
Received: from b.mail.sonic.net ([64.142.19.5]:46464 "EHLO b.mail.sonic.net")
	by vger.kernel.org with ESMTP id S1751157AbVHUWTv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 18:19:51 -0400
Date: Sun, 21 Aug 2005 15:19:35 -0700
From: David Hinds <dhinds@sonic.net>
To: "Hesse, Christian" <mail@earthworm.de>
Cc: linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
Subject: Re: IRQ problem with PCMCIA
Message-ID: <20050821221935.GB18925@sonic.net>
References: <200508212043.58331.mail@earthworm.de> <20050821221739.GA18925@sonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050821221739.GA18925@sonic.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 21, 2005 at 03:17:39PM -0700, David Hinds wrote:
> 
> The drivers are working correctly; the problem is with the CF flash
> adapter you're using.  There are two kinds of CF-to-PCMCIA adapters.
> Some are 16-bit PCMCIA cards, which are in most cases limited to a bus
> throughput of ~1 MB/sec, regardless of what the CF card is capable
> of.  There are also 32-bit CF adapter cards, that are much faster,
> limited only by the speed of the CF device.  Here are two:
> 
> http://www.delkin.com/delkin_products_adapters_cardbus.html
> http://www.lexarmedia.com/readers/cf32bit.html

One caveat: I'm not sure if CardBus IDE devices are working under
Linux??  I'd think they should work with 2.6, but don't actually know
that for a fact.

-- Dave
