Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314294AbSD0Ru7>; Sat, 27 Apr 2002 13:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314303AbSD0Ru6>; Sat, 27 Apr 2002 13:50:58 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:62018 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S314294AbSD0Ru5>; Sat, 27 Apr 2002 13:50:57 -0400
Message-Id: <5.1.0.14.2.20020427184542.04000cd0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 27 Apr 2002 18:50:56 +0100
To: Christoph Lameter <christoph@lameter.com>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: 2.5.10-dj1 compilation failure
Cc: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0204271033010.5612-100000@k2-400.lameter.com
 >
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 18:35 27/04/02, Christoph Lameter wrote:
>That stuff might be useful in a CVS or BK() source code archive.
>What is the purpose of releasing a kernel tarball that does not compile?
>Kernel tarball are there to be compiled and tried out ....

You have that slightly wrong.

First, this is a development kernel, i.e. using it means it may not 
compile, it may not work, or worse, it may destroy all your data.

Second, the kernel compiles fine as long as you don't make use of any of 
the currently broken features. A blank statement "the kernel doesn't 
compile" is more often then not incorrect and should say "the kernel 
doesn't compile with my .config" instead.

The developmental kernel series is for that... Just as the block layer was 
"flaky" while Jens was working on it in early 2.5.x and just as IDE is 
"flaky" at the moment, now scsi is joining the club. (-;

If you want kernels that will compile and work you should be using 2.4.x or 
2.2.x kernels...

Best regards,

Anton

>On Sat, 27 Apr 2002, Dave Jones wrote:
>
> > On Sat, Apr 27, 2002 at 10:18:20AM -0700, Christoph Lameter wrote:
> >  > ide-scsi.c:837: unknown field `abort' specified in initializer
> >  > ide-scsi.c:837: warning: initialization from incompatible pointer type
> >  > ide-scsi.c:838: unknown field `reset' specified in initializer
> >  > ide-scsi.c:838: warning: initialization from incompatible pointer type
> >
> > http://lwn.net/daily/2.5.10-dj1-scsi.php3
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

