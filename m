Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbULNFD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbULNFD3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 00:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbULNFD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 00:03:29 -0500
Received: from h142-az.mvista.com ([65.200.49.142]:3025 "HELO
	xyzzy.farnsworth.org") by vger.kernel.org with SMTP id S261419AbULNFDT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 00:03:19 -0500
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Mon, 13 Dec 2004 22:03:17 -0700
To: Manish Lachwani <mlachwani@penguin.mvista>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] mv643xx_eth: fix hw checksum generation on transmit
Message-ID: <20041214050316.GA5022@xyzzy>
References: <20041213220949.GA19609@xyzzy> <20041213221541.GC19951@xyzzy> <41BE1744.4060502@penguin.mvista>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41BE1744.4060502@penguin.mvista>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2004 at 10:27:16PM +0000, Manish Lachwani wrote:
> Hi Dale,
> 
> Just want to let you know that the checksum offload code worked well in 
> 2.4. I have the numbers with me. On a Jaguar ATX board (Discovery II 
> controller), TCP throughput measured using netperf was 920 Mb/s. As far 
> as 2.6 goes, I dont have any idea if the checksum offload worked
> 
> Dale Farnsworth wrote:
> >This patch fixes the code that enables hardware checksum generation.
> >The previous code has so many problems that it appears to never have 
> >worked.

I haven't tried it on 2.4, so can't comment there.  Something like
my patch seems needed for 2.6 though.  So, I'll revise my comment
to say that I don't see how the previous code could have worked on
current 2.6

-Dale
