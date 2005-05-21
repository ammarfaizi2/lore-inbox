Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbVEUAtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVEUAtG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 20:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVEUAs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 20:48:56 -0400
Received: from ozlabs.org ([203.10.76.45]:26601 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261557AbVEUAse (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 20:48:34 -0400
Date: Sat, 21 May 2005 10:43:33 +1000
From: Anton Blanchard <anton@samba.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove the obsolete raw driver]
Message-ID: <20050521004333.GA20174@krispykreme>
References: <20050521001925.GQ5112@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050521001925.GQ5112@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Since kernel 2.6.3 the Kconfig text explicitely stated this driver was 
> obsolete.
> 
> It seems to be time to remove it.

Disagree. We need someone to benchmark and prove O_DIRECT on the raw
device isnt a performance regression first. 

Anton
