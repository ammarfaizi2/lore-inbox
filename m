Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262570AbUCEMWa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 07:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbUCEMWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 07:22:30 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:24791 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262570AbUCEMWA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 07:22:00 -0500
Date: Fri, 5 Mar 2004 13:21:51 +0100
From: Jens Axboe <axboe@suse.de>
To: Colin Leroy <colin@colino.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6 ide-cd DMA ripping
Message-ID: <20040305122151.GL10923@suse.de>
References: <20040304152840.GL2708@suse.de> <20040305130803.0c01ee83@jack.colino.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040305130803.0c01ee83@jack.colino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05 2004, Colin Leroy wrote:
> Hi,
> 
> >I'd appreciate people giving this a test spin. Patch is against
> >2.6.4-rc1 (well current BK, actually).
> 
> Works (on ppc, ibook G4 here). It's indeed faster. But, it breaks direct 
> output to dsp (as in `cdparanoia 1 /dev/dsp`). 

How do you know it works, then? cdparanoia should receive identical
data, otherwise it sounds like it doesn't work.

Dump a track without the patch, repeat with the patch, and compare the
images.

(BTW, please cc recipients on lkml. At least to me, otherwise I may not
see your message for days).

-- 
Jens Axboe

