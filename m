Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316988AbSFWHhc>; Sun, 23 Jun 2002 03:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316989AbSFWHhc>; Sun, 23 Jun 2002 03:37:32 -0400
Received: from holomorphy.com ([66.224.33.161]:7624 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316988AbSFWHhb>;
	Sun, 23 Jun 2002 03:37:31 -0400
Date: Sun, 23 Jun 2002 00:36:44 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: "Christopher E. Brown" <cbrown@woods.net>,
       Andreas Dilger <adilger@clusterfs.com>,
       "Griffiths, Richard A" <richard.a.griffiths@intel.com>,
       "'Andrew Morton'" <akpm@zip.com.au>, mgross@unix-os.sc.intel.com,
       "'Jens Axboe'" <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: ext3 performance bottleneck as the number of spindles gets large
Message-ID: <20020623073644.GK25360@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Hansen <haveblue@us.ibm.com>,
	"Christopher E. Brown" <cbrown@woods.net>,
	Andreas Dilger <adilger@clusterfs.com>,
	"Griffiths, Richard A" <richard.a.griffiths@intel.com>,
	'Andrew Morton' <akpm@zip.com.au>, mgross@unix-os.sc.intel.com,
	'Jens Axboe' <axboe@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	lse-tech@lists.sourceforge.net
References: <20020623043310.GL22411@clusterfs.com> <Pine.LNX.4.44.0206222350070.30350-100000@spruce.woods.net> <20020623063543.GH25360@holomorphy.com> <3D1578D3.20909@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D1578D3.20909@us.ibm.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> On Sun, Jun 23, 2002 at 12:00:01AM -0600, Christopher E. Brown wrote:
>>> However, multiple busses are *rare* on x86.  There are alot of chained
>>> busses via PCI to PCI bridge, but few systems with 2 or more PCI
>>> busses of any type with parallel access to the CPU.

William Lee Irwin III wrote:
>> NUMA-Q has them.


On Sun, Jun 23, 2002 at 12:29:23AM -0700, Dave Hansen wrote:
> Yep, 2 independent busses per quad.  That's a _lot_ of busses when you 
> have an 8 or 16 quad system.  (I wonder who has one of those... ;)
> Almost all of the server-type boxes that we play with have multiple 
> PCI busses.  Even my old dual-PPro has 2.

I thought I saw 3 PCI and 1 ISA per-quad., but maybe that's the
"independent" bit coming into play.


Cheers,
Bill
