Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289033AbSAIVz6>; Wed, 9 Jan 2002 16:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289037AbSAIVzu>; Wed, 9 Jan 2002 16:55:50 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:64440 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S289033AbSAIVzf>; Wed, 9 Jan 2002 16:55:35 -0500
Message-Id: <5.1.0.14.2.20020109215335.02cfc780@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 09 Jan 2002 21:55:34 +0000
To: Greg KH <greg@kroah.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: initramfs programs (was [RFC] klibc requirements)
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        felix-dietlibc@fefe.de, linux-kernel@vger.kernel.org
In-Reply-To: <20020109214022.GE21963@kroah.com>
In-Reply-To: <5.1.0.14.2.20020109213221.02dd5f80@pop.cus.cam.ac.uk>
 <5.1.0.14.2.20020109103716.026a0b20@pop.cus.cam.ac.uk>
 <5.1.0.14.2.20020109103716.026a0b20@pop.cus.cam.ac.uk>
 <5.1.0.14.2.20020109213221.02dd5f80@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 21:40 09/01/2002, Greg KH wrote:
>On Wed, Jan 09, 2002 at 09:34:34PM +0000, Anton Altaparmakov wrote:
> > Partition discovery is currently done within the kernel itself. The code
> > will effectively 'just' move out into user space. As such it is not 
> present
> > in /sbin now but it will be in initramfs. The same is true for various
> > other code I can imagine moving out of kernel mode into initramfs...
>
>For this code, I can see it staying in the kernel source tree, and being
>built as part of the kernel build process, right?

I would think that is a good idea but I am not sure that is what is planned 
/ will happen. Keeping it outside would have the advantage that a newer 
partition recognizer (or whatever other code) can be applied to any 
existing kernel version (that supports initramfs).

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

