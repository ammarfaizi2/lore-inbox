Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285079AbRL2RRr>; Sat, 29 Dec 2001 12:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285099AbRL2RRh>; Sat, 29 Dec 2001 12:17:37 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:36366 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S285079AbRL2RRY>;
	Sat, 29 Dec 2001 12:17:24 -0500
Date: Sat, 29 Dec 2001 18:17:17 +0100
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.5.2-pre3] Harddisk Performance
Message-ID: <20011229181717.C1821@suse.de>
In-Reply-To: <20011229162930.GA317@elfie.cavy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011229162930.GA317@elfie.cavy.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29 2001, Heinz Diehl wrote:
> Hi!
> 
> Running 2.5.2-pre3, hdparm shows up very poor harddisk performance
> on my system compared to 2.4.x:
> 
> [Kernel 2.5.2-pre3]
> 
> elfie:~ # hdparm -tT /dev/hda
> 
> /dev/hda:
> Timing buffer-cache reads:   128 MB in  1.77 seconds = 72.32 MB/sec
> Timing buffered disk reads:  64 MB in 22.09 seconds =  2.90 MB/sec
>                                                        ^^^^
> [Kernel 2.4.17]
> 
> elfie:~ # hdparm -tT /dev/hda
> 
> /dev/hda:
> Timing buffer-cache reads:   128 MB in  1.81 seconds = 70.72 MB/sec
> Timing buffered disk reads:  64 MB in  6.61 seconds =  9.68 MB/sec

Yes I just noticed that too (someone else reported it) -- seems to be
due to missed merges, I'm investigating. The list corruption bug has
higher prio rigth now, though.

-- 
Jens Axboe

