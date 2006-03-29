Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWC2HPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWC2HPa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 02:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWC2HPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 02:15:30 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:13349 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751124AbWC2HP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 02:15:29 -0500
Date: Wed, 29 Mar 2006 09:15:38 +0200
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: Dan Aloni <da-x@monatomic.org>, linux-kernel@vger.kernel.org
Subject: Re: Status of NCQ in libata
Message-ID: <20060329071538.GQ8186@suse.de>
References: <20060326192749.GA3643@localdomain> <20060327072945.GC8186@suse.de> <442A0980.6060403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442A0980.6060403@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29 2006, Tejun Heo wrote:
> Jens Axboe wrote:
> >On Sun, Mar 26 2006, Dan Aloni wrote:
> >>Hello,
> >>
> >>I'd like to know about the current status of NCQ support in libata,
> >>whether anyone is actively working on it, where I should find a 
> >>development branch (there's no ncq branch anymore in libata-dev.git
> >>it seems) and when an upstream merge should be expected.
> >
> >You can give it a spin in the 'ncq' branch in the block layer git repo:
> >
> >git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-2.6-block.git
> >
> >Only one real bit needs to get merged in libata for ncq to be submitted,
> >and that is Tejun's eh rework. Once that is in, ncq becomes a fairly
> >small patch and can probably go straight in.
> >
> >AHCI is still the only supported controller, once NCQ is merged I'm sure
> >a few others will follow.
> >
> 
> Patches going out later today. :) I've just ported the NCQ stuff over it 
> and about to test it. As I have the doc and hardware NCQ support for 
> sata_sil24 will soon follow.

Wonderful! I'm pretty confident in the NCQ stuff these days, so if Jeff
is up for it, it could make 2.6.17.

-- 
Jens Axboe

