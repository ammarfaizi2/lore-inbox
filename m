Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271261AbRHOQV5>; Wed, 15 Aug 2001 12:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271268AbRHOQVr>; Wed, 15 Aug 2001 12:21:47 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:60683 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271261AbRHOQV0>; Wed, 15 Aug 2001 12:21:26 -0400
Subject: Re: ll_rw_blk.c changes from 2.4.8 not in -ac
To: marcelo@conectiva.com.br (Marcelo Tosatti)
Date: Wed, 15 Aug 2001 17:24:03 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org (lkml),
        axboe@suse.de (Jens Axboe)
In-Reply-To: <Pine.LNX.4.21.0108151147520.26259-100000@freak.distro.conectiva> from "Marcelo Tosatti" at Aug 15, 2001 11:50:29 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15X3Sd-0003WO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why 2.4.8-ac does not contain 2.4.8's ll_rw_blk.c changes ? (the ones
> which remove the "queued_sectors" logic)
> 
> Those changes improve IO latency a lot.

Because I want to seperate out the issues. Also the RA on -ac is much higher
so the effect is very different.

When we change things one at a time, then they can be measured.
