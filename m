Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273537AbRIUNgV>; Fri, 21 Sep 2001 09:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273535AbRIUNgM>; Fri, 21 Sep 2001 09:36:12 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:37054 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S273533AbRIUNgF>;
	Fri, 21 Sep 2001 09:36:05 -0400
Date: Fri, 21 Sep 2001 09:36:25 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Oystein Viggen <oysteivi@tihlde.org>
cc: David Chow <davidchow@rcn.com.hk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Wrapfs a stackable file system
In-Reply-To: <03vgicptfb.fsf@colargol.tihlde.org>
Message-ID: <Pine.GSO.4.21.0109210931250.8014-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 21 Sep 2001, Oystein Viggen wrote:

> * [	David Chow] 
> 
> > The idea is orinigally from FiST, a stackable file system. But the FiST
> > owner Erez seems given up to maintain the project. At the time I receive
> > the code, it is so buggy, even unusable, lots of segmentation fault
> > problems. I have debugging the fs for quite a while. Now it is useful in
> > just use as a file system wrapper. It is useful in chroot environments
> > and hardlinks aren't available. It wraps a directory and mount to
> > another directory on tops of any filesystems.
> 
> Is this not essentially what we already have with mount --bind in 2.4?

Bindings can be used to get the same result, but underlying mechanics is
different.  Wrapfs is not the most interesting application of FiST, so it's 
hardly a surprise...

