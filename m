Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267318AbTAOU6S>; Wed, 15 Jan 2003 15:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266996AbTAOU6S>; Wed, 15 Jan 2003 15:58:18 -0500
Received: from mhw.ulib.iupui.edu ([134.68.164.23]:17886 "EHLO
	mhw.ulib.iupui.edu") by vger.kernel.org with ESMTP
	id <S267318AbTAOU6S>; Wed, 15 Jan 2003 15:58:18 -0500
Date: Wed, 15 Jan 2003 16:07:13 -0500 (EST)
From: "Mark H. Wood" <mwood@IUPUI.Edu>
X-X-Sender: <mwood@mhw.ULib.IUPUI.Edu>
To: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ISO-9660 Rock Ridge gives different links different inums 
In-Reply-To: <200301101558.h0AFwbRU011029@eeyore.valparaiso.cl>
Message-ID: <Pine.LNX.4.33.0301151601240.29932-100000@mhw.ULib.IUPUI.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2003, Horst von Brand wrote:
> Peter Chubb <peter@chubb.wattle.id.au> said:
> [...]
> > The problem is that in Unix the fundamental identity of a file is
> > the tuple (blkdev, inum); names are merely indices (links) that resolve to
> > that tuple.   Personally, I'd swap to a pair of system calls to map
> > name to (blkdev, inum), and open(blkdev, inum).  Think of the inode
> > number as a unique within-filesystem index.
>
> That way any joker can go ahead and open any file, without any regard to
> permission bits on the directories that lead there. Not nice.

Welcome to VMS, which can open files by INDEXF.SYS offset.  Some app.s
which create and delete files rapidly never bother to make directory
entries at all.  It may not be what you're used to, and it may be contrary
to expected Unix semantics, but it's not unthinkable.

-- 
Mark H. Wood, Lead System Programmer   mwood@IUPUI.Edu
MS Windows *is* user-friendly, but only for certain values of "user".

