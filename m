Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261918AbREXNeH>; Thu, 24 May 2001 09:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261924AbREXNdr>; Thu, 24 May 2001 09:33:47 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:63487 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261918AbREXNdp>;
	Thu, 24 May 2001 09:33:45 -0400
Date: Thu, 24 May 2001 09:33:43 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Mike Galbraith <mikeg@wen-online.de>
cc: Maciek Nowacki <maciek@Voyager.powersurfr.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Busy on BLKFLSBUF w/initrd
In-Reply-To: <Pine.LNX.4.33.0105241524290.824-100000@mikeg.weiden.de>
Message-ID: <Pine.GSO.4.21.0105240932001.23054-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 24 May 2001, Mike Galbraith wrote:

> > Erm... You pin the inode down. That makes filesystem busy by any
> > definition I can think of...
> 
> Yes. I pulled the pins when I was done with them though.
> (at least I think I did.. been a long time)

Only when you do rd_cleanup().

