Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVAUIxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVAUIxT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 03:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVAUIxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 03:53:18 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:1163 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262322AbVAUItY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 03:49:24 -0500
Date: Fri, 21 Jan 2005 09:49:07 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Lennert Van Alboom <lennert.vanalboom@ugent.be>,
       linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: possible memleak in 2.6.11-rc1
Message-ID: <20050121084906.GF2763@suse.de>
References: <200501191956.48228.lennert.vanalboom@ugent.be> <20050120191943.0ac5bad5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120191943.0ac5bad5.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20 2005, Andrew Morton wrote:
> Lennert Van Alboom <lennert.vanalboom@ugent.be> wrote:
> >
> > Possible memleak in 2.6.11-rc1?
> 
> Please wait for it to happen again and then send the contents of
> /proc/meminfo and /proc/slabinfo.

I've seen the same thing btw, after 2 days on 2.6.11-rc1 most of memory
is gone. There definitely seems to be a leak in 2.6.11-rc1 that wasn't
there in 2.6.10.

I'll try and save the meminfo/slabinfo as well.

-- 
Jens Axboe

