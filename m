Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275650AbSIUBr2>; Fri, 20 Sep 2002 21:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275654AbSIUBr2>; Fri, 20 Sep 2002 21:47:28 -0400
Received: from franka.aracnet.com ([216.99.193.44]:21439 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S275650AbSIUBr2>; Fri, 20 Sep 2002 21:47:28 -0400
Date: Fri, 20 Sep 2002 18:50:20 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: colpatch@us.ibm.com, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>,
       James Cleverdon <cleverdj@us.ibm.com>
Subject: Re: CONFIG_MULTIQUAD has got to go...
Message-ID: <544886755.1032547819@[10.10.2.3]>
In-Reply-To: <3D8BC45F.5050007@us.ibm.com>
References: <3D8BC45F.5050007@us.ibm.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linus,
> 	The CONFIG_MULTIQUAD option has bothered me for a while now.  It actually covers the jobs of 3 config options, 2 of which exist.
> 
> This patch splits the use of CONFIG_MULTIQUAD into the 3 config options that it really means:
> CONFIG_X86_NUMA: General X86 NUMA code (already exists)
> CONFIG_X86_NUMAQ: Code specific to just the NUMA-Q platform (already exists)
> CONFIG_CLUSTERED_APIC: Code that specifically deals with clustered APIC mode (new option)
> 
> The patch replaces every occurence of CONFIG_MULTIQUAD in the kernel, save 1 (arch/i386/pci/Makefile), which is remedied by the patch I will send momentarily.
> 
> Please apply.

As the person who put this in there in the first place ... then 
extended it beyond any sane use ... I agree this should die ;-)
The new naming scheme makes much more sense ...

M.

