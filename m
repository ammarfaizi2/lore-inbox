Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966146AbWKXVfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966146AbWKXVfj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 16:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935081AbWKXVfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 16:35:38 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:20120
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S935079AbWKXVfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 16:35:37 -0500
Date: Fri, 24 Nov 2006 13:35:47 -0800 (PST)
Message-Id: <20061124.133547.106434341.davem@davemloft.net>
To: netdev@axxeo.de
Cc: okir@suse.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make udp_encap_rcv use pskb_may_pull
From: David Miller <davem@davemloft.net>
In-Reply-To: <200611241154.15740.netdev@axxeo.de>
References: <20061123000144.GB7452@suse.de>
	<20061122.201136.129449260.davem@davemloft.net>
	<200611241154.15740.netdev@axxeo.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Oeser <netdev@axxeo.de>
Date: Fri, 24 Nov 2006 11:54:15 +0100

> Hi David,
> 
> David Miller wrote:
> > From: Olaf Kirch <okir@suse.de>
> > Date: Thu, 23 Nov 2006 01:01:44 +0100
> > 
> > > 
> > > Make udp_encap_rcv use pskb_may_pull
> > 
> > Excellent catch, applied, thanks Olaf.
> 
> Should this go to -stable, too? Or are these kernels not affected, yet?

I planned to push this to -stable over the weekend, but thanks for
reminding me anyways.
