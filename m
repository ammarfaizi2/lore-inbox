Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267576AbUIOVkD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267576AbUIOVkD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 17:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267523AbUIOVhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:37:04 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:20352 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267591AbUIOVgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:36:02 -0400
Date: Wed, 15 Sep 2004 14:36:00 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Paul Jakma <paul@clubi.ie>
Cc: Netdev <netdev@oss.sgi.com>, leonid.grossman@s2io.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: The ultimate TOE design
Message-ID: <20040915213600.GA12153@plexity.net>
Reply-To: dsaxena@plexity.net
References: <4148991B.9050200@pobox.com> <Pine.LNX.4.61.0409152102050.23011@fogarty.jakma.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0409152102050.23011@fogarty.jakma.org>
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 15 2004, at 21:04, Paul Jakma was caught saying:
> On Wed, 15 Sep 2004, Jeff Garzik wrote:
> 
> >Put simply, the "ultimate TOE card" would be a card with network ports, a 
> >generic CPU (arm, mips, whatever.), some RAM, and some flash.  This card's 
> >"firmware" is the Linux kernel, configured to run as a _totally indepenent 
> >network node_, with IP address(es) all its own.
> >
> >Then, your host system OS will communicate with the Linux kernel running 
> >on the card across the PCI bus, using IP packets (64K fixed MTU).
> 
> >My dream is that some vendor will come along and implement such a 
> >design, and sell it in enough volume that it's US$100 or less. 
> >There are a few cards on the market already where implementing this 
> >design _may_ be possible, but they are all fairly expensive.
> 
> The intel IXP's are like the above, XScale+extra-bits host-on-a-PCI 
> card running Linux. Or is that what you were referring to with 
> "<cards exist> but they are all fairly expensive."?

Unfortunately all the SW that lets one make use of the interesting
features of the IXPs (microEngines, crypto, etc) is a pile of
propietary code.

~Deepak


-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment
and will die here like rotten cabbages." - Number 6
