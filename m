Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315727AbSECVvr>; Fri, 3 May 2002 17:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315728AbSECVvp>; Fri, 3 May 2002 17:51:45 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:10286 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S315727AbSECVvj>; Fri, 3 May 2002 17:51:39 -0400
Message-Id: <5.1.0.14.2.20020503224831.00ac7520@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 03 May 2002 22:50:36 +0100
To: vda@port.imtp.ilyichevsk.odessa.ua
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [prepatch] address_space-based writeback
Cc: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
In-Reply-To: <200205031743.g43HhkX10360@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 23:47 03/05/02, Denis Vlasenko wrote:
>On 3 May 2002 10:49, Helge Hafting wrote:
> > Changing unix is doable _if_ you can show a significant benefit.
> > The more utilities you want to break, the more benefit you need to show.
> > I don't think you can send the inode to the land of
> > "8-char limited passwords" by pushing "simpler management of fstabs"
> > though.
>
>I'm afraid I can't present benefits big enough.
>
>I was thinking of fs driver (NFS,reiser,NTFS,FAT,...) developers'
>pain, not about my /etc/fstab editing.

NTFS has native inode numbers which are persistent across reboot so this is 
a non-issue. The only thing is that inode numbers on ntfs are 64 bit and 
not 32 bit but that is much a user space issue as a kernel issue...

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

