Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266743AbUHENAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266743AbUHENAy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 09:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267656AbUHEM6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 08:58:54 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:34003 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266686AbUHEM5d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 08:57:33 -0400
Date: Thu, 5 Aug 2004 14:57:16 +0200
From: Jens Axboe <axboe@suse.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: kernel@wildsau.enemy.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040805125716.GC12483@suse.de>
References: <200408051249.i75CnasZ004533@burner.fokus.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408051249.i75CnasZ004533@burner.fokus.fraunhofer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05 2004, Joerg Schilling wrote:
> 
> >From: Jens Axboe <axboe@suse.de>
> 
> >> Let me give you an advise: consolidate Linux so that is does only need
> >> /dev/sg and fix the bugs in ide-scsi instead of constantly inventing new
> >> unneeded interfaces.
> 
> >That's been the general direction for quite some time, just that SG_IO
> >is the preferred method since that works all around. You were the one
> >that merged support for the CDROM_SEND_PACKET interface, which has
> >_never_ been advertised as a way to burn CDs in Linux. I'd suggest you
> >remove that.
> 
> Again:
> 
> I'd be happy to start a discussion on this topic after the problem 
> with kernel panic() or general unusability with ide-scsi for PC-card
> or PCMCIA connected drives has been fixed for Linux-2.4 and all kernels
> outside have been replaced by working ones...
> 
> I reported this problem to the end of y2000, this is long time ago.

Well resend it then? Maybe it's your attitude that prevents it from
being fixed, if you think we will chase back a 4 year old email to fix
some obscure bug.

-- 
Jens Axboe

