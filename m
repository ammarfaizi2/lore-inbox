Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266635AbUHIOen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266635AbUHIOen (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 10:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266674AbUHIOct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 10:32:49 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:21457 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266635AbUHIOcA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 10:32:00 -0400
Date: Mon, 9 Aug 2004 16:31:31 +0200
From: Jens Axboe <axboe@suse.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org,
       skraw@ithnet.com
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040809143131.GT10418@suse.de>
References: <200408091427.i79ERTYv010598@burner.fokus.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408091427.i79ERTYv010598@burner.fokus.fraunhofer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09 2004, Joerg Schilling wrote:
> >From: Jens Axboe <axboe@suse.de>
> 
> >> Just fix the bugs from the List I send you and wait some time......
> 
> >Most of them you don't want me to fix. If you truly wanted me to fix the
> >problems, I'm sure you would have provided some evidence for them to be
> >fixable.
> 
> Well, it is not just you... the mail is CC:d to LKML and I am sure
> there are other people who could fix the problems.

Joerg, read what is written in the emails. You'll find it much easier to
carry a discussion if you have read what you reply to.

I said that you provide zero evidence of the bugs you list. Some of them
are fixable (sense bug we already uncovered, if you would fix it in your
code. SG_SET_RESERVED_SIZE patch has been submitted to linus from me),
some of them will not be fixed as they are not bugs (addressing issues),
and yet some of them are utterly impossible to fix since you provide
nothing to back them up. "Some SCSI driver breaks with bad dma
alignment" - what the hell am I supposed to do with that? Go audit all
SCSI drivers and your whim and see if I can find such a bug in there?

-- 
Jens Axboe

