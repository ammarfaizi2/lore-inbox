Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317169AbSHGIsW>; Wed, 7 Aug 2002 04:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317170AbSHGIsW>; Wed, 7 Aug 2002 04:48:22 -0400
Received: from purple.csi.cam.ac.uk ([131.111.8.4]:1180 "EHLO
	purple.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317169AbSHGIsV>; Wed, 7 Aug 2002 04:48:21 -0400
Message-Id: <5.1.0.14.2.20020807094345.03ac2380@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 07 Aug 2002 09:52:26 +0100
To: andersen@codepoet.org
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [BK-PATCH-2.5] NTFS 2.0.24: Cleanups
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020807013250.GA30858@codepoet.org>
References: <E17cFG4-0007hW-00@storm.christs.cam.ac.uk>
 <E17cFG4-0007hW-00@storm.christs.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:32 07/08/02, Erik Andersen wrote:
>On Wed Aug 07, 2002 at 02:05:04AM +0100, Anton Altaparmakov wrote:
> >    - Do not allow read-write remounts of read-only volumes with errors.
>
>I thought the current NTFS driver does not yet support writing...

Correct, and if you look at the code you will notice the #ifdef NTFS_RW 
around it... The read-only compiled driver doesn't have any write related 
code. Only the read-write compiled driver has, but at the moment this is 
just adding necesary safety bits before starting to add actual write code. 
Writing is under development and you will be seing more and more bits 
related to it appearing. (-:

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

