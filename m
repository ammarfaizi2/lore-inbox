Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316989AbSFWHpg>; Sun, 23 Jun 2002 03:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316991AbSFWHpf>; Sun, 23 Jun 2002 03:45:35 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:36233 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316989AbSFWHpf>; Sun, 23 Jun 2002 03:45:35 -0400
Message-ID: <3D157C7C.4080007@us.ibm.com>
Date: Sun, 23 Jun 2002 00:45:00 -0700
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
References: <20020623043310.GL22411@clusterfs.com> <Pine.LNX.4.44.0206222350070.30350-100000@spruce.woods.net> <20020623063543.GH25360@holomorphy.com> <3D1578D3.20909@us.ibm.com> <20020623073644.GK25360@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
 > On Sun, Jun 23, 2002 at 12:29:23AM -0700, Dave Hansen wrote:
 >> Yep, 2 independent busses per quad.  That's a _lot_ of busses
 >> when you have an 8 or 16 quad system.  (I wonder who has one of
 >> those... ;) Almost all of the server-type boxes that we play with
 >>  have multiple PCI busses.  Even my old dual-PPro has 2.
 >
 > I thought I saw 3 PCI and 1 ISA per-quad., but maybe that's the
 > "independent" bit coming into play.
 >
Hmmmm.  Maybe there is another one for the onboard devices.  I thought
that there were 8 slots and 4 per bus.  I could
be wrong.  BTW, the ISA slot is EISA and as far as I can tell is only
used for the MDC.


-- 
Dave Hansen
haveblue@us.ibm.com

