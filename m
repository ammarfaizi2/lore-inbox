Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbWDCEmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWDCEmD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 00:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWDCEmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 00:42:03 -0400
Received: from mail.gmx.de ([213.165.64.20]:52099 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751283AbWDCEmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 00:42:01 -0400
X-Authenticated: #14349625
Subject: Re: lowmem_reserve question
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, ck@vds.kolivas.org,
       Andrew Morton <akpm@osdl.org>,
       linux list <linux-kernel@vger.kernel.org>
In-Reply-To: <200604031248.13532.kernel@kolivas.org>
References: <200604021401.13331.kernel@kolivas.org>
	 <200604021939.21729.kernel@kolivas.org> <442F9E91.1020306@yahoo.com.au>
	 <200604031248.13532.kernel@kolivas.org>
Content-Type: text/plain
Date: Mon, 03 Apr 2006 06:42:46 +0200
Message-Id: <1144039366.8198.2.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-03 at 12:48 +1000, Con Kolivas wrote:
> Furthermore, now that we have the option of up to 3GB lowmem split on 32bit we 
> can have a default lowmem_reserve of almost 12MB (if I'm reading it right) 
> which seems very tight with only 16MB of ZONE_DMA. 

I haven't crawled around in the vm for ages, but I think that's only
16MB if you support antique cards.

	-Mike

