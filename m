Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290796AbSCGC2X>; Wed, 6 Mar 2002 21:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290797AbSCGC2J>; Wed, 6 Mar 2002 21:28:09 -0500
Received: from ns0.auctionwatch.com ([66.7.130.2]:27143 "EHLO
	whitestar.auctionwatch.com") by vger.kernel.org with ESMTP
	id <S290796AbSCGC1z>; Wed, 6 Mar 2002 21:27:55 -0500
Date: Wed, 6 Mar 2002 18:27:49 -0800
From: Petro <petro@auctionwatch.com>
To: Michael Cheung <vividy@justware.co.jp>
Cc: Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: mount -o remount,ro cause error "device is busy"
Message-ID: <20020307022749.GF32504@auctionwatch.com>
In-Reply-To: <20020306074908.GA342@matchmail.com> <20020306011519.C963@lynx.adilger.int> <20020306172418.C8A3.VIVIDY@justware.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020306172418.C8A3.VIVIDY@justware.co.jp>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2002 at 05:33:45PM +0900, Michael Cheung wrote:
> hi,
> 
> maybe i am wrong, but I really can't find any other process runing.
> 
> my step is:
> 1) "/" and "/usr" are busy
> 2) shut down to single user mode
> 3) "/" still busy
> 4) "/usr" can be unmounted, but can't mount -o ro,remount /usr, show busy error.
> 5) umount -a, after this, only /proc and / exist.
> 6) mount -o ro,remount /, show busy error.
> On Wed, 6 Mar 2002 01:15:19 -0700
> Andreas Dilger <adilger@clusterfs.com> wrote:
> > Clearly, some program is keeping "/usr" busy (which is keeping "/" busy)
> > before the change to single user mode.  Just a bit of "lsof" needed to
> > find such things.                                      ||||
                                                           ^^^^
    Best bet is to man lsof. 

    lsof's your buddy. 
    
-- 
Share and Enjoy. 
