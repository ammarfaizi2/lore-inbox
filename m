Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262027AbVATDih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbVATDih (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 22:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbVATDih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 22:38:37 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:2691 "EHLO
	moreton.com.au") by vger.kernel.org with ESMTP id S262027AbVATDbL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 22:31:11 -0500
Date: Thu, 20 Jan 2005 13:30:19 +1000
From: David McCullough <davidm@snapgear.com>
To: James Morris <jmorris@redhat.com>
Cc: Fruhwirth Clemens <clemens@endorphin.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, cryptoapi@lists.logix.cz,
       Michal Ludvig <michal@logix.cz>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/2] CryptoAPI: prepare for processing multiple buffers at a time
Message-ID: <20050120033019.GD9407@beast>
References: <1105793137.16065.17.camel@ghanima> <Xine.LNX.4.44.0501181147490.24891-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0501181147490.24891-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jivin James Morris lays it down ...
> On Sat, 15 Jan 2005, Fruhwirth Clemens wrote:
> 
> > However, developing two different APIs isn't particular efficient. I
> > know, at the moment there isn't much choice, as J.Morris hasn't commited
> > to acrypto in anyway.
> 
> There is also the OCF port (OpenBSD crypto framework) to consider, if 
> permission to dual license from the original authors can be obtained.

For anyone looking for the OCF port for linux,  you can find the latest
release here:

	http://lists.logix.cz/pipermail/cryptoapi/2004/000261.html

One of the drivers uses the existing kernel crypto API to implement
a SW crypto engine for OCF.

As for permission to use a dual license,  I will gladly approach the
authors if others feel it is important to know the possibility of it at this
point,

Cheers,
Davidm

-- 
David McCullough, davidm@snapgear.com  Ph:+61 7 34352815 http://www.SnapGear.com
Custom Embedded Solutions + Security   Fx:+61 7 38913630 http://www.uCdot.org
