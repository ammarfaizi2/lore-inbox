Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314043AbSEFBZb>; Sun, 5 May 2002 21:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314047AbSEFBZb>; Sun, 5 May 2002 21:25:31 -0400
Received: from dsl-213-023-038-176.arcor-ip.net ([213.23.38.176]:58557 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314043AbSEFBZa>;
	Sun, 5 May 2002 21:25:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Date: Mon, 6 May 2002 03:24:58 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Russell King <rmk@arm.linux.org.uk>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020502180632.I11414@dualathlon.random> <E174Wy4-0004C2-00@starship> <20020506032054.F6712@dualathlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E174XFK-0004CJ-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 May 2002 03:20, Andrea Arcangeli wrote:
> On Mon, May 06, 2002 at 03:07:07AM +0200, Daniel Phillips wrote:
> > On Monday 06 May 2002 02:55, Russell King wrote:
> > So, since __phys_to_virt (and hence phys_to_virt and __va) is clearly linear, the
> > relation __pa(__va(kva)) == kva cannot hold.  Perhaps that doesn't bother you?
> 
> Check my previous email:
> 
> 	[..] They will all be normal zones provided you implement a static
> 	view of them in the kernel virtual address space, and you also
> 	cover page_address/virt_to_page [..]
> 
> Depending on the kind of coalescing of those chunks in the direct
> mapping virt_to_page/page_address will vary. virt_to_page and
> page_address will have all the necessary internal knowledge in order to
> make it all zone_normal.

What do you mean by 'implement a static view of them'?

-- 
Daniel
