Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129116AbRCVGLB>; Thu, 22 Mar 2001 01:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131237AbRCVGKu>; Thu, 22 Mar 2001 01:10:50 -0500
Received: from [216.18.81.170] ([216.18.81.170]:5640 "EHLO
	node0.opengeometry.com") by vger.kernel.org with ESMTP
	id <S129116AbRCVGKo>; Thu, 22 Mar 2001 01:10:44 -0500
Date: Thu, 22 Mar 2001 01:05:07 -0500
From: William Park <parkw@better.net>
To: Brian Dushaw <dushaw@munk.apl.washington.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA vt82c686b  and UDMA(100)
Message-ID: <20010322010507.A3170@better.net>
Mail-Followup-To: William Park <parkw@better.net>,
	Brian Dushaw <dushaw@munk.apl.washington.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0103212029540.3646-100000@munk.apl.washington.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.30.0103212029540.3646-100000@munk.apl.washington.edu>; from dushaw@munk.apl.washington.edu on Wed, Mar 21, 2001 at 08:40:21PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2001 at 08:40:21PM -0800, Brian Dushaw wrote:
> Dear Linux Kernel Wisemen,
>    I have been following the discussion of the VIA vt82c686b chipset
> and the troubles people have had in getting UDMA(100) to work.  This
> is to report that I have now tried the 2.4.2-ac20 kernel and the
> 2.2.18 kernel with Andre's patch (dated March 20) and neither of
> them get the disk speed up to where it ought to be.  hdparm -t reports
> back 11 MB/s or so for either kernel.
>    VIA82CXXX enabled, and I also tried the ide0=ata66 flag, in desparation.
>    At boot up both kernels report the disk as UDMA(100) - everything
> seems to be peachy keen, but for the sluggish disk performance.
> 
> Merely a report from the front lines,

Try 'hdparm -d1 -t', and see what you get.

:wq --William Park, Open Geometry Consulting, Linux/Python, 8 CPUs.
