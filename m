Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbUCDP2t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 10:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbUCDP2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 10:28:49 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:46231 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261935AbUCDP2r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 10:28:47 -0500
Date: Thu, 4 Mar 2004 16:28:40 +0100
From: Jens Axboe <axboe@suse.de>
To: Vince <fuzzy77@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 ide-cd DMA ripping
Message-ID: <20040304152840.GL2708@suse.de>
References: <40470E03.2020809@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40470E03.2020809@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04 2004, Vince wrote:
> Hi,
> 
> I've tried your patch (with the modifications you hinted, included in 
> attachment) with cdparanoia and:
> 
> 1) it works (I get an identical wav)
> 2) it makes indeed a huge difference on my system:
> 
> - before:
> cdparanoia 1  4.20s user 1.98s system 3% cpu 3:12.89 total
> - after:
> cdparanoia 1  3.87s user 1.41s system 15% cpu 33.793 total
> 
> Total time went from 3 min to 30 sec... really great :-)

Thanks for testing (and reporting back).

-- 
Jens Axboe

