Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312898AbSDOFs0>; Mon, 15 Apr 2002 01:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312913AbSDOFsZ>; Mon, 15 Apr 2002 01:48:25 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:35599 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S312898AbSDOFsY>;
	Mon, 15 Apr 2002 01:48:24 -0400
Date: Mon, 15 Apr 2002 07:47:59 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: 2.5.8 does not boot
Message-ID: <20020415054759.GA12608@suse.de>
In-Reply-To: <UTC200204142229.WAA577107.aeb@cwi.nl> <Pine.LNX.4.33.0204141803010.1206-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14 2002, Linus Torvalds wrote:
> 
> 
> On Sun, 14 Apr 2002 Andries.Brouwer@cwi.nl wrote:
> >
> > Booting 2.5.8 yields a crash at ide-disk.c:360
> > 	BUG_ON(drive->tcq->active_tag != -1);
> 
> The TCQ stuff is definitely experimental, you should probably configure it
> out for now.

Definitely, it's an early merge and I thought that Martin left out the
config options... That said, Andries could you send me your ide boot
messages?

-- 
Jens Axboe

