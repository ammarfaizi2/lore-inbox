Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318421AbSHEVFr>; Mon, 5 Aug 2002 17:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318888AbSHEVFr>; Mon, 5 Aug 2002 17:05:47 -0400
Received: from plum.csi.cam.ac.uk ([131.111.8.3]:52715 "EHLO
	plum.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S318421AbSHEVES>; Mon, 5 Aug 2002 17:04:18 -0400
Message-Id: <5.1.0.14.2.20020805215304.00b212d0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 05 Aug 2002 22:08:18 +0100
To: "Adam J. Richter" <adam@yggdrasil.com>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [Linux-NTFS-Dev] Patch: linux-2.5.30/fs/ntfs BUG_ON(cond1
  || cond2) bugs(!) and clean ups
Cc: linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20020805134130.A2627@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 21:41 05/08/02, Adam J. Richter wrote:
>         The following patch replaces all BUG_ON(condition1 || condition2)
>statements in fs/ntfs with separate BUG_ON statements, usually like so:
[snip]
>         I have attached the patch below.  I would like to get these
>changes into Linus's 2.5 tree.  Please let me know if you want to take
>it from here, if you want me to submit this patch to Linus or if you
>want me to do something else.

Thanks for the patch. Patch accepted and committed to my tree. It will be 
submitted with the next ntfs point release. I don't feel like this is 
enough for a release so I will wait to gather some more things before 
submitting so it may be a week or two, hope you don't mind the delay... If 
nothing comes up, I will just submit it on its own.

Note almost none of it applied because it was against 2.5.30 vanilla and 
ntfs has evolved two point releases since then and in fact some of your 
deltas were already there because mft_count has been eliminated. (-: But I 
did the changes by hand so no worries...

>Thanks for your time, and for maintaining the NT file system on Linux.

You are welcome. Thanks for your contribution. (-:

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

