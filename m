Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbVAUG06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbVAUG06 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 01:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbVAUG06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 01:26:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:13993 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262279AbVAUG05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 01:26:57 -0500
Date: Thu, 20 Jan 2005 22:26:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, npiggin@novell.com,
       Rik van Riel <riel@redhat.com>
Subject: Re: writeback-highmem
Message-Id: <20050120222630.6168a4cb.akpm@osdl.org>
In-Reply-To: <20050121060135.GF12647@dualathlon.random>
References: <20050121054840.GA12647@dualathlon.random>
	<20050121054916.GB12647@dualathlon.random>
	<20050121054945.GC12647@dualathlon.random>
	<20050121055004.GD12647@dualathlon.random>
	<20050121055043.GE12647@dualathlon.random>
	<20050121060135.GF12647@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> This needed highmem fix from Rik is still missing too, so please apply
>  along the other 5 (it's orthogonal so you can apply this one in any
>  order you want).
> 
>  From: Rik van Riel <riel@redhat.com>
>  Subject: [PATCH][1/2] adjust dirty threshold for lowmem-only mappings

I've held off on this one because the recent throttling fix should have
helped this problem.  Has anyone confirmed that this patch still actually
fixes something?  If so, what was the scenario?

Thanks.
