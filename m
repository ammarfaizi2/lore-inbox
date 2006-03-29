Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWC2HnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWC2HnF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 02:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWC2HnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 02:43:05 -0500
Received: from noname.neutralserver.com ([70.84.186.210]:26852 "EHLO
	noname.neutralserver.com") by vger.kernel.org with ESMTP
	id S1751159AbWC2HnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 02:43:04 -0500
Date: Wed, 29 Mar 2006 09:43:52 +0200
From: Dan Aloni <da-x@monatomic.org>
To: Tejun Heo <htejun@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Status of NCQ in libata
Message-ID: <20060329074352.GA29915@localdomain>
References: <20060326192749.GA3643@localdomain> <20060327072945.GC8186@suse.de> <442A0980.6060403@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442A0980.6060403@gmail.com>
User-Agent: Mutt/1.5.11+cvs20060126
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - noname.neutralserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - monatomic.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2006 at 01:13:52PM +0900, Tejun Heo wrote:
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

Good to see it's going well. I'm considering to implement NCQ/TCQ for 
sata_mv (I have the necessary resources for it), so I'm hoping that I'd be 
able to base my efforts on the current ncq branch without worrying too 
much about interface changes.

-- 
Dan Aloni
da-x@monatomic.org, da-x@colinux.org, da-x@gmx.net, dan@xiv.co.il
