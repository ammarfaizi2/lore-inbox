Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266514AbRGLSvI>; Thu, 12 Jul 2001 14:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266508AbRGLSu6>; Thu, 12 Jul 2001 14:50:58 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:6152 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S266507AbRGLSuh>;
	Thu, 12 Jul 2001 14:50:37 -0400
Date: Thu, 12 Jul 2001 11:47:29 -0700
From: Greg KH <greg@kroah.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Hans Reiser <reiser@namesys.com>, LA Walsh <law@sgi.com>,
        reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com
Subject: Re: Security hooks, "standard linux security" & embedded use
Message-ID: <20010712114729.B735@kroah.com>
In-Reply-To: <3B49F602.DB39B3A@sgi.com> <3B4DDFD8.27C1C3D9@namesys.com> <5.1.0.14.2.20010712192608.0365e588@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.1.0.14.2.20010712192608.0365e588@pop.cus.cam.ac.uk>; from aia21@cam.ac.uk on Thu, Jul 12, 2001 at 07:37:36PM +0100
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2001 at 07:37:36PM +0100, Anton Altaparmakov wrote:
> 
> This seems very good in view of implementing ACL support for NTFS, too. - 
> We have all the NTFS layout knowledge to do it now. We just lack the 
> kernel/user space infrastructure.
> 
> When designing this modular security infrastructure it would be useful if 
> it is made generic enough to allow callbacks into user space for permission 
> checking.

The current model lets you do whatever you want in your kernel module.
It imposes no policy, that's up to you.

All the better to keep userspace callbacks for security out of my
kernels, for that way is ripe for problems (for specific examples why,
see the linux-security-module mailing list archives.)

thanks,

greg k-h
