Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314049AbSEFBNm>; Sun, 5 May 2002 21:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314043AbSEFBNl>; Sun, 5 May 2002 21:13:41 -0400
Received: from dsl-213-023-038-176.arcor-ip.net ([213.23.38.176]:51133 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314049AbSEFBNl>;
	Sun, 5 May 2002 21:13:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Date: Mon, 6 May 2002 03:13:08 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrea Arcangeli <andrea@suse.de>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020502180632.I11414@dualathlon.random> <E174Vq8-0004BK-00@starship> <20020506015505.B14956@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E174X3s-0004CD-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 May 2002 02:55, Russell King wrote:
> On Mon, May 06, 2002 at 01:54:52AM +0200, Daniel Phillips wrote:
> > I must be guilty of not explaining clearly.  Suppose you have the following
> > physical memory map:
> > 
> > 	          0: 128 MB
> > 	  8000,0000: 128 MB
> > 	1,0000,0000: 128 MB
> > 	1,8000,0000: 128 MB
> > 	2,0000,0000: 128 MB
> > 	2,8000,0000: 128 MB
> > 	3,0000,0000: 128 MB
> > 	3,8000,0000: 128 MB
> > 
> > The total is 1 GB of installed ram.  Yet the kernel's 1G virtual space,
> > can only handle 128 MB of it.
> 
>... I've been running kernels for a while on such systems.

Could you provide me with an example memory map, please?

-- 
Daniel
