Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbTKEKaM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 05:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbTKEKaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 05:30:11 -0500
Received: from ns.suse.de ([195.135.220.2]:36255 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262874AbTKEKaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 05:30:06 -0500
Date: Wed, 5 Nov 2003 11:29:04 +0100
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
Message-ID: <20031105102904.GK1477@suse.de>
References: <3FA69CDF.5070908@gmx.de> <20031105084007.GZ1477@suse.de> <3FA8C916.3060702@gmx.de> <20031105095457.GG1477@suse.de> <3FA8CA87.2070201@gmx.de> <20031105100120.GH1477@suse.de> <3FA8CCF9.6070700@gmx.de> <3FA8D059.7010204@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FA8D059.7010204@cyberone.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 05 2003, Nick Piggin wrote:
> 
> 
> Prakash K. Cheemplavam wrote:
> 
> >
> >SOmething else I noticed with new 2.6tes9-mm2 kernel: Now the mouse 
> >stutters slighty when burning (in atapi mode). I am now using as 
> >sheduler. Shoudl I try deadline or do you this it is something else? 
> >Should I open a new topic?
> >
> 
> This is more likely to be the CPU scheduler or something holding
> interrupts for too long. Are you running anything at a modified
                 ^^^^^^^^

precisely, that's why the actual interface that cdrecord uses is the
primary key to knowing what the problem is.

-- 
Jens Axboe

