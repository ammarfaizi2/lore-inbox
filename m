Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292057AbSBYR1t>; Mon, 25 Feb 2002 12:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288980AbSBYR1l>; Mon, 25 Feb 2002 12:27:41 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:47513 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S293408AbSBYRYs>;
	Mon, 25 Feb 2002 12:24:48 -0500
Date: Mon, 25 Feb 2002 12:24:33 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] Son of Unbork (1 of 3)
In-Reply-To: <E16egez-00006K-00@starship.berlin>
Message-ID: <Pine.GSO.4.21.0202251224150.3162-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 23 Feb 2002, Daniel Phillips wrote:

> This three patch set completes the removal of ext2-specific includes from 
> fs.h.  When this is done, your kernel will compile a little faster, the Ext2 
> source will be organized a little better, and then infamous fs.h super_block 
> union will no longer hurt your eyes.  When every filesystem has been changed 
> in a similar way, fs.h will finally be generic, in-memory super_blocks will be
> somewhat smaller, and the kernel will compile quite a lot faster.  And peace
> will come once more to Middle-Earth.  (I made that last part up.)
> 
> Patch 1 adds alloc_super and destroy_super methods to struct file_system.  A 

Vetoed.

