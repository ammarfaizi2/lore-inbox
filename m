Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314571AbSEBPXm>; Thu, 2 May 2002 11:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314558AbSEBPWu>; Thu, 2 May 2002 11:22:50 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:10964 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S314557AbSEBPVY>; Thu, 2 May 2002 11:21:24 -0400
Date: Thu, 02 May 2002 08:18:33 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>,
        Daniel Phillips <phillips@bonn-fries.net>
cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <3968942217.1020327505@[10.10.2.3]>
In-Reply-To: <20020502153402.A11414@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> alpha is the same as mips I think. sparc would be the same too if
> there's any discontigmem sparc. Dunno of arm. We're talking about
> architectures needing discontigmem, 99% percent of users  doesn't need
> discontigmem in the first place, you never need discontigmem in x86 and

That's not true. We use discontigmem on the NUMA-Q boxes for NUMA support.
In some memory models, they're also really discontigous memory machines.
At the moment I use the contig memory model (so we only use discontig for
NUMA support) but I may need to change that in the future.

M.

