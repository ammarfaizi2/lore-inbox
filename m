Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262110AbSJJTbg>; Thu, 10 Oct 2002 15:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262115AbSJJTbg>; Thu, 10 Oct 2002 15:31:36 -0400
Received: from dsl-213-023-020-143.arcor-ip.net ([213.23.20.143]:27075 "EHLO
	starship") by vger.kernel.org with ESMTP id <S262110AbSJJTbf>;
	Thu, 10 Oct 2002 15:31:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andreas Dilger <adilger@clusterfs.com>
Subject: Re: two problems using EXT3 htrees
Date: Thu, 10 Oct 2002 21:07:35 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrew_Purtell@NAI.com, tytso@mit.edu, linux-kernel@vger.kernel.org
References: <1D4F16D4D695D21186A300A0C9DCF9838F611F@LOS-83-207.nai.com> <E17zd3i-0008A8-00@starship> <20021010170317.GI3045@clusterfs.com>
In-Reply-To: <20021010170317.GI3045@clusterfs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17ziem-0000Dk-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 October 2002 19:03, Andreas Dilger wrote:
> On Oct 10, 2002  15:08 +0200, Daniel Phillips wrote:
> > On Wednesday 09 October 2002 20:29, Andrew_Purtell@NAI.com wrote:
> > > I recently patched my 2.4.19 kernel with EXT3 dir_index support and tried
> > > it out on my 80GB EXT3 data partition...
> > 
> > Could you please provide a pointer to the patch you used?
> 
> A number of people have been getting this same bug under high load.  I
> believe they are using the patches from Ted, and/or BK extfs.bkbits.net.

Does the Chris Lee flavor of the patch (before Ted's cleanups) exhibit the
same bug?  I suppose the pre-cleanup patch is incompatible with e2fsck
because of the hash function change, but that would be easy to fix.

-- 
Daniel
