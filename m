Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289054AbSAGAXa>; Sun, 6 Jan 2002 19:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289055AbSAGAXV>; Sun, 6 Jan 2002 19:23:21 -0500
Received: from dsl-213-023-043-049.arcor-ip.net ([213.23.43.49]:20491 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289054AbSAGAXP>;
	Sun, 6 Jan 2002 19:23:15 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [RFC] Unbork fs.h, 1 of 4
Date: Mon, 7 Jan 2002 01:27:08 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <E16NLbK-0001LE-00@starship.berlin>
In-Reply-To: <E16NLbK-0001LE-00@starship.berlin>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16NNd6-0001Lx-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The approach I used to modify Ext2 would work well for all the filesystems in 
> the tree.  Most of the work consists of a simple global edit along the lines 
> of:
> 
>    s/u.ext2_i./ext2_i(inode)->/

Whoops, please excuse me:

     s/inode->u.ext2_i./ext2_i(inode)->/

--
Daniel
