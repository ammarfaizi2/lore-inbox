Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317066AbSFWRRI>; Sun, 23 Jun 2002 13:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317068AbSFWRRI>; Sun, 23 Jun 2002 13:17:08 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50546 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S317066AbSFWRRH>; Sun, 23 Jun 2002 13:17:07 -0400
To: William Lee Irwin III <wli@holomorphy.com>
Cc: "Christopher E. Brown" <cbrown@woods.net>,
       Andreas Dilger <adilger@clusterfs.com>,
       "Griffiths, Richard A" <richard.a.griffiths@intel.com>,
       "'Andrew Morton'" <akpm@zip.com.au>, mgross@unix-os.sc.intel.com,
       "'Jens Axboe'" <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: ext3 performance bottleneck as the number of spindles gets large
References: <20020623043310.GL22411@clusterfs.com>
	<Pine.LNX.4.44.0206222350070.30350-100000@spruce.woods.net>
	<20020623063543.GH25360@holomorphy.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 23 Jun 2002 11:06:37 -0600
In-Reply-To: <20020623063543.GH25360@holomorphy.com>
Message-ID: <m18z55sz4y.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> writes:

> On Sun, Jun 23, 2002 at 12:00:01AM -0600, Christopher E. Brown wrote:
> > However, multiple busses are *rare* on x86.  There are alot of chained
> > busses via PCI to PCI bridge, but few systems with 2 or more PCI
> > busses of any type with parallel access to the CPU.
> 
> NUMA-Q has them.

As do the latest round of dual P4 Xeon chipsets.  The Intel E7500 and
the Serverworks Grand Champion.  

So on new systems this is easy to get if you want it.

Eric
