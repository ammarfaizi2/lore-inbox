Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293397AbSBYRiH>; Mon, 25 Feb 2002 12:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293444AbSBYRh5>; Mon, 25 Feb 2002 12:37:57 -0500
Received: from dsl-213-023-039-132.arcor-ip.net ([213.23.39.132]:14976 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S293397AbSBYRho>;
	Mon, 25 Feb 2002 12:37:44 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Son of Unbork (1 of 3)
Date: Sat, 23 Feb 2002 19:30:26 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
In-Reply-To: <Pine.GSO.4.21.0202251224150.3162-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0202251224150.3162-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16egwF-00006e-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 25, 2002 06:24 pm, Alexander Viro wrote:
> On Sat, 23 Feb 2002, Daniel Phillips wrote:
> 
> > This three patch set completes the removal of ext2-specific includes from 
> > fs.h.  When this is done, your kernel will compile a little faster, the Ext2 
> > source will be organized a little better, and then infamous fs.h super_block 
> > union will no longer hurt your eyes.  When every filesystem has been changed 
> > in a similar way, fs.h will finally be generic, in-memory super_blocks will be
> > somewhat smaller, and the kernel will compile quite a lot faster.  And peace
> > will come once more to Middle-Earth.  (I made that last part up.)
> > 
> > Patch 1 adds alloc_super and destroy_super methods to struct file_system.  A 
> 
> Vetoed.

Thanks for the eloquent and informative response.

-- 
Daniel
