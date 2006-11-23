Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933881AbWKWT41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933881AbWKWT41 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 14:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933880AbWKWT41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 14:56:27 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:16302
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S933881AbWKWT40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 14:56:26 -0500
Date: Thu, 23 Nov 2006 11:56:31 -0800 (PST)
Message-Id: <20061123.115631.55726940.davem@davemloft.net>
To: spyro@f2s.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: 2.6.19-rc6 net/irda/irlmp.c
From: David Miller <davem@davemloft.net>
In-Reply-To: <45657BD4.5040604@f2s.com>
References: <45657BD4.5040604@f2s.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Molton <spyro@f2s.com>
Date: Thu, 23 Nov 2006 10:45:40 +0000

> spin_lock_irqsave_nested is used in net/irda/irlmp.c
> 
> Im not sure what it _should_ be, but thought it worth reporting.

This has been reported, and explained, about 3 times already.

Andrew Morton will be pushing in a patch to fix this.
