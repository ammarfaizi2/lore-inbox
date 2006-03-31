Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbWCaGCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbWCaGCJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 01:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbWCaGCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 01:02:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:47261 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750993AbWCaGCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 01:02:06 -0500
Date: Thu, 30 Mar 2006 22:01:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: linux-kernel@vger.kernel.org, clameter@engr.sgi.com, shai@scalex86.org,
       alok.kataria@calsoftinc.com, penberg@cs.Helsinki.FI
Subject: Re: [patch] slab: add statistics for alien cache overflows
Message-Id: <20060330220135.767663d7.akpm@osdl.org>
In-Reply-To: <20060331055648.GB4334@localhost.localdomain>
References: <20060331055648.GB4334@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
>
> Add a statistics counter which is incremented everytime the alien
>  cache overflows.  alien_cache limit is hardcoded to 12 right now.
>  We can use this statistics to tune alien cache if needed in the future.

Does it break slabtop, and whatever else reads /proc/slabinfo?
