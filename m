Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbTI2Q5H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 12:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbTI2Q5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 12:57:07 -0400
Received: from havoc.gtf.org ([63.247.75.124]:25777 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261966AbTI2Qzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 12:55:54 -0400
Date: Mon, 29 Sep 2003 12:55:50 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Andreas Schwarz <usenet.2117@andreas-s.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 8139too & APIC incompatibility (2.6.0-test6-mm1, 2.4.20)
Message-ID: <20030929165550.GA6526@gtf.org>
References: <slrnbngl0o.4e0.usenet.2117@home.andreas-s.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <slrnbngl0o.4e0.usenet.2117@home.andreas-s.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 03:47:29PM +0000, Andreas Schwarz wrote:
> When APIC is activated, the following messages appear in syslog from
> time to time:                                                                   
>                                                                                 
> kernel: NETDEV WATCHDOG: eth1: transmit timed out
> kernel: eth1: Tx queue start entry 4  dirty entry 0.
> kernel: eth1:  Tx descriptor 0 is 00002000. (queue head)
> kernel: eth1:  Tx descriptor 1 is 00002000.
> kernel: eth1:  Tx descriptor 2 is 00002000.
> kernel: eth1:  Tx descriptor 3 is 00002000.
> kernel: eth1: link up, 100Mbps, full-duplex, lpa 0x45E1
> 
> After this has happened the first time, the card fails to send or
> receive any more packages.

Yes.  Has nothing to do with 8139too, though.

This is one of 1001 similar symptoms of the same problem, "interrupt
routing bug(s)".

	Jeff



