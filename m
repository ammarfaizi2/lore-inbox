Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264244AbRGNRSr>; Sat, 14 Jul 2001 13:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264345AbRGNRSg>; Sat, 14 Jul 2001 13:18:36 -0400
Received: from weta.f00f.org ([203.167.249.89]:34691 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S264244AbRGNRSX>;
	Sat, 14 Jul 2001 13:18:23 -0400
Date: Sun, 15 Jul 2001 05:18:26 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Paul Jakma <paulj@alphyra.ie>
Cc: Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 64 bit scsi read/write
Message-ID: <20010715051826.D7056@weta.f00f.org>
In-Reply-To: <Pine.LNX.4.33.0107141641030.1063-100000@rossi.itg.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0107141641030.1063-100000@rossi.itg.ie>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tmpfs is going to be _much_ faster than any external bus-connected
NVRAM solution

create a ram disk on a PCI connected video card and journal to that to
compare if you like (PCI bulk writes suck for speed)




  --cw





On Sat, Jul 14, 2001 at 04:42:04PM +0100, Paul Jakma wrote:
    On Sun, 15 Jul 2001, Chris Wedgwood wrote:
    
    > *why* would you want to to do this?
    
    :)
    
    to test performance advantage of journal on RAM before going to spend
    money on NVRAM...
    
    >   --cw
    
    --paulj
    
