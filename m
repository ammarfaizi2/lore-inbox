Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288998AbSAUBFC>; Sun, 20 Jan 2002 20:05:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288995AbSAUBEw>; Sun, 20 Jan 2002 20:04:52 -0500
Received: from red.csi.cam.ac.uk ([131.111.8.70]:56196 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S288921AbSAUBEm>;
	Sun, 20 Jan 2002 20:04:42 -0500
Message-Id: <5.1.0.14.2.20020121010328.02672020@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 21 Jan 2002 01:06:41 +0000
To: Frank van de Pol <fvdpol@home.nl>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Hardwired drivers are going away?
Cc: Keith Owens <kaos@ocs.com.au>,
        "Mr. James W. Laferriere" <babydr@baby-dragons.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020121002041.B1958@idefix.fvdpol.home.nl>
In-Reply-To: <14160.1011396163@ocs3.intra.ocs.com.au>
 <Pine.LNX.4.44.0201181632000.18867-100000@filesrv1.baby-dragons.com>
 <14160.1011396163@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 23:20 20/01/02, Frank van de Pol wrote:

>On Sat, Jan 19, 2002 at 10:22:43AM +1100, Keith Owens wrote:
> > On Fri, 18 Jan 2002 17:20:02 -0500 (EST),
> > "Mr. James W. Laferriere" <babydr@baby-dragons.com> wrote:
> > >     Linux doesn't have a method to load encrypted & signed modules at
> > >     this time .
> >
> > And never will.  Who loads the module - root.  Who maintains the list
> > of signatures - root.  Who controls the code that verifies the
> > signature - root.
> >
> > Your task Jim, should you choose to accept it, is to make the kernel
> > distinguish between a good use of root and a malicious use by some who
> > has broken in and got root privileges.  When you can do that, then we
> > can add signed modules.
>
>If you want to secure your box, why don't you simply put a lock on it and
>throw away the key? Really, what might help the paranoid admins in this case
>is a setting in the kernel which basically disables the ability to load or
>unload modules. Of course once set this setting can not been turned with
>rebooting the box.

Er that sounds like just disabling modules in the kernel altogether (kernel 
compile option exists for this since the beginning of time)... I do that on 
all servers I control. Not only for security reasons but also because I 
suspect it produces smaller and probably faster kernels (I haven't tested 
this in any way, just a guess).

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

