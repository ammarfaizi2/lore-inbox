Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288662AbSAIKhA>; Wed, 9 Jan 2002 05:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289322AbSAIKgu>; Wed, 9 Jan 2002 05:36:50 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:37598 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S288662AbSAIKgf>; Wed, 9 Jan 2002 05:36:35 -0500
Message-Id: <5.1.0.14.2.20020109103716.026a0b20@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 09 Jan 2002 10:38:56 +0000
To: Greg KH <greg@kroah.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: initramfs programs (was [RFC] klibc requirements)
Cc: felix-dietlibc@fefe.de, linux-kernel@vger.kernel.org
In-Reply-To: <20020109043446.GB17655@kroah.com>
In-Reply-To: <20020109042331.GB31644@codeblau.de>
 <20020108192450.GA14734@kroah.com>
 <20020109042331.GB31644@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:34 09/01/02, Greg KH wrote:
>On Wed, Jan 09, 2002 at 05:23:31AM +0100, Felix von Leitner wrote:
> >
> > How many programs are we talking about here?  And what should they do?
>
>Very good question that we should probably answer first (I'll follow up
>to your other points in a separate message).
>
>Here's what I want to have in my initramfs:
>         - /sbin/hotplug
>         - /sbin/modprobe
>         - modules.dep (needed for modprobe, but is a text file)
>
>What does everyone else need/want there?

It is planned to move partition discovery to userspace which would then 
instruct the kernel of the positions of various partitions.

The program(s) to do this will need to be in pretty much everyones initramfs...

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

