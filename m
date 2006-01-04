Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbWADPLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWADPLn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 10:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWADPLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 10:11:43 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:28009 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751791AbWADPLm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 10:11:42 -0500
Date: Wed, 4 Jan 2006 16:13:25 +0100
From: Jens Axboe <axboe@suse.de>
To: Mark Lord <lkml@rtr.ca>
Cc: Sebastian <sebastian_ml@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: Digital Audio Extraction with ATAPI drives far from perfect
Message-ID: <20060104151325.GI3389@suse.de>
References: <20060103222044.GA17682@section_eight.mops.rwth-aachen.de> <20060104092058.GN3472@suse.de> <20060104092443.GO3472@suse.de> <43BBE4E4.6090900@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43BBE4E4.6090900@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04 2006, Mark Lord wrote:
> Jens Axboe wrote:
> ...
> >Oh, and try and disable DMA on the cd driver and repeat your results
> >with ide-cd. It uses DMA, where ide-scsi does not.
> 
> Eh?  Sure it does!

Only for transfers multiple of 1k, which the DMA ripping is not.

-- 
Jens Axboe

