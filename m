Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263590AbTGGIax (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 04:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbTGGIaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 04:30:52 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:951 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S263590AbTGGIav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 04:30:51 -0400
Date: Mon, 7 Jul 2003 10:45:05 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Ryan Mack <lists@mackman.net>,
       Markus Plail <linux-kernel@gitteundmarkus.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21 ServerWorks DMA Bugs
Message-ID: <20030707084505.GE303@louise.pinerecords.com>
References: <20030707034217.GD303@louise.pinerecords.com> <Pine.LNX.4.10.10307070114140.32069-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10307070114140.32069-100000@master.linux-ide.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here is the skinny!
> SGlist with a 2 byte boundary error on the FIFO's 510-511 or is 509-510
> 
> It all is determined on if 1 or 0 is starting as the counting number.
> The FIFO flush to generate the interrupt is a DMA quirk.  Similar to the
> the 8K FIFO Phy issues in SATA.

So would you know of a way to implement a workaround in the driver
or is this fatal?

> Buy me a Coke (Red Can, no BLUE Crap) and we can discuss the issues.

It'd be fun to, but I guess it's not really doable on account of
geographic issues. :)

-- 
Tomas Szepe <szepe@pinerecords.com>
