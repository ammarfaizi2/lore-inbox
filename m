Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbUGFAxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbUGFAxZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 20:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUGFAxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 20:53:23 -0400
Received: from LPBPRODUCTIONS.COM ([68.98.211.131]:38074 "HELO
	lpbproductions.com") by vger.kernel.org with SMTP id S262279AbUGFAxW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 20:53:22 -0400
From: Matt Heler <lkml@lpbproductions.com>
Reply-To: lkml@lpbproduction.scom
To: Redeeman <lkml@metanurb.dk>
Subject: Re: quite big breakthrough in the BAD network performance, which mm6 did not fix
Date: Mon, 5 Jul 2004 17:54:37 -0700
User-Agent: KMail/1.6.82
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>
References: <1089070720.14870.6.camel@localhost>
In-Reply-To: <1089070720.14870.6.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407051754.38690.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok first take benchmarks ( use wget ), and secondly results from the internet 
vary day by day , hour to hour , minute by minute. Don't expect all sites on 
the internet to be the same speed, or even stay the same speed for that 
matter. For more accurate benchmark results setup a personal server on your 
own private network and benchmark http trasnfers using different kernels. 

Matt H.



On Monday 05 July 2004 4:38 pm, Redeeman wrote:
> hey, i have had a breakthrough in the investigation...
> it turns out that some sites does not load.. but you know all about
> that, and a "fix" with sysctl fixes some of it.
>
> networking was generally slow - or not!
> it seems that its only HTTP transfers going insanely slow. which also
> probably is those ipv4 issues, so now we just need to figure out what
> changed, and what we need to change to fix it, so that we again can get
> all sites loading, and HTTP protocol fully functionel again.
>
> hope someone has some ideas.
