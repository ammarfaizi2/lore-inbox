Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318086AbSFTBu6>; Wed, 19 Jun 2002 21:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318088AbSFTBu5>; Wed, 19 Jun 2002 21:50:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39950 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318086AbSFTBu4>;
	Wed, 19 Jun 2002 21:50:56 -0400
Message-ID: <3D11360F.4EA4807D@zip.com.au>
Date: Wed, 19 Jun 2002 18:55:27 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mgross@unix-os.sc.intel.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net, richard.a.griffiths@intel.com
Subject: Re: ext3 performance bottleneck as the number of spindles gets large
References: <200206200022.g5K0MKP27994@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mgross wrote:
> 
> We've been doing some throughput comparisons and benchmarks of block I/O
> throughput for 8KB writes as the number of SCSI addapters and drives per
> adapter is increased.
> 
> The Linux platform is a dual processor 1.2GHz PIII, 2Gig or RAM, 2U box.
> Similar results have been seen with both 2.4.16 and 2.4.18 base kernel, as
> well as one of those patched up O(1) 2.4.18 kernels out there.

umm.  Are you not using block-highmem?  That is a must-have.

http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre9aa2/00_block-highmem-all-18b-12.gz

-
