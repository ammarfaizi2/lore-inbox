Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbULNV2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbULNV2H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 16:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbULNV2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 16:28:07 -0500
Received: from denise.shiny.it ([194.20.232.1]:15757 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id S261314AbULNV2E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 16:28:04 -0500
Date: Tue, 14 Dec 2004 22:26:56 +0100 (CET)
From: Giuliano Pochini <pochini@denise.shiny.it>
To: Martin Josefsson <gandalf@wlug.westbo.se>
cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 NAT problem
In-Reply-To: <Pine.LNX.4.58.0412141025040.23132@tux.rsn.bth.se>
Message-ID: <Pine.LNX.4.58.0412142222240.10830@denise.shiny.it>
References: <20041213212603.4e698de6.pochini@shiny.it>
 <Pine.LNX.4.58.0412141025040.23132@tux.rsn.bth.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Dec 2004, Martin Josefsson wrote:

> 2.6.9 contains a large update to the connectiontracking code. One thing
> that was changed is that it now verifies the checksum of tcp and udp
> packets. I know of at least one user who has been bitten by this and what
> looks like a broken sungem NIC.
>
> Could you please try this:
>
> modprobe ipt_LOG
> echo 255 > /proc/sys/net/ipv4/netfilter/ip_conntrack_log_invalid
>
> Then try again and then check the kernellog by executing 'dmesg', see if
> it complains about bad checksums.

Yes :(


--
Giuliano.
