Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315382AbSEBT36>; Thu, 2 May 2002 15:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315384AbSEBT34>; Thu, 2 May 2002 15:29:56 -0400
Received: from dsl-213-023-038-046.arcor-ip.net ([213.23.38.46]:23969 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315382AbSEBT24>;
	Thu, 2 May 2002 15:28:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: William Lee Irwin III <wli@holomorphy.com>,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Date: Thu, 2 May 2002 21:27:00 +0200
X-Mailer: KMail [version 1.3.2]
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20020502180632.I11414@dualathlon.random> <20020502204136.M11414@dualathlon.random> <20020502191903.GL32767@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E173MEW-00027y-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 May 2002 21:19, William Lee Irwin III wrote:
> On Thu, May 02, 2002 at 08:41:36PM +0200, Andrea Arcangeli wrote:
> > Dropping the loop when discontigmem is enabled is much more interesting
> > optimization of course.
> > Andrea
> 
> Absolutely; I'd be very supportive of improvements for this case as well.
> Many of the systems with the need for discontiguous memory support will
> also benefit from parallelizations or other methods of avoiding references
> to remote nodes/zones or iterations over all nodes/zones.

Which loop in which function are we talking about?

-- 
Daniel
