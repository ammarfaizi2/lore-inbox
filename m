Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291716AbSBHSje>; Fri, 8 Feb 2002 13:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291712AbSBHSjZ>; Fri, 8 Feb 2002 13:39:25 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:53123 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S291715AbSBHSjO>; Fri, 8 Feb 2002 13:39:14 -0500
Message-Id: <5.1.0.14.2.20020208183821.0386a7d0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 08 Feb 2002 18:40:00 +0000
To: Gunther Mayer <gunther.mayer@gmx.net>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Guest section DW: "Re: [PATCH] Fix floppy io
  portsreservation
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C64196F.CBA321AE@gmx.net>
In-Reply-To: <5.1.0.14.2.20020208160020.027998a0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 18:31 08/02/02, Gunther Mayer wrote:
>Anton Altaparmakov wrote:
>
> > Even if yours are affected you are unlikely to be wanting to enable PNPBIOS
> > support in the kernel for them. And as long as you don't do that everything
> > will continue to work as before my patch. The work around for this would be
> > for the PNPBIOS driver in the kernel not to reserve ports 0x3f0 and 0x3f1
> > on systems without a PNPBIOS. Thus on all recent systems PNPBIOS would take
> > over 0x3f0 and 0x3f1
>
>This is a misunderstanding.
>
>Compiling PNPBIOS into the kernel does _not_ mean 0x3f0 will be reserved.
>
>So the legacy floppy ports are not a PNPBIOS issue on any machine.

Excellent, in this case were my patch will always work and we are debating 
a non-issue and can stop here (unless I have broken any of the other 
architectures but I don't think I have). (-:

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

