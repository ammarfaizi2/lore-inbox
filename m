Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288957AbSAUB3O>; Sun, 20 Jan 2002 20:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288979AbSAUB3E>; Sun, 20 Jan 2002 20:29:04 -0500
Received: from red.csi.cam.ac.uk ([131.111.8.70]:15238 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S288957AbSAUB2x>;
	Sun, 20 Jan 2002 20:28:53 -0500
Message-Id: <5.1.0.14.2.20020121012849.02675c90@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 21 Jan 2002 01:31:20 +0000
To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Hardwired drivers are going away?
Cc: Frank van de Pol <fvdpol@home.nl>, Keith Owens <kaos@ocs.com.au>,
        Linux Kernel Maillist <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0201202004440.914-100000@filesrv1.baby-drago
 ns.com>
In-Reply-To: <5.1.0.14.2.20020121010328.02672020@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:07 21/01/02, Mr. James W. Laferriere wrote:
>On Mon, 21 Jan 2002, Anton Altaparmakov wrote:
> > At 23:20 20/01/02, Frank van de Pol wrote:
> > >On Sat, Jan 19, 2002 at 10:22:43AM +1100, Keith Owens wrote:
> > > > On Fri, 18 Jan 2002 17:20:02 -0500 (EST),
> > > > "Mr. James W. Laferriere" <babydr@baby-dragons.com> wrote:
> > > > >     Linux doesn't have a method to load encrypted & signed modules at
> > > > >     this time .
> > > > And never will.  Who loads the module - root.  Who maintains the list
> > > > of signatures - root.  Who controls the code that verifies the
> > > > signature - root.
> > > > Your task Jim, should you choose to accept it, is to make the kernel
> > > > distinguish between a good use of root and a malicious use by some who
> > > > has broken in and got root privileges.  When you can do that, then we
> > > > can add signed modules.
> > >If you want to secure your box, why don't you simply put a lock on it and
> > >throw away the key? Really, what might help the paranoid admins in 
> this case
> > >is a setting in the kernel which basically disables the ability to load or
> > >unload modules. Of course once set this setting can not been turned with
> > >rebooting the box.
>
> > Er that sounds like just disabling modules in the kernel altogether (kernel
> > compile option exists for this since the beginning of time)... I do that on
> > all servers I control. Not only for security reasons but also because I
> > suspect it produces smaller and probably faster kernels (I haven't tested
> > this in any way, just a guess).
>         This is just what the Heads are trying to do away with .  There
>         will only be module enabled kernels .  JimL

Ah! Serves me right for jumping into a thread without reading the previous 
posts... I better shut up as I have no idea why this is being done. From my 
unknowledgeable point of view it seems daft but there probably are good 
reasons... I suppose even non-modular kernels can be modified by the root 
user to be exploited, it's just a little bit harder...

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

