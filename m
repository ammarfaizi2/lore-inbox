Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267653AbUHEMGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267653AbUHEMGo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 08:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267659AbUHEMGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 08:06:43 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:35519 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267657AbUHEMFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 08:05:23 -0400
Date: Thu, 5 Aug 2004 14:05:08 +0200
From: Jens Axboe <axboe@suse.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: kernel@wildsau.enemy.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040805120507.GF11159@suse.de>
References: <200408051153.i75BrmCp004333@burner.fokus.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408051153.i75BrmCp004333@burner.fokus.fraunhofer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05 2004, Joerg Schilling wrote:
> >From axboe@suse.de  Wed Aug  4 14:58:33 2004
> 
> >> That's an extremely bad idea, you want to force ATA driver in either
> >> case.
> 
> >Which, happily, is what already happens and why it works fine when you
> >just do -dev=/dev/hdX. What should be removed is the warning that
> >cdrecord spits out when you do this, and the whole ATAPI thing should
> >just mirror ATA and scsi-linux-ata be killed completely.
> 
> Nice idea!
> 
> So please start with fixing ide-scsi for Linux-2.4 so Linux won't
> panic() when trying to access CD/DVD-drives that are connected via a
> PC-card interface using ide-scsi.

Let me dig through my mail box and find that report. Hmm that's strange,
you don't seem to have sent one. I'll just dig out the crystal ball and
get cracking on that fix.

-- 
Jens Axboe

