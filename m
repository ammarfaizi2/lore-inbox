Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133043AbRDRHSD>; Wed, 18 Apr 2001 03:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133044AbRDRHRw>; Wed, 18 Apr 2001 03:17:52 -0400
Received: from tinylinux.tip.CSIRO.AU ([130.155.192.102]:3847 "EHLO
	mobilix.atnf.CSIRO.AU") by vger.kernel.org with ESMTP
	id <S133043AbRDRHRj>; Wed, 18 Apr 2001 03:17:39 -0400
Date: Wed, 18 Apr 2001 17:17:16 +1000
Message-Id: <200104180717.f3I7HGR02019@mobilix.atnf.CSIRO.AU>
From: Richard Gooch <rgooch@atnf.csiro.au>
To: Russell Coker <russell@coker.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Mylex DAC vs RAM disk in 2.4.2 devfs
In-Reply-To: <01041713220107.28478@lyta>
In-Reply-To: <01041713220107.28478@lyta>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell Coker writes:
> I have just upgraded a machine with a Mylex DAC hardware RAID controller to 
> kernel 2.4.2 with devfs.
> 
> It seems that /dev/rd is used by both the RAM disk in the kernel and the 
> Mylex controller!
> 
> This is wrong of course, there are two problems, one is the situation of what 
> happens if you need both Mylex RAID and a RAM disk.  The other is the problem 
> that Mylex devices get treated as ram disks by devfsd which cause an upgrade 
> to break (the compatibility sym-links are not created correctly).
> I believe that the RAM disk should be changed as /dev/rd has been used by 
> Mylex controllers for a long time.  I am willing to submit patches to the 
> kernel and to devfsd if this suggestion is accepted and someone can suggest a 
> good directory name for ram-disks (I don't want to have the same problem 
> again).

Leonard and I are discussing the issue. We started at the kernel
summit, but didn't have time to continue. I've sent him an email.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
