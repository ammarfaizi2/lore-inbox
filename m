Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316997AbSFWIdQ>; Sun, 23 Jun 2002 04:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316999AbSFWIdP>; Sun, 23 Jun 2002 04:33:15 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:35262 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316997AbSFWIdO>;
	Sun, 23 Jun 2002 04:33:14 -0400
Message-ID: <3D158767.6050709@us.ibm.com>
Date: Sun, 23 Jun 2002 01:31:35 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Christopher E. Brown" <cbrown@woods.net>
CC: William Lee Irwin III <wli@holomorphy.com>,
       Andreas Dilger <adilger@clusterfs.com>,
       "Griffiths, Richard A" <richard.a.griffiths@intel.com>,
       "'Andrew Morton'" <akpm@zip.com.au>, mgross@unix-os.sc.intel.com,
       "'Jens Axboe'" <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: ext3 performance bottleneck as the number of spindles
 gets large
References: <Pine.LNX.4.44.0206230145000.30350-100000@spruce.woods.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher E. Brown wrote:
> Do you mean independent in that there are 2 sets of 4 slots each
> detected as a seperate PCI bus, or independent in that each set of 4
> had *direct* access to the cpu side, and *does not* access via a
> PCI:PCI bridge?

No PCI:PCI bridges, at least for NUMA-Q.
http://telia.dl.sourceforge.net/sourceforge/lse/linux_on_numaq.pdf

-- 
Dave Hansen
haveblue@us.ibm.com

