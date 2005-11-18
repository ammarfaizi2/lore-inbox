Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030259AbVKRRa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbVKRRa1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 12:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbVKRRa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 12:30:27 -0500
Received: from waste.org ([64.81.244.121]:8322 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S964782AbVKRRa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 12:30:26 -0500
Date: Fri, 18 Nov 2005 09:27:27 -0800
From: Matt Mackall <mpm@selenic.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: acme@conectiva.com.br, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [2.6 patch] move some code to net/ipx/af_ipx.c
Message-ID: <20051118172727.GB31287@waste.org>
References: <6.282480653@selenic.com> <7.282480653@selenic.com> <20051114015707.GB5735@stusta.de> <20051118052252.GG11494@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051118052252.GG11494@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 06:22:52AM +0100, Adrian Bunk wrote:
> > 
> > This patch isn't bad, but looking closer we could move the contents of 
> > p8023.c as well as the contents of at least p8022.c and pe2.c into 
> > af_ipx.c.
> > 
> > Is the contents of any of these three files expected to be used
> > outside IPX (closest candidate would be appletalk)?
> 
> Below is a patch implementing what I was thinking of.

Looks reasonable.

-- 
Mathematics is the supreme nostalgia of our time.
