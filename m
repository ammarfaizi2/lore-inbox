Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbVAXVOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbVAXVOP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 16:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVAXVOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 16:14:06 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:21154 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261662AbVAXVNs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 16:13:48 -0500
From: David Brownell <david-b@pacbell.net>
To: Martin Josefsson <gandalf@wlug.westbo.se>
Subject: Re: Linux 2.6.11-rc2
Date: Mon, 24 Jan 2005 13:13:43 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <200501232251.42394.david-b@pacbell.net> <1106589954.1085.5.camel@tux.rsn.bth.se>
In-Reply-To: <1106589954.1085.5.camel@tux.rsn.bth.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501241313.43361.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 January 2005 10:05 am, Martin Josefsson wrote:
> On Sun, 2005-01-23 at 22:51 -0800, David Brownell wrote:
> > ...
> >  - Each gets an ICMP destination unreachable, frag needed, next hop MTU 1492
> >  - ... all retransmits are 1500 bytes not 1492, triggering ICMPs ...
> > 
> > Naturally the connection goes nowhere.  
> 
> Is there a firewall on this machine? And if so, do you allow inbound
> icmp?

It's behind a firewall; no firewall on that box though.  The only
difference between a working RC1 and non-working RC2 was the kernel.

- Dave
