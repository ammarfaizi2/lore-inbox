Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbULNJx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbULNJx5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 04:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbULNJx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 04:53:57 -0500
Received: from denise.shiny.it ([194.20.232.1]:41679 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id S261469AbULNJxz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 04:53:55 -0500
Date: Tue, 14 Dec 2004 10:53:24 +0100 (CET)
From: Giuliano Pochini <pochini@denise.shiny.it>
To: Martin Josefsson <gandalf@wlug.westbo.se>
cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 NAT problem
In-Reply-To: <Pine.LNX.4.58.0412141025040.23132@tux.rsn.bth.se>
Message-ID: <Pine.LNX.4.58.0412141050240.10707@denise.shiny.it>
References: <20041213212603.4e698de6.pochini@shiny.it>
 <Pine.LNX.4.58.0412141025040.23132@tux.rsn.bth.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Dec 2004, Martin Josefsson wrote:

> > I can't make NAT work on 2.6.9. Outgoing packets are translated and sent,
> > but incoming packets get rejected. pc4 is the other box (inside the NAT) and
> > host164-26... is the dynamic address of my machine:
>
> 2.6.9 contains a large update to the connectiontracking code. One thing
> that was changed is that it now verifies the checksum of tcp and udp
> packets. I know of at least one user who has been bitten by this and what
> looks like a broken sungem NIC.

The PMac uses the sungem driver indeed.


> Could you please try this:

I'll try that asap.


--
Giuliano.
