Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316986AbSFWHbI>; Sun, 23 Jun 2002 03:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316988AbSFWHbH>; Sun, 23 Jun 2002 03:31:07 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:28586 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316986AbSFWHbG>;
	Sun, 23 Jun 2002 03:31:06 -0400
Message-ID: <3D1578D3.20909@us.ibm.com>
Date: Sun, 23 Jun 2002 00:29:23 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: "Christopher E. Brown" <cbrown@woods.net>,
       Andreas Dilger <adilger@clusterfs.com>,
       "Griffiths, Richard A" <richard.a.griffiths@intel.com>,
       "'Andrew Morton'" <akpm@zip.com.au>, mgross@unix-os.sc.intel.com,
       "'Jens Axboe'" <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: ext3 performance bottleneck as the number of spindles
 gets large
References: <20020623043310.GL22411@clusterfs.com> <Pine.LNX.4.44.0206222350070.30350-100000@spruce.woods.net> <20020623063543.GH25360@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Sun, Jun 23, 2002 at 12:00:01AM -0600, Christopher E. Brown wrote:
> 
>>However, multiple busses are *rare* on x86.  There are alot of chained
>>busses via PCI to PCI bridge, but few systems with 2 or more PCI
>>busses of any type with parallel access to the CPU.
> 
> NUMA-Q has them.
> 

Yep, 2 independent busses per quad.  That's a _lot_ of busses when you 
have an 8 or 16 quad system.  (I wonder who has one of those... ;)

Almost all of the server-type boxes that we play with have multiple 
PCI busses.  Even my old dual-PPro has 2.

-- 
Dave Hansen
haveblue@us.ibm.com

