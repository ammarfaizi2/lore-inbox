Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbWBMIe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbWBMIe5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 03:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWBMIe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 03:34:57 -0500
Received: from z2.cat.iki.fi ([212.16.98.133]:27349 "EHLO z2.cat.iki.fi")
	by vger.kernel.org with ESMTP id S1751339AbWBMIe5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 03:34:57 -0500
Date: Mon, 13 Feb 2006 10:34:45 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org
Subject: Re: OpenBSD driver for nforce-based ethernetcards.
Message-ID: <20060213083445.GX3927@mea-ext.zmailer.org>
References: <20060213082519.GN12484@boetes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060213082519.GN12484@boetes.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 09:24:56AM +0059, Han Boetes wrote:
> Date:	Mon, 13 Feb 2006 09:24:56 +0059
> From:	Han Boetes <han@mijncomputer.nl>
> To:	linux-kernel@vger.kernel.org
> Subject: OpenBSD driver for nforce-based ethernetcards.
> 
> Hi,
> 
> I just read this announcement on a well known OpenBSD forum:
>   http://undeadly.org/cgi?action=article&sid=20060206150238&mode=expanded
> 
> So if anyone is interested in writing a driver for Linux for the
> nvidia ethernet cards: That's a nice place to start.

Quick browse of the forum:

  Re: testers required for NVIDIA Ethernet driver (mod 2/4)
  by Anonymous Coward (IP 208.252.48.163) on Mon Feb 6 21:31:33 2006 (GMT)

  How much of this is based on the reverse engineered Linux driver for
  forcedeth?

  Re: testers required for NVIDIA Ethernet driver (mod 11/11)
  by jsg (IP 210.15.216.215) on Mon Feb 6 22:39:51 2006 (GMT)

  It was consulted for register offsets and semantics if we weren't sure
  what was supposed to happen. If you look at the code you'll see our
  driver is a hell of a lot easier on the eyes and like half the size.


So yes, perhaps  'forcedeth'  driver would use some heavy handed
cleanup,  but it does not mean it does not exist...


> The sourcecode can be found over here:
>   http://www.openbsd.org/cgi-bin/cvsweb/src/sys/dev/pci/
> Under the name if_nfe*
>  
> # Han

  /Matti Aarnio
