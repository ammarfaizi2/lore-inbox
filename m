Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267259AbTAKPXA>; Sat, 11 Jan 2003 10:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267263AbTAKPXA>; Sat, 11 Jan 2003 10:23:00 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:56234 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S267259AbTAKPW7>; Sat, 11 Jan 2003 10:22:59 -0500
Message-Id: <200301101558.h0AFwbRU011029@eeyore.valparaiso.cl>
To: Peter Chubb <peter@chubb.wattle.id.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: ISO-9660 Rock Ridge gives different links different inums 
In-Reply-To: Message from Peter Chubb <peter@chubb.wattle.id.au> 
   of "Fri, 10 Jan 2003 19:56:04 +1100." <15902.35492.536040.298566@wombat.chubb.wattle.id.au> 
Date: Fri, 10 Jan 2003 16:58:37 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Chubb <peter@chubb.wattle.id.au> said:

[...]

> The problem is that in Unix the fundamental identity of a file is
> the tuple (blkdev, inum); names are merely indices (links) that resolve to
> that tuple.   Personally, I'd swap to a pair of system calls to map
> name to (blkdev, inum), and open(blkdev, inum).  Think of the inode
> number as a unique within-filesystem index.

That way any joker can go ahead and open any file, without any regard to
permission bits on the directories that lead there. Not nice.
--
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
