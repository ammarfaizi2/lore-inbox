Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314680AbSFTGF1>; Thu, 20 Jun 2002 02:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318122AbSFTGF0>; Thu, 20 Jun 2002 02:05:26 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:24483 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S314680AbSFTGF0>;
	Thu, 20 Jun 2002 02:05:26 -0400
Date: Thu, 20 Jun 2002 08:05:08 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: mgross@unix-os.sc.intel.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net, richard.a.griffiths@intel.com
Subject: Re: ext3 performance bottleneck as the number of spindles gets large
Message-ID: <20020620060508.GL812@suse.de>
References: <200206200022.g5K0MKP27994@unix-os.sc.intel.com> <3D11360F.4EA4807D@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D11360F.4EA4807D@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19 2002, Andrew Morton wrote:
> mgross wrote:
> > 
> > We've been doing some throughput comparisons and benchmarks of block I/O
> > throughput for 8KB writes as the number of SCSI addapters and drives per
> > adapter is increased.
> > 
> > The Linux platform is a dual processor 1.2GHz PIII, 2Gig or RAM, 2U box.
> > Similar results have been seen with both 2.4.16 and 2.4.18 base kernel, as
> > well as one of those patched up O(1) 2.4.18 kernels out there.
> 
> umm.  Are you not using block-highmem?  That is a must-have.
> 
> http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre9aa2/00_block-highmem-all-18b-12.gz

please use

http://www.kernel.org/pub/linux/kernel/people/axboe/patches/v2.4/2.4.19-pre10/block-highmem-all-19.bz2

-- 
Jens Axboe

