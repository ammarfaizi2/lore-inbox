Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261643AbSI0G25>; Fri, 27 Sep 2002 02:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261645AbSI0G25>; Fri, 27 Sep 2002 02:28:57 -0400
Received: from beppo.feral.com ([192.67.166.79]:38671 "EHLO beppo.feral.com")
	by vger.kernel.org with ESMTP id <S261643AbSI0G24>;
	Fri, 27 Sep 2002 02:28:56 -0400
Date: Thu, 26 Sep 2002 23:33:49 -0700 (PDT)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: mjacob@feral.com
To: Jens Axboe <axboe@suse.de>
cc: "Justin T. Gibbs" <gibbs@scsiguy.com>,
       "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while doing file
 transfers
In-Reply-To: <20020927061328.GL5646@suse.de>
Message-ID: <Pine.BSF.4.21.0209262333050.17672-100000@beppo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 2.4 layer is most horrible there, 2.5 at least gets rid of the old
> scsi_dma crap. That said, 253 default depth is a bit over the top, no?

Why? Something like a large Hitachi 9*** storage system can take ~1000
tags w/o wincing.


