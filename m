Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315441AbSEBVl4>; Thu, 2 May 2002 17:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315442AbSEBVlz>; Thu, 2 May 2002 17:41:55 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:3769 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315441AbSEBVlx>;
	Thu, 2 May 2002 17:41:53 -0400
Date: Thu, 02 May 2002 15:39:54 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <150570000.1020379194@flay>
In-Reply-To: <20020502205741.O11414@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The difference is that if you use discontigmem you don't clobber the
> common code in any way, there is no "logical/ordinal" abstraction,
> there is no special table, it's all hidden in the arch section, and the
> pgdat you need them anyways to allocate from affine memory with numa.

I *want* the logical / ordinal abstraction. That's not a negative thing -
it reduces the number of complicated things I have to think about,
allowing me to think more clearly, and write correct code ;-)

Not having a multitude of zones to balance in the normal discontigmem
case also seems like a powerful argument to me ...

M.

