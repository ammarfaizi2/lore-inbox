Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143931AbRA1Tni>; Sun, 28 Jan 2001 14:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143939AbRA1Tn2>; Sun, 28 Jan 2001 14:43:28 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:38923 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S143931AbRA1TnR>;
	Sun, 28 Jan 2001 14:43:17 -0500
Date: Sun, 28 Jan 2001 20:43:08 +0100
From: Jens Axboe <axboe@suse.de>
To: Andreas Franck <afranck@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.0 loop device still hangs
Message-ID: <20010128204308.F5522@suse.de>
In-Reply-To: <01012814012000.00354@dg1kfa.ampr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01012814012000.00354@dg1kfa.ampr.org>; from afranck@gmx.de on Sun, Jan 28, 2001 at 02:01:20PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 28 2001, Andreas Franck wrote:
> Hi Jens,
> 
> I've tested your patch quite as heavy as it gets: I created 5 files of each 
> 100 MB, set up 5 loop devices and made a RAID5 array out of them, putting 
> ext2 on it and running a bonnie loop with 350 MB test size over it for the 
> night.
> 
> Everything survived, worked flawlessly and I'm happy my disk did too :-)
> Many thanks for the fine work!

Thanks for the testing, it does indeed look promising if it survives
a beating like that :-)

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
